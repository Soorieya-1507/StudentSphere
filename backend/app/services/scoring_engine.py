from sqlalchemy.orm import Session
from app.db.models import Achievement, AchievementCategory

def calculate_points(db: Session, category_id: str) -> int:
    category = db.query(AchievementCategory).filter(AchievementCategory.id == category_id).first()
    if category:
        return category.default_points
    return 0

def update_achievement_points(db: Session, achievement_id: str, status: str):
    achievement = db.query(Achievement).filter(Achievement.id == achievement_id).first()
    if not achievement:
        return None
        
    if status == "APPROVED":
        points = calculate_points(db, achievement.category_id)
        achievement.points_awarded = points
    else:
        achievement.points_awarded = 0
        
    db.commit()
    db.refresh(achievement)
    return achievement
