import uuid
import datetime
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db.database import get_db
from app.db.models import User
from app.db import models_phase6 as m6
from app.db import models_phase5 as m5
from app.db import models_phase4 as m4
from app.db import models as m3
from app.api.deps import get_current_user

router = APIRouter()

def calculate_student_crs(student_id: uuid.UUID, db: Session) -> float:
    cgpa_rec = db.query(m4.CGPARecord).filter(m4.CGPARecord.student_id == student_id).first()
    cgpa = cgpa_rec.cgpa if cgpa_rec else 0.0

    achievements = db.query(m3.Achievement).filter(m3.Achievement.student_id == student_id).all()
    internships = sum(1 for a in achievements if "internship" in a.title.lower() or "intern" in (a.description or "").lower())
    projects = sum(1 for a in achievements if "project" in a.title.lower())
    certifications = sum(1 for a in achievements if "certif" in a.title.lower())
    hackathons = sum(1 for a in achievements if "hackathon" in a.title.lower())

    # CRS = (CGPA x 0.30) + (Internships x 0.25) + (Projects x 0.20) + (Certifications x 0.15) + (Hackathons x 0.10)
    # CGPA normalized to 100 -> cgpa * 10
    crs = (cgpa * 10 * 0.30) + (min(internships * 25, 25)) + (min(projects * 10, 20)) + (min(certifications * 5, 15)) + (min(hackathons * 10, 10))
    crs = min(100.0, max(0.0, crs))
    return round(crs, 2)

def calculate_master_ssi(student_id: uuid.UUID, db: Session) -> m6.StudentSuccessIndex:
    # Gather inputs
    cgpa_rec = db.query(m4.CGPARecord).filter(m4.CGPARecord.student_id == student_id).first()
    cgpa = cgpa_rec.cgpa if cgpa_rec else 0.0

    att_recs = db.query(m4.AttendanceRecord).filter(m4.AttendanceRecord.student_id == student_id).all()
    attendance = sum(r.percentage for r in att_recs) / len(att_recs) if att_recs else 0.0

    achievements = db.query(m3.Achievement).filter(m3.Achievement.student_id == student_id).all()
    achievements_score = min(len(achievements) * 10, 100)

    crs = calculate_student_crs(student_id, db)
    
    pri_rec = db.query(m5.PlacementReadiness).filter(m5.PlacementReadiness.student_id == student_id).first()
    pri = pri_rec.score if pri_rec else 0.0

    research_papers = sum(1 for a in achievements if "research" in a.title.lower() or "paper" in a.title.lower())
    research_score = min(research_papers * 50, 100)

    # Simplified Skill Score for now
    skills = db.query(m6.SkillProfile).filter(m6.SkillProfile.student_id == student_id).all()
    skill_score = min(len(skills) * 10, 100)

    # SSI Formula
    ssi_val = (cgpa * 10 * 0.25) + (attendance * 0.10) + (achievements_score * 0.15) + (crs * 0.20) + (pri * 0.15) + (research_score * 0.10) + (skill_score * 0.05)
    ssi_val = min(100.0, max(0.0, round(ssi_val, 2)))

    category = "Emerging"
    if ssi_val >= 85: category = "Exceptional"
    elif ssi_val >= 70: category = "Strong"
    elif ssi_val >= 50: category = "Developing"
    else: category = "At Risk"

    ssi_record = db.query(m6.StudentSuccessIndex).filter(m6.StudentSuccessIndex.student_id == student_id).first()
    if not ssi_record:
        ssi_record = m6.StudentSuccessIndex(student_id=student_id)
        db.add(ssi_record)

    ssi_record.score = ssi_val
    ssi_record.category = category
    ssi_record.cgpa_factor = round(cgpa * 10, 2)
    ssi_record.attendance_factor = round(attendance, 2)
    ssi_record.achievements_factor = achievements_score
    ssi_record.crs_factor = crs
    ssi_record.pri_factor = pri
    ssi_record.research_factor = research_score
    ssi_record.skill_factor = skill_score
    ssi_record.snapshot_date = datetime.datetime.utcnow()
    
    db.commit()
    return ssi_record

@router.get("/crs/{student_id}")
def get_career_readiness(student_id: uuid.UUID, db: Session = Depends(get_db)):
    crs = calculate_student_crs(student_id, db)
    
    category = "Developing"
    if crs >= 80: category = "Exceptional"
    elif crs >= 65: category = "Industry Ready"
    elif crs >= 50: category = "Nearly Ready"
    elif crs < 30: category = "High Risk"

    profile = db.query(m6.CareerProfile).filter(m6.CareerProfile.student_id == student_id).first()
    if not profile:
        profile = m6.CareerProfile(student_id=student_id)
        db.add(profile)
    
    profile.career_readiness_score = crs
    profile.category = category
    db.commit()
    
    return {"crs": crs, "category": category}

@router.get("/ssi/{student_id}")
def get_student_success_index(student_id: uuid.UUID, db: Session = Depends(get_db)):
    ssi = calculate_master_ssi(student_id, db)
    return {
        "score": ssi.score,
        "category": ssi.category,
        "factors": {
            "cgpa": ssi.cgpa_factor,
            "attendance": ssi.attendance_factor,
            "achievements": ssi.achievements_factor,
            "crs": ssi.crs_factor,
            "pri": ssi.pri_factor,
            "research": ssi.research_factor,
            "skills": ssi.skill_factor
        }
    }

@router.get("/digital-twin/{student_id}")
def get_digital_twin(student_id: uuid.UUID, db: Session = Depends(get_db)):
    ssi = calculate_master_ssi(student_id, db)
    crs = calculate_student_crs(student_id, db)
    cgpa_rec = db.query(m4.CGPARecord).filter(m4.CGPARecord.student_id == student_id).first()
    att_recs = db.query(m4.AttendanceRecord).filter(m4.AttendanceRecord.student_id == student_id).all()
    attendance = sum(r.percentage for r in att_recs) / len(att_recs) if att_recs else 0.0
    arrears = db.query(m4.ArrearRecord).filter(m4.ArrearRecord.student_id == student_id, m4.ArrearRecord.status == "CURRENT").count()

    snapshot = {
        "academic": {
            "cgpa": cgpa_rec.cgpa if cgpa_rec else 0.0,
            "attendance": round(attendance, 2),
            "arrears": arrears
        },
        "career": {
            "crs": crs,
        },
        "ssi": ssi.score,
        "category": ssi.category
    }

    twin = db.query(m6.StudentDigitalTwin).filter(m6.StudentDigitalTwin.student_id == student_id).first()
    if not twin:
        twin = m6.StudentDigitalTwin(student_id=student_id)
        db.add(twin)
    
    twin.snapshot_data = snapshot
    twin.updated_at = datetime.datetime.utcnow()
    db.commit()

    return snapshot

@router.get("/roadmap/{student_id}")
def get_career_roadmap(student_id: uuid.UUID, db: Session = Depends(get_db)):
    # Generate a dummy AI roadmap
    steps = [
        {"title": "Complete Python Certification", "status": "pending", "type": "certification"},
        {"title": "Build Fullstack Web App", "status": "pending", "type": "project"},
        {"title": "Apply for Summer Internship", "status": "pending", "type": "internship"}
    ]
    roadmap = db.query(m6.CareerRoadmap).filter(m6.CareerRoadmap.student_id == student_id).first()
    if not roadmap:
        roadmap = m6.CareerRoadmap(student_id=student_id, target_role="Software Engineer", steps=steps)
        db.add(roadmap)
        db.commit()
    return {"target_role": roadmap.target_role, "steps": roadmap.steps}
