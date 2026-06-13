"""
Phase 4 – Risk Assessment & Academic Health Index Endpoints
============================================================
Routes:
  POST /risk/compute/{student_id}    – Compute risk for a student
  GET  /risk/student/{student_id}    – Get risk assessment for a student
  GET  /risk/department/{dept_id}    – Get risk summary for a department
  GET  /risk/ahi/student/{student_id}– Get Academic Health Index
"""
import uuid
from typing import List
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.db.database import get_db
from app.db.models import User
from app.db import models_phase4 as m4
from app.api.deps import get_current_user

router = APIRouter()

# ---------------------------------------------------------------------------
# Risk scoring logic (0-100, Green/Yellow/Orange/Red)
# ---------------------------------------------------------------------------

def _compute_risk_score(cgpa: float, avg_attendance: float, arrear_count: int) -> float:
    """
    Risk score (0-100):
      Attendance < 75% → +30 pts; < 60% → +50 pts (replaces the +30)
      Arrears >= 1     → +25 pts; >= 3  → +40 pts (replaces the +25)
      CGPA < 5.0       → +20 pts; < 4.0 → +35 pts (replaces the +20)
    """
    score = 0.0

    # Attendance penalty
    if avg_attendance < 60.0:
        score += 50
    elif avg_attendance < 75.0:
        score += 30

    # Arrear penalty
    if arrear_count >= 3:
        score += 40
    elif arrear_count >= 1:
        score += 25

    # CGPA penalty
    if cgpa < 4.0:
        score += 35
    elif cgpa < 5.0:
        score += 20

    return min(score, 100.0)


def _score_to_category(score: float) -> str:
    """Green: 0-25, Yellow: 26-50, Orange: 51-75, Red: 76-100"""
    if score <= 25:
        return "Green"
    elif score <= 50:
        return "Yellow"
    elif score <= 75:
        return "Orange"
    else:
        return "Red"


def _score_to_level(score: float) -> str:
    """Convert score to simple risk_level."""
    if score <= 25:
        return "LOW"
    elif score <= 50:
        return "MEDIUM"
    else:
        return "HIGH"


def _compute_ahi(cgpa: float, avg_attendance: float, arrear_count: int) -> float:
    """
    Academic Health Index (0-100):
      AHI = 0.5*(cgpa/10)*100 + 0.35*attendance + 0.15*(1 - min(arrears/5,1))*100
    """
    cgpa_score = (cgpa / 10.0) * 100.0
    att_score = min(avg_attendance, 100.0)
    arrear_penalty = (1 - min(arrear_count / 5.0, 1.0)) * 100.0
    return round(0.50 * cgpa_score + 0.35 * att_score + 0.15 * arrear_penalty, 2)


def _get_student_metrics(student_id: uuid.UUID, db: Session):
    """Return (cgpa, avg_attendance, arrear_count) for a student."""
    cgpa_record = db.query(m4.CGPARecord).filter(m4.CGPARecord.student_id == student_id).first()
    cgpa = cgpa_record.cgpa if cgpa_record else 0.0

    att_records = db.query(m4.AttendanceRecord).filter(
        m4.AttendanceRecord.student_id == student_id
    ).all()
    avg_attendance = (
        sum(r.percentage for r in att_records) / len(att_records) if att_records else 0.0
    )

    arrear_count = db.query(m4.ArrearRecord).filter(
        m4.ArrearRecord.student_id == student_id,
        m4.ArrearRecord.status == "CURRENT",
    ).count()

    return cgpa, avg_attendance, arrear_count


# ---------------------------------------------------------------------------
# Endpoints
# ---------------------------------------------------------------------------

@router.post("/compute/{student_id}")
def compute_risk(
    student_id: uuid.UUID,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Compute and store risk assessment for a student."""
    if current_user.role == "STUDENT":
        raise HTTPException(status_code=403, detail="Students cannot trigger risk computation")

    student = db.query(User).filter(User.id == student_id, User.role == "STUDENT").first()
    if not student:
        raise HTTPException(status_code=404, detail="Student not found")

    cgpa, avg_attendance, arrear_count = _get_student_metrics(student_id, db)
    risk_score = _compute_risk_score(cgpa, avg_attendance, arrear_count)
    risk_category = _score_to_category(risk_score)
    risk_level = _score_to_level(risk_score)

    # Upsert RiskAssessment record
    record = db.query(m4.RiskAssessment).filter(
        m4.RiskAssessment.student_id == student_id
    ).first()
    if record:
        record.risk_score = risk_score
        record.risk_category = risk_category
        record.risk_level = risk_level
        record.cgpa_snapshot = cgpa
        record.attendance_snapshot = avg_attendance
        record.arrear_count_snapshot = arrear_count
    else:
        record = m4.RiskAssessment(
            student_id=student_id,
            risk_score=risk_score,
            risk_category=risk_category,
            risk_level=risk_level,
            cgpa_snapshot=cgpa,
            attendance_snapshot=avg_attendance,
            arrear_count_snapshot=arrear_count,
        )
        db.add(record)
    db.commit()
    db.refresh(record)

    return {
        "student_id": str(student_id),
        "risk_score": risk_score,
        "risk_category": risk_category,
        "risk_level": risk_level,
        "cgpa": cgpa,
        "avg_attendance": round(avg_attendance, 2),
        "arrear_count": arrear_count,
    }


@router.get("/student/{student_id}")
def get_risk_for_student(
    student_id: uuid.UUID,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    record = db.query(m4.RiskAssessment).filter(
        m4.RiskAssessment.student_id == student_id
    ).first()
    if not record:
        raise HTTPException(status_code=404, detail="No risk assessment found for student")
    return {
        "student_id": str(student_id),
        "risk_score": record.risk_score,
        "risk_category": record.risk_category,
        "risk_level": record.risk_level,
        "cgpa": record.cgpa_snapshot,
        "avg_attendance": record.attendance_snapshot,
        "arrear_count": record.arrear_count_snapshot,
    }


@router.get("/department/{dept_id}")
def get_department_risk_summary(
    dept_id: uuid.UUID,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    if current_user.role == "STUDENT":
        raise HTTPException(status_code=403, detail="Access denied")

    students = db.query(User).filter(
        User.department_id == dept_id,
        User.role == "STUDENT"
    ).all()

    summary = {"Green": 0, "Yellow": 0, "Orange": 0, "Red": 0}
    for s in students:
        rec = db.query(m4.RiskAssessment).filter(
            m4.RiskAssessment.student_id == s.id
        ).first()
        if rec and rec.risk_category in summary:
            summary[rec.risk_category] += 1

    return {
        "department_id": str(dept_id),
        "total_students": len(students),
        "risk_summary": summary,
    }


# ---------------------------------------------------------------------------
# AHI endpoints
# ---------------------------------------------------------------------------

@router.get("/ahi/student/{student_id}")
def get_ahi(
    student_id: uuid.UUID,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    if current_user.role == "STUDENT" and current_user.id != student_id:
        raise HTTPException(status_code=403, detail="Cannot view other students' AHI")

    student = db.query(User).filter(User.id == student_id, User.role == "STUDENT").first()
    if not student:
        raise HTTPException(status_code=404, detail="Student not found")

    cgpa, avg_attendance, arrear_count = _get_student_metrics(student_id, db)
    ahi = _compute_ahi(cgpa, avg_attendance, arrear_count)
    risk_score = _compute_risk_score(cgpa, avg_attendance, arrear_count)
    risk_level = _score_to_level(risk_score)

    record = db.query(m4.AcademicHealthIndex).filter(
        m4.AcademicHealthIndex.student_id == student_id
    ).first()
    if record:
        record.ahi_score = ahi
        record.risk_level = risk_level
    else:
        record = m4.AcademicHealthIndex(
            student_id=student_id,
            ahi_score=ahi,
            risk_level=risk_level,
        )
        db.add(record)
    db.commit()

    return {
        "student_id": str(student_id),
        "ahi_score": ahi,
        "risk_level": risk_level,
        "cgpa": cgpa,
        "avg_attendance": round(avg_attendance, 2),
        "arrear_count": arrear_count,
    }
