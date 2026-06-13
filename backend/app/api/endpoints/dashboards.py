from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import func
from app.db.database import get_db
from app.db.models import User, Department, StudentProfile, FacultyProfile
from app.api.deps import get_current_user

router = APIRouter()

@router.get("/admin")
def get_admin_dashboard(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if current_user.role != "ADMIN":
        raise HTTPException(status_code=403, detail="Not authorized")
    
    # Fetch institute stats using User and Department tables
    total_students = db.query(User).filter(User.role == "STUDENT", User.institute_id == current_user.institute_id).count()
    total_faculty = db.query(User).filter(User.role.in_(["FACULTY", "HOD"]), User.institute_id == current_user.institute_id).count()
    total_departments = db.query(Department).filter(Department.institute_id == current_user.institute_id).count()
    return {
        "total_students": total_students,
        "total_faculty": total_faculty,
        "total_departments": total_departments,
    }

@router.get("/faculty")
def get_faculty_dashboard(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if current_user.role not in ["FACULTY", "HOD"]:
        raise HTTPException(status_code=403, detail="Not authorized")
        
    assigned_students = db.query(StudentProfile).filter(StudentProfile.mentor_id == current_user.id).count()
    
    pending_profiles = db.query(StudentProfile).join(User, StudentProfile.user_id == User.id).filter(
        StudentProfile.profile_status == "PENDING",
        User.department_id == current_user.department_id
    ).count()
    
    approved_profiles = db.query(StudentProfile).join(User, StudentProfile.user_id == User.id).filter(
        StudentProfile.profile_status == "APPROVED",
        User.department_id == current_user.department_id
    ).count()
    
    return {
        "assigned_students": assigned_students,
        "pending_profiles": pending_profiles,
        "approved_profiles": approved_profiles
    }

@router.get("/faculty/pending-students")
def get_pending_students(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if current_user.role not in ["FACULTY", "HOD"]:
        raise HTTPException(status_code=403, detail="Not authorized")
    
    students = db.query(StudentProfile, User.email).join(User, StudentProfile.user_id == User.id).filter(
        StudentProfile.profile_status == "PENDING",
        User.department_id == current_user.department_id
    ).all()
    
    result = []
    for sp, email in students:
        data = sp.__dict__.copy()
        data.pop('_sa_instance_state', None)
        data['email'] = email
        result.append(data)
    return result

@router.get("/student")
def get_student_dashboard(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if current_user.role != "STUDENT":
        raise HTTPException(status_code=403, detail="Not authorized")
        
    profile = db.query(StudentProfile).filter(StudentProfile.user_id == current_user.id).first()
    
    if not profile:
        return {
            "completion_percentage": 0,
            "uploaded_documents_count": 0,
            "approval_status": "NOT_STARTED",
            "rejection_reason": None
        }
        
    fields = [profile.roll_number, profile.gender, profile.father_name, profile.year_of_joining, profile.aadhaar_number]
    filled = sum(1 for f in fields if f is not None)
    completion_percentage = int((filled / len(fields)) * 100) if fields else 0
    
    docs = [profile.aadhaar_certificate_url, profile.community_certificate_url, profile.bank_passbook_url, profile.tenth_marksheet_url, profile.twelfth_marksheet_url]
    docs_count = sum(1 for d in docs if d is not None)
    
    return {
        "completion_percentage": completion_percentage,
        "uploaded_documents_count": docs_count,
        "approval_status": profile.profile_status,
        "rejection_reason": profile.rejection_reason
    }
