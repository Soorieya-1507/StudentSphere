"""
Phase 4 – Attendance Endpoints
=================================
Routes:
  POST /attendance/upload              – Upload attendance batch (faculty/HOD)
  GET  /attendance/student/{student_id} – Get attendance for a student
"""
import uuid
from typing import List, Optional
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from pydantic import BaseModel, validator

from app.db.database import get_db
from app.db.models import User
from app.db import models_phase4 as m4
from app.api.deps import get_current_user

router = APIRouter()


# ---------------------------------------------------------------------------
# Schemas
# ---------------------------------------------------------------------------

class StudentAttendance(BaseModel):
    student_id: uuid.UUID
    total_classes: int
    attended_classes: int

    @validator("total_classes")
    def validate_total(cls, v):
        if v < 0:
            raise ValueError("total_classes cannot be negative")
        return v

    @validator("attended_classes")
    def validate_attended(cls, v):
        if v < 0:
            raise ValueError("attended_classes cannot be negative")
        return v


class AttendanceUpload(BaseModel):
    subject_id: uuid.UUID
    month: str
    student_records: List[StudentAttendance] = []


class AttendanceRecordResponse(BaseModel):
    id: uuid.UUID
    student_id: uuid.UUID
    subject_id: uuid.UUID
    month: str
    total_classes: int
    attended_classes: int
    percentage: float

    class Config:
        from_attributes = True


def _categorize_attendance(pct: float) -> str:
    if pct >= 90:
        return "excellent"
    elif pct >= 75:
        return "good"
    elif pct >= 60:
        return "warning"
    else:
        return "critical"


# ---------------------------------------------------------------------------
# Endpoints
# ---------------------------------------------------------------------------

@router.post("/upload", response_model=List[AttendanceRecordResponse], status_code=201)
def upload_attendance(
    data: AttendanceUpload,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    if current_user.role == "STUDENT":
        raise HTTPException(status_code=403, detail="Students cannot upload attendance")
    if current_user.role == "HOD":
        raise HTTPException(status_code=403, detail="HOD cannot upload attendance directly")

    if not data.student_records:
        raise HTTPException(status_code=422, detail="student_records cannot be empty")

    # Validate subject exists
    subj = db.query(m4.Subject).filter(m4.Subject.id == data.subject_id).first()
    if not subj:
        raise HTTPException(status_code=404, detail="Subject not found")

    results = []
    for rec in data.student_records:
        # Validate attended <= total
        if rec.attended_classes > rec.total_classes:
            raise HTTPException(
                status_code=422,
                detail=f"attended_classes ({rec.attended_classes}) cannot exceed total_classes ({rec.total_classes})"
            )

        # Validate student exists
        student = db.query(User).filter(
            User.id == rec.student_id, User.role == "STUDENT"
        ).first()
        if not student:
            raise HTTPException(status_code=404, detail=f"Student {rec.student_id} not found")

        # Compute percentage
        pct = (rec.attended_classes / rec.total_classes * 100) if rec.total_classes > 0 else 0.0

        # Upsert: check for existing record
        existing = db.query(m4.AttendanceRecord).filter(
            m4.AttendanceRecord.student_id == rec.student_id,
            m4.AttendanceRecord.subject_id == data.subject_id,
            m4.AttendanceRecord.month == data.month,
        ).first()

        if existing:
            existing.total_classes = rec.total_classes
            existing.attended_classes = rec.attended_classes
            existing.percentage = pct
            db.commit()
            db.refresh(existing)
            results.append(existing)
        else:
            att = m4.AttendanceRecord(
                student_id=rec.student_id,
                subject_id=data.subject_id,
                month=data.month,
                total_classes=rec.total_classes,
                attended_classes=rec.attended_classes,
                percentage=pct,
            )
            db.add(att)
            db.commit()
            db.refresh(att)
            results.append(att)

    return results


@router.get("/student/{student_id}", response_model=List[AttendanceRecordResponse])
def get_student_attendance(
    student_id: uuid.UUID,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    # Students can only view their own attendance
    if current_user.role == "STUDENT" and current_user.id != student_id:
        raise HTTPException(status_code=403, detail="Cannot view other students' attendance")

    records = db.query(m4.AttendanceRecord).filter(
        m4.AttendanceRecord.student_id == student_id
    ).all()
    return records
