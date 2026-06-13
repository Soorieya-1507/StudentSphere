import uuid
from typing import List
from fastapi import APIRouter, Depends, HTTPException, UploadFile, File, Form
from sqlalchemy.orm import Session
from app.db.database import get_db
from app.db.models import User, Achievement, AchievementCategory, StudentProfile
from app.api.deps import get_current_user
from app.schemas.schemas import AchievementCreate, AchievementResponse
from app.services.validation_service import validate_file
from app.services.ai_validation import detect_duplicates

router = APIRouter()

@router.get("/categories", response_model=List[dict])
def get_categories(db: Session = Depends(get_db)):
    categories = db.query(AchievementCategory).all()
    return [{"id": str(c.id), "name": c.name, "default_points": c.default_points, "priority": c.priority} for c in categories]

@router.post("/", response_model=AchievementResponse)
def create_achievement(
    achievement: AchievementCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    if current_user.role != "STUDENT":
        raise HTTPException(status_code=403, detail="Only students can upload achievements")
        
    student_profile = db.query(StudentProfile).filter(StudentProfile.user_id == current_user.id).first()
    if not student_profile:
        raise HTTPException(status_code=404, detail="Student profile not found")

    dup_status, dup_conf = detect_duplicates(db, str(current_user.id), achievement.title, "")
    
    db_achievement = Achievement(
        student_id=current_user.id,
        department_id=student_profile.department_id,
        category_id=achievement.category_id,
        title=achievement.title,
        description=achievement.description,
        organization_name=achievement.organization_name,
        start_date=achievement.start_date,
        end_date=achievement.end_date,
        academic_year=achievement.academic_year,
        semester=achievement.semester,
        certificate_url=achievement.certificate_url,
        supporting_docs_url=achievement.supporting_docs_url,
        status=achievement.status,
        duplicate_status=dup_status,
        duplicate_confidence=dup_conf
    )
    db.add(db_achievement)
    db.commit()
    db.refresh(db_achievement)
    return db_achievement

@router.get("/", response_model=List[AchievementResponse])
def get_my_achievements(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return db.query(Achievement).filter(Achievement.student_id == current_user.id).all()
