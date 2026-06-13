from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import func
from app.db.database import get_db
from app.db.models import User, Achievement, StudentProfile, DepartmentRanking
from app.api.deps import get_current_user

router = APIRouter()

@router.get("/mentor-insights")
def get_mentor_insights(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if current_user.role not in ["FACULTY", "HOD"]:
        raise HTTPException(status_code=403, detail="Not authorized")
        
    students = db.query(StudentProfile).filter(StudentProfile.mentor_id == current_user.id).all()
    
    insights = []
    for sp in students:
        user = db.query(User).filter(User.id == sp.user_id).first()
        achievements = db.query(Achievement).filter(Achievement.student_id == sp.user_id).all()
        
        approved_count = sum(1 for a in achievements if a.status == "APPROVED")
        pending_count = sum(1 for a in achievements if a.status == "PENDING")
        total_points = sum(a.points_awarded for a in achievements if a.status == "APPROVED")
        
        insights.append({
            "student_id": sp.user_id,
            "student_name": user.email.split("@")[0],
            "approved_count": approved_count,
            "pending_count": pending_count,
            "total_points": total_points
        })
        
    # Sort by top performers
    top_performers = sorted(insights, key=lambda x: x["total_points"], reverse=True)[:5]
    least_active = [i for i in insights if i["total_points"] == 0]
    
    return {
        "all_students": insights,
        "top_performers": top_performers,
        "least_active": least_active
    }

@router.get("/department-rankings")
def get_department_rankings(db: Session = Depends(get_db)):
    rankings = db.query(DepartmentRanking).order_by(DepartmentRanking.department_score.desc()).all()
    return rankings
