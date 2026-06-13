import uuid
from typing import List
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db.database import get_db
from app.db.models import User, Achievement, ApprovalHistory, StudentProfile
from app.api.deps import get_current_user
from app.schemas.schemas import FacultyApprovalAction, AchievementResponse
from app.services.scoring_engine import update_achievement_points
from app.services.notification_service import create_notification

router = APIRouter()

@router.get("/queue", response_model=List[AchievementResponse])
def get_approval_queue(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if current_user.role not in ["FACULTY", "HOD"]:
        raise HTTPException(status_code=403, detail="Not authorized")
        
    # Faculty sees pending achievements from their department or mentored students
    # For now, just department
    achievements = db.query(Achievement).filter(
        Achievement.department_id == current_user.department_id,
        Achievement.status == "PENDING"
    ).all()
    
    return achievements

@router.post("/{achievement_id}/review")
def review_achievement(
    achievement_id: uuid.UUID,
    action: FacultyApprovalAction,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    if current_user.role not in ["FACULTY", "HOD"]:
        raise HTTPException(status_code=403, detail="Not authorized")
        
    achievement = db.query(Achievement).filter(Achievement.id == achievement_id).first()
    if not achievement:
        raise HTTPException(status_code=404, detail="Achievement not found")
        
    if action.action not in ["APPROVED", "REJECTED"]:
        raise HTTPException(status_code=400, detail="Invalid action")
        
    achievement.status = action.action
    db.commit()
    
    # Update points
    update_achievement_points(db, str(achievement.id), action.action)
    
    # Audit log
    history = ApprovalHistory(
        achievement_id=achievement.id,
        faculty_id=current_user.id,
        action=action.action,
        comments=action.comments
    )
    db.add(history)
    db.commit()
    
    # Notify student
    create_notification(
        db,
        str(achievement.student_id),
        f"Achievement {action.action.capitalize()}",
        f"Your achievement '{achievement.title}' has been {action.action.lower()}: {action.comments}"
    )
    
    return {"message": "Achievement reviewed successfully"}
