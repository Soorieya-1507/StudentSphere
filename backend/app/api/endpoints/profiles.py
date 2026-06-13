from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db.database import get_db
from app.db.models import User, StudentProfile, FacultyProfile
from app.schemas.schemas import StudentProfileUpdate, FacultyProfileUpdate, ApprovalAction
from app.api.deps import get_current_user

router = APIRouter()

@router.get("/student/me")
def get_my_student_profile(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if current_user.role != "STUDENT":
        raise HTTPException(status_code=403, detail="Not a student")
    profile = db.query(StudentProfile).filter(StudentProfile.user_id == current_user.id).first()
    return profile

@router.put("/student")
def update_student_profile(profile_data: StudentProfileUpdate, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if current_user.role != "STUDENT":
        raise HTTPException(status_code=403, detail="Not a student")
        
    profile = db.query(StudentProfile).filter(StudentProfile.user_id == current_user.id).first()
    if not profile:
        profile = StudentProfile(user_id=current_user.id, enrollment_number=current_user.email.split('@')[0], department_id=current_user.department_id)
        db.add(profile)
        db.commit()
        db.refresh(profile)
        
    update_data = profile_data.model_dump(exclude_unset=True)
    for key, value in update_data.items():
        setattr(profile, key, value)
        
    profile.profile_status = "PENDING"
    db.commit()
    db.refresh(profile)
    return profile

@router.get("/faculty/me")
def get_my_faculty_profile(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if current_user.role not in ["FACULTY", "HOD", "ADMIN"]:
        raise HTTPException(status_code=403, detail="Not authorized")
    profile = db.query(FacultyProfile).filter(FacultyProfile.user_id == current_user.id).first()
    return profile

@router.put("/faculty")
def update_faculty_profile(profile_data: FacultyProfileUpdate, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if current_user.role not in ["FACULTY", "HOD"]:
        raise HTTPException(status_code=403, detail="Not authorized")
        
    profile = db.query(FacultyProfile).filter(FacultyProfile.user_id == current_user.id).first()
    if not profile:
        profile = FacultyProfile(user_id=current_user.id, employee_id=current_user.email.split('@')[0], department_id=current_user.department_id)
        db.add(profile)
        db.commit()
        db.refresh(profile)
        
    update_data = profile_data.model_dump(exclude_unset=True)
    for key, value in update_data.items():
        setattr(profile, key, value)
        
    db.commit()
    db.refresh(profile)
    return profile

@router.put("/student/{student_id}/approve")
def approve_reject_student_profile(student_id: str, action: ApprovalAction, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if current_user.role not in ["FACULTY", "HOD", "ADMIN"]:
        raise HTTPException(status_code=403, detail="Not authorized")
        
    profile = db.query(StudentProfile).filter(StudentProfile.user_id == student_id).first()
    if not profile:
        raise HTTPException(status_code=404, detail="Student profile not found")
        
    profile.profile_status = action.status
    if action.status == "REJECTED":
        profile.rejection_reason = action.rejection_reason
    else:
        profile.rejection_reason = None
        
    db.commit()
    return {"message": f"Profile {action.status.lower()} successfully"}
