import uuid
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.db.database import get_db
from app.db import models_phase6 as m6
from app.db import models_phase4 as m4
from app.db import models as m3

router = APIRouter()

@router.get("/{student_id}")
def get_portfolio(student_id: uuid.UUID, db: Session = Depends(get_db)):
    student = db.query(m3.User).filter(m3.User.id == student_id).first()
    profile = db.query(m3.StudentProfile).filter(m3.StudentProfile.user_id == student_id).first()
    cgpa_rec = db.query(m4.CGPARecord).filter(m4.CGPARecord.student_id == student_id).first()
    achievements = db.query(m3.Achievement).filter(m3.Achievement.student_id == student_id).all()
    
    portfolio_data = {
        "name": student.email.split("@")[0].upper() if student else "Student",
        "email": student.email if student else "",
        "cgpa": cgpa_rec.cgpa if cgpa_rec else 0.0,
        "skills": ["Python", "React", "SQL", "Machine Learning"], # Mocked skills for now
        "achievements": [
            {
                "title": a.title,
                "organization": a.organization_name,
                "date": str(a.start_date)
            } for a in achievements
        ]
    }
    
    p_profile = db.query(m6.PortfolioProfile).filter(m6.PortfolioProfile.student_id == student_id).first()
    if not p_profile:
        p_profile = m6.PortfolioProfile(student_id=student_id, public_url_slug=str(uuid.uuid4())[:8])
        db.add(p_profile)
        db.commit()
        
    portfolio_data["public_url"] = f"/passport/{p_profile.public_url_slug}"
    return portfolio_data

@router.get("/public/{slug}")
def get_public_portfolio(slug: str, db: Session = Depends(get_db)):
    p_profile = db.query(m6.PortfolioProfile).filter(m6.PortfolioProfile.public_url_slug == slug).first()
    if not p_profile:
        return {"error": "Portfolio not found"}
    return get_portfolio(p_profile.student_id, db)
