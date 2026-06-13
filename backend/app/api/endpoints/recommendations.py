import uuid
from typing import List, Dict, Any
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.db.database import get_db
from app.db.models import User, Department
from app.api.deps import get_current_user
from app.api.endpoints.intelligence import calculate_department_health, calculate_student_pri

router = APIRouter()

@router.get("/department/{dept_id}")
def get_department_recommendations(dept_id: uuid.UUID, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if current_user.role not in ("HOD", "ADMIN"):
        raise HTTPException(status_code=403, detail="Insufficient privileges")
    if current_user.role == "HOD" and current_user.department_id != dept_id:
        raise HTTPException(status_code=403, detail="Cannot view other department recommendations")
        
    dhi = calculate_department_health(dept_id, db)
    
    recommendations = []
    if dhi.attendance_avg and dhi.attendance_avg < 75:
        recommendations.append("Attendance is below 75%. Implement mandatory daily monitoring.")
    if dhi.cgpa_avg and dhi.cgpa_avg < 6.5:
        recommendations.append("Average CGPA is low. Organize remedial classes for core subjects.")
    if dhi.arrears_avg and dhi.arrears_avg > 1.0:
        recommendations.append("High arrear rate detected. Assign dedicated mentors for struggling students.")
    if dhi.achievements_count < 10:
        recommendations.append("Low extracurricular participation. Encourage students to join hackathons and publish papers.")
        
    if not recommendations:
        recommendations.append("Department is performing well. Maintain current strategies.")
        
    return {"department_id": dept_id, "recommendations": recommendations}

@router.get("/student/{student_id}")
def get_student_recommendations(student_id: uuid.UUID, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if current_user.role == "STUDENT" and current_user.id != student_id:
        raise HTTPException(status_code=403, detail="Cannot view other student recommendations")
        
    pri = calculate_student_pri(student_id, db)
    
    recommendations = []
    if pri.cgpa_factor and pri.cgpa_factor < 7.0:
        recommendations.append("Your CGPA is below the typical placement threshold. Focus on academic improvement this semester.")
    if pri.internship_factor == 0:
        recommendations.append("You have no recorded internships. Secure an internship to boost your Placement Readiness Index.")
    if pri.project_factor == 0:
        recommendations.append("Participate in hackathons or build personal projects to improve your practical skills profile.")
        
    if not recommendations:
        recommendations.append("You are well-prepared for placements. Focus on advanced interview prep.")
        
    return {"student_id": student_id, "recommendations": recommendations}
