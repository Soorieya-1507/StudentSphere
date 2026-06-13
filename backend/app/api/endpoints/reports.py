import io
import uuid
import datetime
from typing import Optional
from fastapi import APIRouter, Depends, HTTPException
from fastapi.responses import StreamingResponse
from sqlalchemy.orm import Session
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter
import ollama

from app.db.database import get_db
from app.db.models import User, Department, Institute
from app.db import models_phase5 as m5
from app.db import models_phase4 as m4
from app.db import models as m3
from app.api.deps import get_current_user
from app.api.endpoints.intelligence import calculate_department_health

router = APIRouter()

def _require_admin(current_user: User):
    if current_user.role != "ADMIN":
        raise HTTPException(status_code=403, detail="Admin privileges required")

@router.get("/accreditation/{report_type}")
def get_accreditation_data(report_type: str, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    _require_admin(current_user)
    
    # Generate structured dataset for NAAC/NBA
    institute_id = current_user.institute_id
    students = db.query(User).filter(User.institute_id == institute_id, User.role == "STUDENT").count()
    faculty = db.query(User).filter(User.institute_id == institute_id, User.role == "FACULTY").count()
    
    achievements = db.query(m3.Achievement).join(User, m3.Achievement.student_id == User.id).filter(User.institute_id == institute_id).all()
    papers = len([a for a in achievements if "paper" in a.title.lower() or "research" in a.title.lower()])
    internships = len([a for a in achievements if "intern" in a.title.lower()])
    
    data = {
        "report_type": report_type.upper(),
        "student_strength": students,
        "faculty_strength": faculty,
        "publications": papers,
        "internships": internships,
        "total_achievements": len(achievements)
    }
    return data

@router.post("/generate-ai-insight")
def generate_ai_insight(report_type: str, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    _require_admin(current_user)
    data = get_accreditation_data(report_type, db, current_user)
    
    prompt = f"""
    Analyze the following institutional data for a {report_type} accreditation report:
    Students: {data['student_strength']}
    Faculty: {data['faculty_strength']}
    Publications: {data['publications']}
    Internships: {data['internships']}
    
    Provide a 2-paragraph summary highlighting strengths and areas for improvement.
    """
    try:
        response = ollama.chat(model='llama3.2', messages=[
            {'role': 'user', 'content': prompt}
        ])
        return {"insight": response['message']['content']}
    except Exception as e:
        return {"insight": f"AI Generation Failed. Please ensure Ollama is running. Error: {str(e)}"}

@router.get("/export/pdf")
def export_executive_report_pdf(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    _require_admin(current_user)
    
    buffer = io.BytesIO()
    p = canvas.Canvas(buffer, pagesize=letter)
    p.setFont("Helvetica-Bold", 16)
    p.drawString(100, 750, "StudentSphere Executive Report")
    
    p.setFont("Helvetica", 12)
    p.drawString(100, 720, f"Generated: {datetime.datetime.utcnow().strftime('%Y-%m-%d')}")
    
    # Basic Stats
    students = db.query(User).filter(User.institute_id == current_user.institute_id, User.role == "STUDENT").count()
    faculty = db.query(User).filter(User.institute_id == current_user.institute_id, User.role == "FACULTY").count()
    
    p.drawString(100, 680, f"Total Students: {students}")
    p.drawString(100, 660, f"Total Faculty: {faculty}")
    
    p.showPage()
    p.save()
    
    buffer.seek(0)
    return StreamingResponse(buffer, media_type="application/pdf", headers={"Content-Disposition": "attachment; filename=executive_report.pdf"})

@router.get("/export/csv")
def export_executive_report_csv(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    _require_admin(current_user)
    import csv
    
    buffer = io.StringIO()
    writer = csv.writer(buffer)
    writer.writerow(["Metric", "Value"])
    
    students = db.query(User).filter(User.institute_id == current_user.institute_id, User.role == "STUDENT").count()
    faculty = db.query(User).filter(User.institute_id == current_user.institute_id, User.role == "FACULTY").count()
    
    writer.writerow(["Total Students", students])
    writer.writerow(["Total Faculty", faculty])
    
    buffer.seek(0)
    return StreamingResponse(iter([buffer.getvalue()]), media_type="text/csv", headers={"Content-Disposition": "attachment; filename=executive_report.csv"})
