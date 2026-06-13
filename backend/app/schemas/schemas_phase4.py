from pydantic import BaseModel, Field
from typing import Optional, List, Dict, Any
from uuid import UUID
from datetime import datetime

class SemesterBase(BaseModel):
    department_id: UUID
    semester_number: int
    academic_year: str
    regulation: str
    start_date: Optional[datetime] = None
    end_date: Optional[datetime] = None

class SemesterCreate(SemesterBase):
    pass

class SemesterResponse(SemesterBase):
    id: UUID
    class Config:
        orm_mode = True

class SubjectBase(BaseModel):
    semester_id: UUID
    subject_code: str
    subject_name: str
    credits: int
    department_id: UUID

class SubjectCreate(SubjectBase):
    pass

class SubjectResponse(SubjectBase):
    id: UUID
    class Config:
        orm_mode = True

class InternalMarkBase(BaseModel):
    student_id: UUID
    subject_id: UUID
    internal_1: Optional[float] = None
    internal_2: Optional[float] = None
    assignment: Optional[float] = None
    model_exam: Optional[float] = None

class InternalMarkCreate(InternalMarkBase):
    pass

class InternalMarkResponse(InternalMarkBase):
    id: UUID
    class Config:
        orm_mode = True

class AttendanceUploadRequest(BaseModel):
    subject_id: UUID
    month: str
    student_records: List[Dict[str, Any]] # e.g. [{"student_id": "...", "total_classes": 20, "attended_classes": 18}]

class AttendanceRecordResponse(BaseModel):
    id: UUID
    student_id: UUID
    subject_id: UUID
    month: str
    total_classes: int
    attended_classes: int
    percentage: float
    class Config:
        orm_mode = True

class SemesterResultUploadRequest(BaseModel):
    subject_id: UUID
    student_results: List[Dict[str, Any]] # e.g. [{"student_id": "...", "grade": "A+", "status": "PASS"}]

class SemesterResultResponse(BaseModel):
    id: UUID
    student_id: UUID
    subject_id: UUID
    grade: str
    credits: int
    status: str
    class Config:
        orm_mode = True

class GPARecordResponse(BaseModel):
    id: UUID
    student_id: UUID
    semester_id: UUID
    gpa: float
    credits_earned: int
    class Config:
        orm_mode = True

class CGPARecordResponse(BaseModel):
    id: UUID
    student_id: UUID
    cgpa: float
    total_credits_earned: int
    updated_at: datetime
    class Config:
        orm_mode = True

class ArrearRecordResponse(BaseModel):
    id: UUID
    student_id: UUID
    subject_id: UUID
    attempt_number: int
    status: str
    cleared_date: Optional[datetime]
    class Config:
        orm_mode = True

class RiskAssessmentResponse(BaseModel):
    id: UUID
    student_id: UUID
    risk_score: float
    risk_category: str
    factors: Optional[str]
    updated_at: datetime
    class Config:
        orm_mode = True

class AcademicHealthIndexResponse(BaseModel):
    id: UUID
    student_id: UUID
    ahi_score: float
    updated_at: datetime
    class Config:
        orm_mode = True

class MentorFeedbackBase(BaseModel):
    student_id: UUID
    feedback_type: str
    content: str

class MentorFeedbackCreate(MentorFeedbackBase):
    pass

class MentorFeedbackResponse(MentorFeedbackBase):
    id: UUID
    mentor_id: UUID
    created_at: datetime
    class Config:
        orm_mode = True
