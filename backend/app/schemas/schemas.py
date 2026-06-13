from pydantic import BaseModel, EmailStr, validator, constr
from typing import Optional, List
import re
import uuid
from datetime import datetime

PASSWORD_REGEX = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{6,}$'

class UserCreate(BaseModel):
    email: EmailStr
    mobile_number: constr(pattern=r'^\d{10}$')
    password: str
    
    @validator('password')
    def validate_password(cls, v):
        if not re.match(PASSWORD_REGEX, v):
            raise ValueError('Password must contain at least 6 characters, including uppercase, lowercase, number, and special character.')
        return v

class AdminRegister(UserCreate):
    institute_name: str
    domain: str
    total_faculty: int
    total_students: int
    
    @validator('email')
    def validate_admin_email(cls, v):
        valid_suffixes = ('.edu', '.ac', '.edu.in', '.ac.in')
        if not any(v.endswith(suffix) for suffix in valid_suffixes):
            raise ValueError('Admin email must end with .edu, .ac, .edu.in, or .ac.in domain.')
        return v

class FacultyRegister(UserCreate):
    institute_id: uuid.UUID
    department_id: uuid.UUID

class StudentRegister(UserCreate):
    institute_id: uuid.UUID
    department_id: uuid.UUID

class UserLogin(BaseModel):
    email: EmailStr
    password: str

class Token(BaseModel):
    access_token: str
    token_type: str
    role: str

class DepartmentCreate(BaseModel):
    name: str

class DepartmentResponse(BaseModel):
    id: uuid.UUID
    name: str
    institute_id: uuid.UUID

    class Config:
        from_attributes = True

class InstituteResponse(BaseModel):
    id: uuid.UUID
    institute_id: str
    name: str

    class Config:
        from_attributes = True

class StudentProfileUpdate(BaseModel):
    roll_number: Optional[str] = None
    linkedin_url: Optional[str] = None
    gender: Optional[str] = None
    accommodation: Optional[str] = None
    
    father_name: Optional[str] = None
    father_mobile: Optional[str] = None
    father_occupation: Optional[str] = None
    mother_name: Optional[str] = None
    mother_mobile: Optional[str] = None
    mother_occupation: Optional[str] = None
    
    family_income: Optional[str] = None
    
    year_of_joining: Optional[int] = None
    year_of_passing: Optional[int] = None
    tenth_percentage: Optional[str] = None
    twelfth_percentage: Optional[str] = None
    
    school_name: Optional[str] = None
    school_address: Optional[str] = None
    home_address: Optional[str] = None
    
    aadhaar_number: Optional[str] = None

    @validator('aadhaar_number', pre=True, always=True)
    def validate_aadhaar(cls, v):
        if v is None or v == '':
            return None
        if not re.match(r'^\d{12}$', v):
            raise ValueError('Aadhaar number must be exactly 12 digits with no spaces.')
        return v
    
    aadhaar_certificate_url: Optional[str] = None
    community_certificate_url: Optional[str] = None
    bank_passbook_url: Optional[str] = None
    tenth_marksheet_url: Optional[str] = None
    twelfth_marksheet_url: Optional[str] = None

class FacultyProfileUpdate(BaseModel):
    profile_photo_url: Optional[str] = None
    qualification: Optional[str] = None
    experience: Optional[int] = None
    research_papers_count: Optional[int] = None
    research_areas: Optional[str] = None
    biography: Optional[str] = None

class MentorAssignmentCreate(BaseModel):
    faculty_id: uuid.UUID
    department_id: uuid.UUID
    batch_year: int

class ApprovalAction(BaseModel):
    status: str # APPROVED or REJECTED
    rejection_reason: Optional[str] = None
# =================================================
# PHASE 3 SCHEMAS
# =================================================

class AchievementCategoryResponse(BaseModel):
    id: uuid.UUID
    name: str
    default_points: int
    priority: str

    class Config:
        from_attributes = True

class AchievementCreate(BaseModel):
    category_id: uuid.UUID
    title: str
    description: Optional[str] = None
    organization_name: Optional[str] = None
    start_date: Optional[datetime] = None
    end_date: Optional[datetime] = None
    academic_year: Optional[int] = None
    semester: Optional[int] = None
    certificate_url: Optional[str] = None
    supporting_docs_url: Optional[str] = None
    status: Optional[str] = "DRAFT"

class AchievementResponse(AchievementCreate):
    id: uuid.UUID
    student_id: uuid.UUID
    department_id: uuid.UUID
    points_awarded: int
    status: str
    ocr_student_name: Optional[str] = None
    ocr_organization: Optional[str] = None
    ocr_event_name: Optional[str] = None
    ocr_date: Optional[str] = None
    duplicate_status: str
    duplicate_confidence: Optional[int] = None
    created_at: datetime

    class Config:
        from_attributes = True

class FacultyApprovalAction(BaseModel):
    action: str # APPROVED, REJECTED
    comments: str

class NotificationResponse(BaseModel):
    id: uuid.UUID
    title: str
    message: str
    is_read: bool
    created_at: datetime

    class Config:
        from_attributes = True

class PublicProfileResponse(BaseModel):
    public_profile_id: uuid.UUID
    name: str
    department: str
    academic_year: int
    total_score: int
    achievements: List[AchievementResponse]
