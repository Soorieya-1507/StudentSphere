import uuid
import datetime
from sqlalchemy import Column, String, Float, Integer, ForeignKey, DateTime, Text, JSON, Boolean
from sqlalchemy.dialects.postgresql import UUID
from app.db.database import Base

class CareerProfile(Base):
    __tablename__ = "career_profiles"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    career_readiness_score = Column(Float, default=0.0)
    category = Column(String, default="Developing") # Exceptional, Industry Ready, Nearly Ready, Developing, High Risk
    preferred_role = Column(String, nullable=True) # e.g. "Software Engineer"
    snapshot_date = Column(DateTime, default=datetime.datetime.utcnow)

class SkillProfile(Base):
    __tablename__ = "skill_profiles"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    skill_name = Column(String, nullable=False)
    proficiency = Column(String, default="Beginner") # Beginner, Intermediate, Advanced, Expert
    is_verified = Column(Boolean, default=False)
    source = Column(String, default="Self-Reported") # Self-Reported, Inferred

class SkillGapAnalysis(Base):
    __tablename__ = "skill_gap_analysis"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    target_role = Column(String, nullable=False)
    missing_skills = Column(JSON, nullable=True) # List of skills
    weak_skills = Column(JSON, nullable=True) # List of skills
    gap_score = Column(Float, default=0.0) # 0-100 where 100 means no gap
    analysis_date = Column(DateTime, default=datetime.datetime.utcnow)

class CareerRoadmap(Base):
    __tablename__ = "career_roadmaps"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    target_role = Column(String, nullable=False)
    steps = Column(JSON, nullable=False) # List of dicts: {"title": "", "status": "", "type": "certification|project|internship"}
    created_at = Column(DateTime, default=datetime.datetime.utcnow)

class PortfolioProfile(Base):
    __tablename__ = "portfolio_profiles"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    public_url_slug = Column(String, unique=True, nullable=False)
    is_public = Column(Boolean, default=True)
    theme = Column(String, default="modern")
    pdf_export_url = Column(String, nullable=True)
    created_at = Column(DateTime, default=datetime.datetime.utcnow)

class ResumeProfile(Base):
    __tablename__ = "resume_profiles"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    ats_score = Column(Float, default=0.0)
    compatibility_feedback = Column(Text, nullable=True)
    resume_type = Column(String, default="General") # Fresh Graduate, Research, Custom
    pdf_url = Column(String, nullable=True)
    docx_url = Column(String, nullable=True)
    generated_at = Column(DateTime, default=datetime.datetime.utcnow)

class AlumniRecord(Base):
    __tablename__ = "alumni_records"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    department_id = Column(UUID(as_uuid=True), ForeignKey("departments.id"), nullable=False)
    graduation_year = Column(Integer, nullable=False)
    outcome_type = Column(String, nullable=False) # PLACED, HIGHER_STUDIES, ENTREPRENEUR
    company_name = Column(String, nullable=True)
    role = Column(String, nullable=True)
    university_name = Column(String, nullable=True)

class RecruiterProfile(Base):
    __tablename__ = "recruiter_profiles"
    user_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), primary_key=True)
    company_name = Column(String, nullable=False)
    industry = Column(String, nullable=True)
    is_verified = Column(Boolean, default=False)

class RecruiterSearchLog(Base):
    __tablename__ = "recruiter_search_logs"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    recruiter_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    search_query = Column(String, nullable=True)
    filters_used = Column(JSON, nullable=True)
    timestamp = Column(DateTime, default=datetime.datetime.utcnow)

class StudentSuccessIndex(Base):
    __tablename__ = "student_success_index"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    score = Column(Float, default=0.0) # 0-100
    category = Column(String, default="Emerging")
    cgpa_factor = Column(Float, default=0.0)
    attendance_factor = Column(Float, default=0.0)
    achievements_factor = Column(Float, default=0.0)
    crs_factor = Column(Float, default=0.0)
    pri_factor = Column(Float, default=0.0)
    research_factor = Column(Float, default=0.0)
    skill_factor = Column(Float, default=0.0)
    snapshot_date = Column(DateTime, default=datetime.datetime.utcnow)

class StudentDigitalTwin(Base):
    __tablename__ = "student_digital_twins"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    snapshot_data = Column(JSON, nullable=False) # Complete JSON payload of the student's entire state
    updated_at = Column(DateTime, default=datetime.datetime.utcnow)

class LearningRecommendation(Base):
    __tablename__ = "learning_recommendations"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    item_type = Column(String, nullable=False) # COURSE, CERTIFICATION, PROJECT, COMPETITION
    title = Column(String, nullable=False)
    reason = Column(Text, nullable=True)
    status = Column(String, default="PENDING") # PENDING, IN_PROGRESS, COMPLETED

class CommunityPost(Base):
    __tablename__ = "community_posts"
    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    author_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    department_id = Column(UUID(as_uuid=True), ForeignKey("departments.id"), nullable=True)
    post_type = Column(String, nullable=False) # PROJECT_COLLAB, HACKATHON_TEAM, DISCUSSION
    title = Column(String, nullable=False)
    content = Column(Text, nullable=False)
    created_at = Column(DateTime, default=datetime.datetime.utcnow)
