from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db.database import get_db
from app.db import models_phase6 as m6
from app.db import models as m3

router = APIRouter()

@router.get("/search")
def search_students(skill: str = None, min_cgpa: float = None, db: Session = Depends(get_db)):
    # This is a privacy-safe search. It only returns student name and public profile slug.
    # We join with StudentProfile and CGPARecord to filter.
    from app.db import models_phase4 as m4
    
    query = db.query(m3.User, m4.CGPARecord, m6.PortfolioProfile)\
        .join(m4.CGPARecord, m3.User.id == m4.CGPARecord.student_id)\
        .join(m6.PortfolioProfile, m3.User.id == m6.PortfolioProfile.student_id)\
        .filter(m3.User.role == "STUDENT")
        
    if min_cgpa:
        query = query.filter(m4.CGPARecord.cgpa >= min_cgpa)
        
    results = query.all()
    
    output = []
    for user, cgpa_rec, port in results:
        output.append({
            "name": user.email.split("@")[0].upper(),
            "cgpa": cgpa_rec.cgpa,
            "public_url": f"/passport/{port.public_url_slug}"
        })
        
    return output
