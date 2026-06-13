import uuid
import datetime
from typing import List, Dict, Any
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy.sql import func

from app.db.database import get_db
from app.db.models import User, Department, Institute
from app.db import models_phase4 as m4
from app.db import models_phase5 as m5
from app.db import models as m3
from app.api.deps import get_current_user

router = APIRouter()

def _require_hod_or_above(current_user: User):
    if current_user.role not in ("HOD", "ADMIN"):
        raise HTTPException(status_code=403, detail="Insufficient privileges")

def _require_admin(current_user: User):
    if current_user.role != "ADMIN":
        raise HTTPException(status_code=403, detail="Admin privileges required")

def calculate_department_health(dept_id: uuid.UUID, db: Session) -> m5.DepartmentHealthIndex:
    # Get all students in department
    students = db.query(User).filter(User.department_id == dept_id, User.role == "STUDENT").all()
    if not students:
        return m5.DepartmentHealthIndex(department_id=dept_id, score=0, category="Critical")
    
    student_ids = [s.id for s in students]
    
    # 1. Attendance Avg
    att_recs = db.query(m4.AttendanceRecord).filter(m4.AttendanceRecord.student_id.in_(student_ids)).all()
    attendance_avg = sum(r.percentage for r in att_recs) / len(att_recs) if att_recs else 0.0
    
    # 2. CGPA Avg
    cgpa_recs = db.query(m4.CGPARecord).filter(m4.CGPARecord.student_id.in_(student_ids)).all()
    cgpa_avg = sum(r.cgpa for r in cgpa_recs) / len(cgpa_recs) if cgpa_recs else 0.0
    
    # 3. Arrears Avg
    arrear_recs = db.query(m4.ArrearRecord).filter(m4.ArrearRecord.student_id.in_(student_ids), m4.ArrearRecord.status == "CURRENT").all()
    arrears_avg = len(arrear_recs) / len(students)
    
    # 4. Achievements
    achievements = db.query(m3.Achievement).filter(m3.Achievement.student_id.in_(student_ids)).count()
    
    # Formula: 
    # Attendance (30%): (avg/100)*30
    # CGPA (40%): (cgpa/10)*40
    # Arrears (-10%): max(0, 10 - arrears_avg*5)
    # Achievements (20%): min(20, achievements * 2)
    
    score = (attendance_avg / 100 * 30) + (cgpa_avg / 10 * 40) + max(0, 10 - arrears_avg * 5) + min(20, achievements * 2)
    score = min(100.0, max(0.0, score))
    
    category = "Needs Improvement"
    if score >= 85: category = "Excellent"
    elif score >= 70: category = "Good"
    elif score >= 50: category = "Average"
    elif score < 30: category = "Critical"
    
    # Upsert DHI
    dhi = db.query(m5.DepartmentHealthIndex).filter(m5.DepartmentHealthIndex.department_id == dept_id).first()
    if not dhi:
        dhi = m5.DepartmentHealthIndex(department_id=dept_id)
        db.add(dhi)
    
    dhi.score = round(score, 2)
    dhi.category = category
    dhi.attendance_avg = round(attendance_avg, 2)
    dhi.cgpa_avg = round(cgpa_avg, 2)
    dhi.arrears_avg = round(arrears_avg, 2)
    dhi.achievements_count = achievements
    dhi.snapshot_date = datetime.datetime.utcnow()
    db.commit()
    return dhi

@router.get("/dhi/{dept_id}")
def get_department_health(dept_id: uuid.UUID, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    _require_hod_or_above(current_user)
    if current_user.role == "HOD" and current_user.department_id != dept_id:
        raise HTTPException(status_code=403, detail="Cannot view other department DHI")
    
    dhi = calculate_department_health(dept_id, db)
    return dhi

def calculate_student_pri(student_id: uuid.UUID, db: Session) -> m5.PlacementReadiness:
    cgpa_rec = db.query(m4.CGPARecord).filter(m4.CGPARecord.student_id == student_id).first()
    cgpa = cgpa_rec.cgpa if cgpa_rec else 0.0
    
    achievements = db.query(m3.Achievement).filter(m3.Achievement.student_id == student_id).all()
    internships = len([a for a in achievements if "intern" in a.title.lower()])
    projects = len([a for a in achievements if "project" in a.title.lower() or "hackathon" in a.title.lower()])
    
    # Simple Formula:
    # CGPA (50%): (cgpa/10)*50
    # Internships (30%): min(30, internships * 15)
    # Projects (20%): min(20, projects * 10)
    score = (cgpa / 10 * 50) + min(30, internships * 15) + min(20, projects * 10)
    
    category = "At Risk"
    if score >= 80: category = "Ready"
    elif score >= 60: category = "Nearly Ready"
    elif score >= 40: category = "Needs Improvement"
    
    pri = db.query(m5.PlacementReadiness).filter(m5.PlacementReadiness.student_id == student_id).first()
    if not pri:
        pri = m5.PlacementReadiness(student_id=student_id)
        db.add(pri)
    
    pri.score = round(score, 2)
    pri.category = category
    pri.cgpa_factor = cgpa
    pri.internship_factor = float(internships)
    pri.project_factor = float(projects)
    pri.snapshot_date = datetime.datetime.utcnow()
    db.commit()
    return pri

@router.get("/pri/{student_id}")
def get_placement_readiness(student_id: uuid.UUID, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if current_user.role == "STUDENT" and current_user.id != student_id:
        raise HTTPException(status_code=403, detail="Cannot view other student PRI")
    return calculate_student_pri(student_id, db)

def calculate_faculty_fii(faculty_id: uuid.UUID, db: Session) -> m5.FacultyImpactIndex:
    faculty = db.query(User).filter(User.id == faculty_id, User.role.in_(["FACULTY", "HOD"])).first()
    if not faculty:
        raise HTTPException(status_code=404, detail="Faculty not found")
        
    mentees = db.query(User).filter(User.role == "STUDENT").all()
    # Mocking mentees for now if mentor mapping isn't fully robust
    mentees = [m for m in mentees if True][:5] # limit to 5
    
    mentoring_score = 0.0
    student_growth_score = 0.0
    if mentees:
        scores = [calculate_student_pri(m.id, db).score for m in mentees]
        mentoring_score = sum(scores) / len(scores)
        student_growth_score = mentoring_score * 0.9 # placeholder logic
        
    score = (mentoring_score * 0.6) + (student_growth_score * 0.4)
    
    category = "Needs Improvement"
    if score >= 85: category = "Excellent"
    elif score >= 70: category = "Good"
    elif score >= 50: category = "Average"
    elif score < 30: category = "Critical"
    
    fii = db.query(m5.FacultyImpactIndex).filter(m5.FacultyImpactIndex.faculty_id == faculty_id).first()
    if not fii:
        fii = m5.FacultyImpactIndex(faculty_id=faculty_id)
        db.add(fii)
        
    fii.score = round(score, 2)
    fii.category = category
    fii.mentoring_score = round(mentoring_score, 2)
    fii.student_growth_score = round(student_growth_score, 2)
    fii.snapshot_date = datetime.datetime.utcnow()
    db.commit()
    return fii

@router.get("/fii/{faculty_id}")
def get_faculty_impact(faculty_id: uuid.UUID, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if current_user.role == "FACULTY" and current_user.id != faculty_id:
        raise HTTPException(status_code=403, detail="Cannot view other faculty FII")
    return calculate_faculty_fii(faculty_id, db)

@router.get("/iis")
def get_institution_intelligence_score(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    _require_admin(current_user)
    
    institute_id = current_user.institute_id
    departments = db.query(Department).filter(Department.institute_id == institute_id).all()
    
    if not departments:
        return {"score": 0, "category": "Emerging"}
    
    dhis = [calculate_department_health(d.id, db).score for d in departments]
    avg_dhi = sum(dhis) / len(dhis) if dhis else 0.0
    
    students = db.query(User).filter(User.institute_id == institute_id, User.role == "STUDENT").all()
    if students:
        pris = [calculate_student_pri(s.id, db).score for s in students]
        avg_pri = sum(pris) / len(pris) if pris else 0.0
    else:
        avg_pri = 0.0
        
    # IIS Formula: 60% DHI (Academic/Attendance/Arrears), 40% PRI (Placements/Internships/Projects)
    iis_score = (avg_dhi * 0.6) + (avg_pri * 0.4)
    
    category = "Emerging"
    if iis_score >= 85: category = "Model Institution"
    elif iis_score >= 70: category = "Excellent"
    elif iis_score >= 55: category = "Strong"
    elif iis_score >= 40: category = "Developing"
    
    iis = db.query(m5.InstitutionIntelligenceScore).filter(m5.InstitutionIntelligenceScore.institute_id == institute_id).first()
    if not iis:
        iis = m5.InstitutionIntelligenceScore(institute_id=institute_id)
        db.add(iis)
        
    iis.score = round(iis_score, 2)
    iis.category = category
    iis.academic_factor = round(avg_dhi, 2)
    iis.placement_factor = round(avg_pri, 2)
    iis.snapshot_date = datetime.datetime.utcnow()
    db.commit()
    
    return iis

@router.get("/predictive/students")
def get_predictive_students(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    _require_hod_or_above(current_user)
    
    # Find students needing intervention based on risk and PRI
    students = []
    query = db.query(User).filter(User.role == "STUDENT")
    if current_user.role == "HOD":
        query = query.filter(User.department_id == current_user.department_id)
        
    for s in query.all():
        risk = db.query(m4.RiskAssessment).filter(m4.RiskAssessment.student_id == s.id).first()
        if risk and risk.risk_category in ("Red", "Orange"):
            pred = db.query(m5.StudentSuccessPrediction).filter(m5.StudentSuccessPrediction.student_id == s.id).first()
            if not pred:
                pred = m5.StudentSuccessPrediction(
                    student_id=s.id,
                    dropout_risk=0.8 if risk.risk_category == "Red" else 0.5,
                    improvement_probability=0.3,
                    requires_intervention="YES",
                    confidence_score=0.85,
                    explanation=f"High risk score ({risk.risk_score}) due to poor attendance or arrears."
                )
                db.add(pred)
                db.commit()
            students.append(pred)
    return students
