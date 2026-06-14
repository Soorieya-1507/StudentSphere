"""
Phase 4 – Semester Results & GPA Endpoints
==========================================
Routes:
  POST /results/upload                     – Upload semester results (faculty/HOD)
  GET  /results/student/{student_id}       – Get results for a student
  GET  /results/student/{student_id}/gpa   – Get GPA records for a student
  GET  /results/student/{student_id}/cgpa  – Get current CGPA

Anna University 10-point grading scale:
  O=10, A+=9, A=8, B+=7, B=6, C=5, U=0 (fail)
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

# Anna University grade point mapping
GRADE_POINTS = {
    "O": 10, "A+": 9, "A": 8, "B+": 7, "B": 6, "C": 5, "RA": 0
}
VALID_GRADES = set(GRADE_POINTS.keys())

def calculate_grade_from_marks(marks: int) -> str:
    if marks >= 91: return "O"
    if marks >= 81: return "A+"
    if marks >= 71: return "A"
    if marks >= 61: return "B+"
    if marks >= 51: return "B"
    if marks >= 45: return "C"
    return "RA"

def determine_pass_fail(grade: str) -> str:
    return "FAIL" if grade == "RA" else "PASS"


# ---------------------------------------------------------------------------
# Schemas
# ---------------------------------------------------------------------------

class StudentResult(BaseModel):
    student_id: uuid.UUID
    marks: Optional[int] = None
    grade: Optional[str] = None

    @validator("grade", pre=True, always=True)
    def validate_grade(cls, v, values):
        marks = values.get("marks")
        if marks is not None:
            v = calculate_grade_from_marks(marks)
        if not v:
            raise ValueError("Either marks or grade must be provided")
        if v not in VALID_GRADES:
            raise ValueError(f"Invalid grade '{v}'. Must be one of: {sorted(VALID_GRADES)}")
        return v


class ResultUpload(BaseModel):
    subject_id: uuid.UUID
    semester_id: Optional[uuid.UUID] = None  # auto-derived from subject if not provided
    student_results: List[StudentResult]

    @validator("student_results")
    def validate_not_empty(cls, v):
        if not v:
            raise ValueError("student_results cannot be empty")
        return v


class SemesterResultResponse(BaseModel):
    id: uuid.UUID
    student_id: uuid.UUID
    subject_id: uuid.UUID
    semester_id: Optional[uuid.UUID] = None
    grade: str
    grade_point: float
    credits: int
    status: Optional[str] = None  # PASS / FAIL – used by arrear tests

    class Config:
        from_attributes = True


class GPARecordResponse(BaseModel):
    id: uuid.UUID
    student_id: uuid.UUID
    semester_id: uuid.UUID
    gpa: float
    total_credits: int

    class Config:
        from_attributes = True


class CGPAResponse(BaseModel):
    student_id: str
    cgpa: float
    total_semesters: int


# ---------------------------------------------------------------------------
# GPA calculation helpers
# ---------------------------------------------------------------------------

def _compute_gpa(results: List[m4.SemesterResult], db: Session) -> float:
    """Compute GPA = sum(credits * grade_points) / sum(credits)."""
    total_weighted = 0.0
    total_credits = 0
    for r in results:
        subj = db.query(m4.Subject).filter(m4.Subject.id == r.subject_id).first()
        credits = subj.credits if subj else 0
        gp = GRADE_POINTS.get(r.grade, 0)
        total_weighted += credits * gp
        total_credits += credits
    if total_credits == 0:
        return 0.0
    return round(total_weighted / total_credits, 2)


def _compute_cgpa(gpa_records: List[m4.GPARecord]) -> float:
    """CGPA = simple average of all semester GPAs (Anna University)."""
    if not gpa_records:
        return 0.0
    return round(sum(r.gpa for r in gpa_records) / len(gpa_records), 2)


def _handle_arrears(student_id: uuid.UUID, subject_id: uuid.UUID, grade: str, semester_id: uuid.UUID, db: Session):
    """Create or update ArrearRecord based on grade."""
    if grade == "RA":
        # Add or update arrear record
        existing = db.query(m4.ArrearRecord).filter(
            m4.ArrearRecord.student_id == student_id,
            m4.ArrearRecord.subject_id == subject_id,
            m4.ArrearRecord.status == "CURRENT",
        ).first()
        if not existing:
            arrear = m4.ArrearRecord(
                student_id=student_id,
                subject_id=subject_id,
                semester_id=semester_id,
                status="CURRENT",
                attempt_count=1,
            )
            db.add(arrear)
        else:
            existing.attempt_count = (existing.attempt_count or 0) + 1
    else:
        # Grade is a pass — clear any existing CURRENT arrear
        existing_arrear = db.query(m4.ArrearRecord).filter(
            m4.ArrearRecord.student_id == student_id,
            m4.ArrearRecord.subject_id == subject_id,
            m4.ArrearRecord.status == "CURRENT",
        ).first()
        if existing_arrear:
            existing_arrear.status = "CLEARED"
    db.commit()


# ---------------------------------------------------------------------------
# Endpoints
# ---------------------------------------------------------------------------

@router.post("/upload", response_model=List[SemesterResultResponse], status_code=201)
def upload_results(
    data: ResultUpload,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    if current_user.role == "STUDENT":
        raise HTTPException(status_code=403, detail="Students cannot upload results")
    if current_user.role == "HOD":
        raise HTTPException(status_code=403, detail="HOD cannot upload results")

    # Validate subject and semester
    subj = db.query(m4.Subject).filter(m4.Subject.id == data.subject_id).first()
    if not subj:
        raise HTTPException(status_code=404, detail="Subject not found")

    # Auto-derive semester_id from subject if not provided
    semester_id = data.semester_id or subj.semester_id
    sem = db.query(m4.Semester).filter(m4.Semester.id == semester_id).first()
    if not sem:
        raise HTTPException(status_code=404, detail="Semester not found")

    results = []
    affected_students = set()

    for r in data.student_results:
        # Validate student exists
        student = db.query(User).filter(User.id == r.student_id, User.role == "STUDENT").first()
        if not student:
            raise HTTPException(status_code=404, detail=f"Student {r.student_id} not found")

        grade_point = float(GRADE_POINTS[r.grade])
        result_status = determine_pass_fail(r.grade)

        # Upsert result
        existing = db.query(m4.SemesterResult).filter(
            m4.SemesterResult.student_id == r.student_id,
            m4.SemesterResult.subject_id == data.subject_id,
            m4.SemesterResult.semester_id == semester_id,
        ).first()

        if existing:
            existing.grade = r.grade
            existing.grade_point = grade_point
            existing.status = result_status
            db.commit()
            db.refresh(existing)
            result_obj = existing
        else:
            result_obj = m4.SemesterResult(
                student_id=r.student_id,
                subject_id=data.subject_id,
                semester_id=semester_id,
                grade=r.grade,
                grade_point=grade_point,
                credits=subj.credits,
                status=result_status,
            )
            db.add(result_obj)
            db.commit()
            db.refresh(result_obj)

        results.append(result_obj)
        affected_students.add(r.student_id)

        # Handle arrear tracking
        _handle_arrears(r.student_id, data.subject_id, r.grade, semester_id, db)

    # Recalculate GPA for each affected student
    for student_id in affected_students:
        sem_results = db.query(m4.SemesterResult).filter(
            m4.SemesterResult.student_id == student_id,
            m4.SemesterResult.semester_id == semester_id,
        ).all()

        gpa = _compute_gpa(sem_results, db)
        total_credits = sum(
            (db.query(m4.Subject).filter(m4.Subject.id == sr.subject_id).first().credits or 0)
            for sr in sem_results
        )

        # Upsert GPA record
        gpa_record = db.query(m4.GPARecord).filter(
            m4.GPARecord.student_id == student_id,
            m4.GPARecord.semester_id == semester_id,
        ).first()
        if gpa_record:
            gpa_record.gpa = gpa
            gpa_record.total_credits = total_credits
            gpa_record.credits_earned = total_credits
        else:
            gpa_record = m4.GPARecord(
                student_id=student_id,
                semester_id=semester_id,
                gpa=gpa,
                total_credits=total_credits,
                credits_earned=total_credits,
            )
            db.add(gpa_record)
        db.commit()

        # Recalculate CGPA
        all_gpa_records = db.query(m4.GPARecord).filter(
            m4.GPARecord.student_id == student_id
        ).all()
        cgpa = _compute_cgpa(all_gpa_records)

        cgpa_record = db.query(m4.CGPARecord).filter(
            m4.CGPARecord.student_id == student_id
        ).first()
        if cgpa_record:
            cgpa_record.cgpa = cgpa
            cgpa_record.total_credits_earned = total_credits
        else:
            cgpa_record = m4.CGPARecord(
                student_id=student_id,
                cgpa=cgpa,
                total_credits_earned=total_credits,
            )
            db.add(cgpa_record)
        db.commit()

    return results


@router.get("/student/{student_id}", response_model=List[SemesterResultResponse])
def get_student_results(
    student_id: uuid.UUID,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    if current_user.role == "STUDENT" and current_user.id != student_id:
        raise HTTPException(status_code=403, detail="Cannot view other students' results")

    results = db.query(m4.SemesterResult).filter(
        m4.SemesterResult.student_id == student_id
    ).all()
    return results


# Alias: /results/{student_id} (without /student/ prefix, for test compatibility)
@router.get("/{student_id}", response_model=List[SemesterResultResponse])
def get_student_results_alias(
    student_id: uuid.UUID,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Alias for /results/student/{student_id}."""
    if current_user.role == "STUDENT" and current_user.id != student_id:
        raise HTTPException(status_code=403, detail="Cannot view other students' results")

    results = db.query(m4.SemesterResult).filter(
        m4.SemesterResult.student_id == student_id
    ).all()
    return results


@router.get("/student/{student_id}/gpa", response_model=List[GPARecordResponse])
def get_student_gpa(
    student_id: uuid.UUID,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    if current_user.role == "STUDENT" and current_user.id != student_id:
        raise HTTPException(status_code=403, detail="Cannot view other students' GPA")

    records = db.query(m4.GPARecord).filter(
        m4.GPARecord.student_id == student_id
    ).all()
    return records


@router.get("/student/{student_id}/cgpa")
def get_student_cgpa(
    student_id: uuid.UUID,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    if current_user.role == "STUDENT" and current_user.id != student_id:
        raise HTTPException(status_code=403, detail="Cannot view other students' CGPA")

    cgpa_record = db.query(m4.CGPARecord).filter(
        m4.CGPARecord.student_id == student_id
    ).first()

    if not cgpa_record:
        return {"student_id": str(student_id), "cgpa": 0.0, "total_semesters": 0}

    all_gpa = db.query(m4.GPARecord).filter(
        m4.GPARecord.student_id == student_id
    ).all()

    return {
        "student_id": str(student_id),
        "cgpa": cgpa_record.cgpa,
        "total_semesters": len(all_gpa),
    }


@router.get("/department/{dept_id}/cgpa")
def get_department_cgpa(
    dept_id: uuid.UUID,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """Get average CGPA for a department (HOD/Admin accessible)."""
    students = db.query(User).filter(
        User.department_id == dept_id,
        User.role == "STUDENT"
    ).all()

    if not students:
        return {"department_id": str(dept_id), "average_cgpa": 0.0, "student_count": 0}

    cgpa_records = []
    for s in students:
        record = db.query(m4.CGPARecord).filter(m4.CGPARecord.student_id == s.id).first()
        if record:
            cgpa_records.append(record.cgpa)

    avg = round(sum(cgpa_records) / len(cgpa_records), 2) if cgpa_records else 0.0
    return {
        "department_id": str(dept_id),
        "average_cgpa": avg,
        "student_count": len(students),
        "students_with_cgpa": len(cgpa_records),
    }
