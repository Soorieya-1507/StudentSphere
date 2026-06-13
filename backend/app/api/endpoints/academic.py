"""
Phase 4 – Academic Module Endpoints
=====================================
Routes:
  POST /academic/semesters         – Create semester (faculty/admin/HOD)
  GET  /academic/semesters         – List semesters (with optional dept filter)
  GET  /academic/semesters/{id}    – Get semester by ID
  PUT  /academic/semesters/{id}    – Update semester
  DELETE /academic/semesters/{id}  – Delete semester

  POST /academic/subjects          – Create subject (faculty/admin/HOD)
  GET  /academic/subjects          – List subjects (with optional semester filter)
  GET  /academic/subjects/{id}     – Get subject by ID

  POST /academic/marks             – Enter/update internal marks (faculty only)
  GET  /academic/marks/{student_id} – Get marks for a student
"""
import uuid
import re
from datetime import datetime
from typing import Optional, List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from pydantic import BaseModel, validator

from app.db.database import get_db
from app.db.models import User
from app.db import models_phase4 as m4
from app.api.deps import get_current_user

router = APIRouter()

# ---------------------------------------------------------------------------
# Pydantic schemas
# ---------------------------------------------------------------------------

class SemesterCreate(BaseModel):
    department_id: uuid.UUID
    semester_number: int
    academic_year: str
    regulation: str
    start_date: Optional[datetime] = None
    end_date: Optional[datetime] = None

    @validator("semester_number")
    def validate_semester_number(cls, v):
        if v < 1:
            raise ValueError("semester_number must be a positive integer")
        return v

    @validator("academic_year")
    def validate_academic_year(cls, v):
        if not re.match(r"^\d{4}-\d{4}$", v):
            raise ValueError("academic_year must be in YYYY-YYYY format")
        parts = v.split("-")
        if int(parts[1]) != int(parts[0]) + 1:
            raise ValueError("academic_year second year must be first year + 1")
        return v


class SemesterUpdate(BaseModel):
    semester_number: Optional[int] = None
    academic_year: Optional[str] = None
    regulation: Optional[str] = None
    start_date: Optional[datetime] = None
    end_date: Optional[datetime] = None


class SemesterResponse(BaseModel):
    id: uuid.UUID
    department_id: uuid.UUID
    semester_number: int
    academic_year: str
    regulation: str
    start_date: Optional[datetime]
    end_date: Optional[datetime]

    class Config:
        from_attributes = True


class SubjectCreate(BaseModel):
    semester_id: uuid.UUID
    subject_code: str
    subject_name: str
    credits: int
    department_id: uuid.UUID

    @validator("credits")
    def validate_credits(cls, v):
        if v < 1:
            raise ValueError("credits must be >= 1")
        return v

    @validator("subject_code")
    def validate_subject_code(cls, v):
        if not v or not v.strip():
            raise ValueError("subject_code is required")
        return v.strip()


class SubjectResponse(BaseModel):
    id: uuid.UUID
    semester_id: uuid.UUID
    subject_code: str
    subject_name: str
    credits: int
    department_id: uuid.UUID

    class Config:
        from_attributes = True


class InternalMarkCreate(BaseModel):
    student_id: uuid.UUID
    subject_id: uuid.UUID
    internal_1: Optional[float] = None  # max 50
    internal_2: Optional[float] = None  # max 50
    assignment: Optional[float] = None  # max 20
    model_exam: Optional[float] = None  # max 100

    @validator("internal_1")
    def validate_internal_1(cls, v):
        if v is not None and (v < 0 or v > 50):
            raise ValueError("internal_1 must be between 0 and 50")
        return v

    @validator("internal_2")
    def validate_internal_2(cls, v):
        if v is not None and (v < 0 or v > 50):
            raise ValueError("internal_2 must be between 0 and 50")
        return v

    @validator("assignment")
    def validate_assignment(cls, v):
        if v is not None and (v < 0 or v > 20):
            raise ValueError("assignment must be between 0 and 20")
        return v

    @validator("model_exam")
    def validate_model_exam(cls, v):
        if v is not None and (v < 0 or v > 100):
            raise ValueError("model_exam must be between 0 and 100")
        return v


class InternalMarkResponse(BaseModel):
    id: uuid.UUID
    student_id: uuid.UUID
    subject_id: uuid.UUID
    internal_1: Optional[float]
    internal_2: Optional[float]
    assignment: Optional[float]
    model_exam: Optional[float]

    class Config:
        from_attributes = True


# ---------------------------------------------------------------------------
# Helper
# ---------------------------------------------------------------------------

def _require_faculty_or_above(current_user: User):
    """Raise 403 if user is a student."""
    if current_user.role == "STUDENT":
        raise HTTPException(status_code=403, detail="Students cannot perform this action")


def _require_faculty_only(current_user: User):
    """Raise 403 if user is NOT faculty or mentor (but allow HOD/ADMIN)."""
    if current_user.role == "STUDENT":
        raise HTTPException(status_code=403, detail="Students cannot perform this action")


def _require_admin_or_faculty(current_user: User):
    if current_user.role == "STUDENT":
        raise HTTPException(status_code=403, detail="Access denied")


# ---------------------------------------------------------------------------
# Semester endpoints
# ---------------------------------------------------------------------------

@router.post("/semesters", response_model=SemesterResponse, status_code=201)
def create_semester(
    data: SemesterCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    _require_faculty_or_above(current_user)
    # Check for duplicate
    existing = db.query(m4.Semester).filter(
        m4.Semester.department_id == data.department_id,
        m4.Semester.semester_number == data.semester_number,
        m4.Semester.academic_year == data.academic_year,
    ).first()
    if existing:
        raise HTTPException(status_code=409, detail="Semester already exists for this department/year")

    semester = m4.Semester(
        department_id=data.department_id,
        semester_number=data.semester_number,
        academic_year=data.academic_year,
        regulation=data.regulation,
        start_date=data.start_date,
        end_date=data.end_date,
    )
    db.add(semester)
    db.commit()
    db.refresh(semester)
    return semester


@router.get("/semesters", response_model=List[SemesterResponse])
def list_semesters(
    department_id: Optional[uuid.UUID] = None,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    q = db.query(m4.Semester)
    if department_id:
        q = q.filter(m4.Semester.department_id == department_id)
    return q.all()


@router.get("/semesters/{semester_id}", response_model=SemesterResponse)
def get_semester(
    semester_id: uuid.UUID,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    sem = db.query(m4.Semester).filter(m4.Semester.id == semester_id).first()
    if not sem:
        raise HTTPException(status_code=404, detail="Semester not found")
    return sem


@router.put("/semesters/{semester_id}", response_model=SemesterResponse)
def update_semester(
    semester_id: uuid.UUID,
    data: SemesterUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    _require_faculty_or_above(current_user)
    sem = db.query(m4.Semester).filter(m4.Semester.id == semester_id).first()
    if not sem:
        raise HTTPException(status_code=404, detail="Semester not found")
    for field, val in data.dict(exclude_none=True).items():
        setattr(sem, field, val)
    db.commit()
    db.refresh(sem)
    return sem


@router.delete("/semesters/{semester_id}", status_code=200)
def delete_semester(
    semester_id: uuid.UUID,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    _require_faculty_or_above(current_user)
    sem = db.query(m4.Semester).filter(m4.Semester.id == semester_id).first()
    if not sem:
        raise HTTPException(status_code=404, detail="Semester not found")
    db.delete(sem)
    db.commit()
    return {"message": "Semester deleted"}


# ---------------------------------------------------------------------------
# Subject endpoints
# ---------------------------------------------------------------------------

@router.post("/subjects", response_model=SubjectResponse, status_code=201)
def create_subject(
    data: SubjectCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    _require_faculty_or_above(current_user)
    # Check semester exists
    sem = db.query(m4.Semester).filter(m4.Semester.id == data.semester_id).first()
    if not sem:
        raise HTTPException(status_code=404, detail="Semester not found")
    # Check duplicate subject_code in the same semester
    existing = db.query(m4.Subject).filter(
        m4.Subject.semester_id == data.semester_id,
        m4.Subject.subject_code == data.subject_code,
    ).first()
    if existing:
        raise HTTPException(status_code=409, detail="Subject code already exists in this semester")

    subject = m4.Subject(
        semester_id=data.semester_id,
        subject_code=data.subject_code,
        subject_name=data.subject_name,
        credits=data.credits,
        department_id=data.department_id,
    )
    db.add(subject)
    db.commit()
    db.refresh(subject)
    return subject


@router.get("/subjects", response_model=List[SubjectResponse])
def list_subjects(
    semester_id: Optional[uuid.UUID] = None,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    q = db.query(m4.Subject)
    if semester_id:
        # Validate semester exists
        sem = db.query(m4.Semester).filter(m4.Semester.id == semester_id).first()
        if not sem:
            return []
        q = q.filter(m4.Subject.semester_id == semester_id)
    return q.all()


@router.get("/subjects/{subject_id}", response_model=SubjectResponse)
def get_subject(
    subject_id: uuid.UUID,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    subj = db.query(m4.Subject).filter(m4.Subject.id == subject_id).first()
    if not subj:
        raise HTTPException(status_code=404, detail="Subject not found")
    return subj


# ---------------------------------------------------------------------------
# Internal Marks endpoints
# ---------------------------------------------------------------------------

@router.post("/marks", response_model=InternalMarkResponse, status_code=201)
def enter_marks(
    data: InternalMarkCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    _require_faculty_only(current_user)
    if current_user.role == "STUDENT":
        raise HTTPException(status_code=403, detail="Students cannot enter marks")
    # HOD cannot enter marks
    if current_user.role == "HOD":
        raise HTTPException(status_code=403, detail="HOD cannot enter marks directly")

    # Check subject exists
    subj = db.query(m4.Subject).filter(m4.Subject.id == data.subject_id).first()
    if not subj:
        raise HTTPException(status_code=404, detail="Subject not found")
    # Check student exists
    student = db.query(User).filter(User.id == data.student_id, User.role == "STUDENT").first()
    if not student:
        raise HTTPException(status_code=404, detail="Student not found")

    # Upsert: update if exists, create if not
    existing = db.query(m4.InternalMark).filter(
        m4.InternalMark.student_id == data.student_id,
        m4.InternalMark.subject_id == data.subject_id,
    ).first()
    if existing:
        for field, val in data.dict(exclude_none=True, exclude={"student_id", "subject_id"}).items():
            setattr(existing, field, val)
        db.commit()
        db.refresh(existing)
        return existing

    mark = m4.InternalMark(
        student_id=data.student_id,
        subject_id=data.subject_id,
        internal_1=data.internal_1,
        internal_2=data.internal_2,
        assignment=data.assignment,
        model_exam=data.model_exam,
    )
    db.add(mark)
    db.commit()
    db.refresh(mark)
    return mark


# GET /marks?student_id=... (query parameter version used by tests)
@router.get("/marks", response_model=List[InternalMarkResponse])
def get_marks_by_query(
    student_id: Optional[uuid.UUID] = None,
    subject_id: Optional[uuid.UUID] = None,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Query marks by student_id and/or subject_id as query parameters."""
    if current_user.role == "STUDENT" and student_id and current_user.id != student_id:
        raise HTTPException(status_code=403, detail="Cannot view other students' marks")

    q = db.query(m4.InternalMark)
    if student_id:
        q = q.filter(m4.InternalMark.student_id == student_id)
    if subject_id:
        q = q.filter(m4.InternalMark.subject_id == subject_id)
    return q.all()


@router.get("/marks/{student_id}", response_model=List[InternalMarkResponse])
def get_marks_for_student(
    student_id: uuid.UUID,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    # Students can only view their own marks
    if current_user.role == "STUDENT" and current_user.id != student_id:
        raise HTTPException(status_code=403, detail="Cannot view other students' marks")
    marks = db.query(m4.InternalMark).filter(m4.InternalMark.student_id == student_id).all()
    return marks
