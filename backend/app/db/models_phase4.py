import uuid
from datetime import datetime
from sqlalchemy import Column, String, Boolean, ForeignKey, Integer, Float, DateTime, Enum, Text
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship
from app.db.database import Base

class Semester(Base):
    __tablename__ = "semesters"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    department_id = Column(UUID(as_uuid=True), ForeignKey("departments.id"), nullable=False)
    semester_number = Column(Integer, nullable=False)
    academic_year = Column(String, nullable=False) # e.g. "2024-2025"
    regulation = Column(String, nullable=False) # e.g. "R2021"
    start_date = Column(DateTime, nullable=True)
    end_date = Column(DateTime, nullable=True)
    
    department = relationship("Department", backref="semesters")
    subjects = relationship("Subject", back_populates="semester")

class Subject(Base):
    __tablename__ = "subjects"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    semester_id = Column(UUID(as_uuid=True), ForeignKey("semesters.id"), nullable=False)
    subject_code = Column(String, nullable=False)
    subject_name = Column(String, nullable=False)
    credits = Column(Integer, nullable=False)
    department_id = Column(UUID(as_uuid=True), ForeignKey("departments.id"), nullable=False)
    
    semester = relationship("Semester", back_populates="subjects")
    department = relationship("Department", backref="subjects")

class InternalMark(Base):
    __tablename__ = "internal_marks"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    subject_id = Column(UUID(as_uuid=True), ForeignKey("subjects.id"), nullable=False)
    internal_1 = Column(Float, nullable=True) # max 50
    internal_2 = Column(Float, nullable=True) # max 50
    assignment = Column(Float, nullable=True) # max 20
    model_exam = Column(Float, nullable=True) # max 100
    
    student = relationship("User", foreign_keys=[student_id])
    subject = relationship("Subject")

class AttendanceRecord(Base):
    __tablename__ = "attendance_records"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    subject_id = Column(UUID(as_uuid=True), ForeignKey("subjects.id"), nullable=False)
    month = Column(String, nullable=False) # e.g. "2024-08"
    total_classes = Column(Integer, nullable=False, default=0)
    attended_classes = Column(Integer, nullable=False, default=0)
    percentage = Column(Float, nullable=False, default=0.0)
    
    student = relationship("User", foreign_keys=[student_id])
    subject = relationship("Subject")

class SemesterResult(Base):
    __tablename__ = "semester_results"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    subject_id = Column(UUID(as_uuid=True), ForeignKey("subjects.id"), nullable=False)
    semester_id = Column(UUID(as_uuid=True), ForeignKey("semesters.id"), nullable=True)
    grade = Column(String, nullable=False) # O, A+, A, B+, B, C, U
    grade_point = Column(Float, nullable=False, default=0.0)
    credits = Column(Integer, nullable=False)
    status = Column(String, nullable=False, default="PASS") # PASS, FAIL
    
    student = relationship("User", foreign_keys=[student_id])
    subject = relationship("Subject")

class GPARecord(Base):
    __tablename__ = "gpa_records"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    semester_id = Column(UUID(as_uuid=True), ForeignKey("semesters.id"), nullable=False)
    gpa = Column(Float, nullable=False)
    total_credits = Column(Integer, nullable=False, default=0)
    credits_earned = Column(Integer, nullable=False, default=0)
    
    student = relationship("User", foreign_keys=[student_id])
    semester = relationship("Semester")

class CGPARecord(Base):
    __tablename__ = "cgpa_records"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    cgpa = Column(Float, nullable=False)
    total_credits_earned = Column(Integer, nullable=False, default=0)
    updated_at = Column(DateTime, default=datetime.utcnow)
    
    student = relationship("User", foreign_keys=[student_id])

class ArrearRecord(Base):
    __tablename__ = "arrear_records"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    subject_id = Column(UUID(as_uuid=True), ForeignKey("subjects.id"), nullable=False)
    semester_id = Column(UUID(as_uuid=True), ForeignKey("semesters.id"), nullable=True)
    attempt_number = Column(Integer, nullable=False, default=1)
    attempt_count = Column(Integer, nullable=False, default=1)
    status = Column(String, nullable=False, default="CURRENT") # CURRENT, CLEARED
    cleared_date = Column(DateTime, nullable=True)
    
    student = relationship("User", foreign_keys=[student_id])
    subject = relationship("Subject")

class RiskAssessment(Base):
    __tablename__ = "risk_assessments"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    risk_level = Column(String, nullable=False, default="LOW") # LOW, MEDIUM, HIGH
    risk_score = Column(Float, nullable=False, default=0.0) # 0-100 legacy
    risk_category = Column(String, nullable=False, default="Green") # Green, Yellow, Orange, Red
    cgpa_snapshot = Column(Float, nullable=True)
    attendance_snapshot = Column(Float, nullable=True)
    arrear_count_snapshot = Column(Integer, nullable=True, default=0)
    factors = Column(Text, nullable=True) # JSON dump of factors
    updated_at = Column(DateTime, default=datetime.utcnow)
    
    student = relationship("User", foreign_keys=[student_id])

class AcademicHealthIndex(Base):
    __tablename__ = "academic_health_index"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    ahi_score = Column(Float, nullable=False, default=0.0) # 0-100
    risk_level = Column(String, nullable=True, default="LOW") # LOW, MEDIUM, HIGH
    updated_at = Column(DateTime, default=datetime.utcnow)
    
    student = relationship("User", foreign_keys=[student_id])

class MentorFeedback(Base):
    __tablename__ = "mentor_feedback"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    mentor_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    feedback_type = Column(String, nullable=False) # e.g. "Note", "Comment", "Suggestion"
    content = Column(Text, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)
    
    student = relationship("User", foreign_keys=[student_id])
    mentor = relationship("User", foreign_keys=[mentor_id])
