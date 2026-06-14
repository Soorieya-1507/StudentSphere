import uuid
from datetime import datetime
from sqlalchemy import Column, String, Boolean, ForeignKey, Integer, Text, DateTime
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship
from app.db.database import Base

class Institute(Base):
    __tablename__ = "institutes"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    institute_id = Column(String, unique=True, index=True, nullable=False)  # Admin provided unique ID
    name = Column(String, nullable=False)
    total_faculty = Column(Integer, default=0)
    total_students = Column(Integer, default=0)
    domain = Column(String, unique=True, nullable=False)
    
    departments = relationship("Department", back_populates="institute")
    users = relationship("User", back_populates="institute")

class Department(Base):
    __tablename__ = "departments"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    name = Column(String, nullable=False)
    institute_id = Column(UUID(as_uuid=True), ForeignKey("institutes.id"), nullable=False)
    hod_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=True) # references HOD
    
    institute = relationship("Institute", back_populates="departments")
    users = relationship("User", back_populates="department", foreign_keys="User.department_id")

class User(Base):
    __tablename__ = "users"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    email = Column(String, unique=True, index=True, nullable=False)
    hashed_password = Column(String, nullable=False)
    role = Column(String, nullable=False) # 'ADMIN', 'FACULTY', 'HOD', 'MENTOR', 'STUDENT'
    name = Column(String, nullable=True)
    profile_photo_url = Column(String, nullable=True)
    mobile_number = Column(String, nullable=False)
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime, default=datetime.utcnow)
    
    institute_id = Column(UUID(as_uuid=True), ForeignKey("institutes.id"), nullable=True)
    department_id = Column(UUID(as_uuid=True), ForeignKey("departments.id"), nullable=True)
    
    institute = relationship("Institute", back_populates="users")
    department = relationship("Department", back_populates="users", foreign_keys=[department_id])

class StudentProfile(Base):
    __tablename__ = "student_profiles"
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), primary_key=True)
    enrollment_number = Column(String, unique=True, nullable=False)
    roll_number = Column(String, unique=True, nullable=True)
    department_id = Column(UUID(as_uuid=True), ForeignKey("departments.id"))
    batch_year = Column(Integer)
    mentor_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=True)
    
    # Phase 2 Details
    linkedin_url = Column(String, nullable=True)
    gender = Column(String, nullable=True)
    accommodation = Column(String, nullable=True)
    
    father_name = Column(String, nullable=True)
    father_mobile = Column(String, nullable=True)
    father_occupation = Column(String, nullable=True)
    mother_name = Column(String, nullable=True)
    mother_mobile = Column(String, nullable=True)
    mother_occupation = Column(String, nullable=True)
    
    family_income = Column(String, nullable=True)
    
    year_of_joining = Column(Integer, nullable=True)
    year_of_passing = Column(Integer, nullable=True)
    tenth_percentage = Column(String, nullable=True)
    twelfth_percentage = Column(String, nullable=True)
    
    school_name = Column(String, nullable=True)
    school_address = Column(String, nullable=True)
    home_address = Column(String, nullable=True)
    
    aadhaar_number = Column(String, nullable=True)
    
    # Documents
    aadhaar_certificate_url = Column(String, nullable=True)
    community_certificate_url = Column(String, nullable=True)
    bank_passbook_url = Column(String, nullable=True)
    tenth_marksheet_url = Column(String, nullable=True)
    twelfth_marksheet_url = Column(String, nullable=True)
    
    # Phase 3
    public_profile_id = Column(UUID(as_uuid=True), default=uuid.uuid4, unique=True)
    
    # Approval Workflow
    profile_status = Column(String, default="PENDING") # PENDING, APPROVED, REJECTED
    rejection_reason = Column(Text, nullable=True)

class FacultyProfile(Base):
    __tablename__ = "faculty_profiles"
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), primary_key=True)
    employee_id = Column(String, unique=True, nullable=False)
    department_id = Column(UUID(as_uuid=True), ForeignKey("departments.id"))
    
    # Phase 2 Details
    profile_photo_url = Column(String, nullable=True)
    qualification = Column(String, nullable=True)
    experience = Column(Integer, nullable=True)
    research_papers_count = Column(Integer, default=0)
    research_areas = Column(String, nullable=True)
    biography = Column(Text, nullable=True)

class MentorAssignment(Base):
    __tablename__ = "mentor_assignments"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    faculty_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    department_id = Column(UUID(as_uuid=True), ForeignKey("departments.id"), nullable=False)
    batch_year = Column(Integer, nullable=False)

class Course(Base):
    __tablename__ = "courses"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    code = Column(String, unique=True, nullable=False)
    name = Column(String, nullable=False)
    department_id = Column(UUID(as_uuid=True), ForeignKey("departments.id"))
    credits = Column(Integer)

class Enrollment(Base):
    __tablename__ = "enrollments"
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), primary_key=True)
    course_id = Column(UUID(as_uuid=True), ForeignKey("courses.id"), primary_key=True)
    semester = Column(Integer)

class Assignment(Base):
    __tablename__ = "assignments"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    course_id = Column(UUID(as_uuid=True), ForeignKey("courses.id"))
    faculty_id = Column(UUID(as_uuid=True), ForeignKey("users.id"))
    title = Column(String, nullable=False)
    description = Column(Text)
    due_date = Column(DateTime)

class Submission(Base):
    __tablename__ = "submissions"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    assignment_id = Column(UUID(as_uuid=True), ForeignKey("assignments.id"))
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"))
    content_url = Column(String)
    submitted_at = Column(DateTime, default=datetime.utcnow)
    grade = Column(String)
    feedback = Column(Text)

# =================================================
# PHASE 3 MODELS
# =================================================

class AchievementCategory(Base):
    __tablename__ = "achievement_categories"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    name = Column(String, unique=True, nullable=False) # e.g., 'Workshop', 'Hackathon'
    default_points = Column(Integer, default=0)
    priority = Column(String, default="MEDIUM") # HIGH, MEDIUM, LOW

class Achievement(Base):
    __tablename__ = "achievements"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"))
    department_id = Column(UUID(as_uuid=True), ForeignKey("departments.id"))
    category_id = Column(UUID(as_uuid=True), ForeignKey("achievement_categories.id"))
    
    title = Column(String, nullable=False)
    description = Column(Text)
    organization_name = Column(String)
    start_date = Column(DateTime)
    end_date = Column(DateTime)
    
    academic_year = Column(Integer)
    semester = Column(Integer)
    
    certificate_url = Column(String)
    supporting_docs_url = Column(String)
    
    status = Column(String, default="DRAFT") # DRAFT, PENDING, APPROVED, REJECTED
    points_awarded = Column(Integer, default=0)
    
    # AI / Validation Foundation
    ocr_student_name = Column(String, nullable=True)
    ocr_organization = Column(String, nullable=True)
    ocr_event_name = Column(String, nullable=True)
    ocr_date = Column(String, nullable=True)
    duplicate_status = Column(String, default="UNIQUE") # UNIQUE, DUPLICATE, SUSPECTED
    duplicate_confidence = Column(Integer, nullable=True)
    
    created_at = Column(DateTime, default=datetime.utcnow)
    
class ApprovalHistory(Base):
    __tablename__ = "approval_history"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    achievement_id = Column(UUID(as_uuid=True), ForeignKey("achievements.id"))
    faculty_id = Column(UUID(as_uuid=True), ForeignKey("users.id"))
    action = Column(String) # APPROVED, REJECTED
    comments = Column(Text)
    action_date = Column(DateTime, default=datetime.utcnow)

class Notification(Base):
    __tablename__ = "notifications"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id"))
    title = Column(String)
    message = Column(Text)
    is_read = Column(Boolean, default=False)
    created_at = Column(DateTime, default=datetime.utcnow)

class DepartmentRanking(Base):
    __tablename__ = "department_rankings"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    department_id = Column(UUID(as_uuid=True), ForeignKey("departments.id"))
    academic_year = Column(Integer)
    
    total_certificates = Column(Integer, default=0)
    total_internships = Column(Integer, default=0)
    total_projects = Column(Integer, default=0)
    total_research_papers = Column(Integer, default=0)
    total_hackathons = Column(Integer, default=0)
    
    department_score = Column(Integer, default=0)
    ranking = Column(Integer, nullable=True)
    calculated_at = Column(DateTime, default=datetime.utcnow)

from app.db.models_phase4 import *
from app.db.models_phase5 import *
from app.db.models_phase6 import *
