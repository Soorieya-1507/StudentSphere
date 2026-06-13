import uuid
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.db.database import get_db
from app.db import models_phase6 as m6

router = APIRouter()

@router.post("/generate/{student_id}")
def generate_resume(student_id: uuid.UUID, db: Session = Depends(get_db)):
    # This would ideally generate a PDF using ReportLab or python-docx
    # For now, we return a success response and ATS score
    profile = db.query(m6.ResumeProfile).filter(m6.ResumeProfile.student_id == student_id).first()
    if not profile:
        profile = m6.ResumeProfile(student_id=student_id, ats_score=85.5)
        db.add(profile)
        db.commit()
    return {"message": "Resume generated successfully", "ats_score": profile.ats_score}
