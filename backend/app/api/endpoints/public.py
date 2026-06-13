import uuid
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db.database import get_db
from app.db.models import StudentProfile, User, Department, Achievement
from app.schemas.schemas import PublicProfileResponse

router = APIRouter()

@router.get("/{public_id}", response_model=PublicProfileResponse)
def get_public_profile(public_id: uuid.UUID, db: Session = Depends(get_db)):
    profile = db.query(StudentProfile).filter(StudentProfile.public_profile_id == public_id).first()
    if not profile:
        raise HTTPException(status_code=404, detail="Public profile not found")
        
    user = db.query(User).filter(User.id == profile.user_id).first()
    dept = db.query(Department).filter(Department.id == profile.department_id).first()
    
    # Only return approved achievements to the public
    achievements = db.query(Achievement).filter(
        Achievement.student_id == profile.user_id,
        Achievement.status == "APPROVED"
    ).all()
    
    total_score = sum(a.points_awarded for a in achievements)
    
    return {
        "public_profile_id": profile.public_profile_id,
        "name": user.email.split("@")[0], # Real name not in user model yet, using email prefix
        "department": dept.name if dept else "Unknown",
        "academic_year": profile.batch_year or 2024,
        "total_score": total_score,
        "achievements": achievements
    }
