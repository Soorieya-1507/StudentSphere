"""
Phase 4 – HOD (Head of Department) Endpoints
==============================================
HOD has VIEW-ONLY rights to department academic data.
Routes:
  GET /hod/dept-summary        – Department-wide GPA, CGPA, attendance summary
  GET /hod/students            – List all students in HOD's department
  GET /hod/at-risk             – Students flagged as at-risk
"""
import uuid
from typing import List, Optional
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.db.database import get_db
from app.db.models import User
from app.db import models_phase4 as m4
from app.api.deps import get_current_user

router = APIRouter()


def _require_hod_or_above(current_user: User):
    if current_user.role not in ("HOD", "ADMIN"):
        raise HTTPException(status_code=403, detail="Only HOD or Admin can access this endpoint")


@router.get("/dept-summary")
def get_dept_summary(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Department-wide academic summary for HOD."""
    _require_hod_or_above(current_user)

    dept_id = current_user.department_id
    if not dept_id:
        raise HTTPException(status_code=400, detail="User has no department assigned")

    # All students in this department
    students = db.query(User).filter(
        User.department_id == dept_id,
        User.role == "STUDENT"
    ).all()

    total_students = len(students)

    # Compute average CGPA
    cgpa_records = []
    for s in students:
        rec = db.query(m4.CGPARecord).filter(m4.CGPARecord.student_id == s.id).first()
        if rec:
            cgpa_records.append(rec.cgpa)

    avg_cgpa = round(sum(cgpa_records) / len(cgpa_records), 2) if cgpa_records else 0.0

    # Compute average attendance
    att_pcts = []
    for s in students:
        recs = db.query(m4.AttendanceRecord).filter(m4.AttendanceRecord.student_id == s.id).all()
        if recs:
            avg_pct = sum(r.percentage for r in recs) / len(recs)
            att_pcts.append(avg_pct)

    avg_attendance = round(sum(att_pcts) / len(att_pcts), 2) if att_pcts else 0.0

    # Risk summary
    risk_summary = {"Green": 0, "Yellow": 0, "Orange": 0, "Red": 0}
    for s in students:
        risk_rec = db.query(m4.RiskAssessment).filter(m4.RiskAssessment.student_id == s.id).first()
        if risk_rec and risk_rec.risk_category in risk_summary:
            risk_summary[risk_rec.risk_category] += 1

    return {
        "department_id": str(dept_id),
        "total_students": total_students,
        "average_cgpa": avg_cgpa,
        "avg_cgpa": avg_cgpa,  # alias
        "avg_attendance": avg_attendance,
        "risk_summary": risk_summary,
    }


@router.get("/students")
def get_dept_students(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """List all students in HOD's department."""
    _require_hod_or_above(current_user)

    dept_id = current_user.department_id
    students = db.query(User).filter(
        User.department_id == dept_id,
        User.role == "STUDENT"
    ).all()

    return [
        {"id": str(s.id), "email": s.email, "role": s.role}
        for s in students
    ]


@router.get("/at-risk")
def get_at_risk_students(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Students with risk_category Red or Orange in HOD's department."""
    _require_hod_or_above(current_user)

    dept_id = current_user.department_id
    students = db.query(User).filter(
        User.department_id == dept_id,
        User.role == "STUDENT"
    ).all()

    at_risk = []
    for s in students:
        rec = db.query(m4.RiskAssessment).filter(m4.RiskAssessment.student_id == s.id).first()
        if rec and rec.risk_category in ("Orange", "Red"):
            at_risk.append({
                "student_id": str(s.id),
                "email": s.email,
                "risk_category": rec.risk_category,
                "risk_score": rec.risk_score,
            })

    return {"at_risk_students": at_risk, "count": len(at_risk)}
