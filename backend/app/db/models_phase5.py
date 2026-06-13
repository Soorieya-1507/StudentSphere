import uuid
import datetime
from sqlalchemy import Column, String, Float, Integer, ForeignKey, DateTime, Text, JSON
from sqlalchemy.dialects.postgresql import UUID

from app.db.database import Base

class DepartmentHealthIndex(Base):
    __tablename__ = "department_health_index"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    department_id = Column(UUID(as_uuid=True), ForeignKey("departments.id"), nullable=False)
    score = Column(Float, nullable=False, default=0.0) # 0-100
    category = Column(String, nullable=False, default="Needs Improvement") # Excellent, Good, Average, Needs Improvement, Critical
    attendance_avg = Column(Float, nullable=True)
    cgpa_avg = Column(Float, nullable=True)
    arrears_avg = Column(Float, nullable=True)
    achievements_count = Column(Integer, nullable=True, default=0)
    snapshot_date = Column(DateTime, default=datetime.datetime.utcnow)

class FacultyImpactIndex(Base):
    __tablename__ = "faculty_impact_index"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    faculty_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    score = Column(Float, nullable=False, default=0.0) # 0-100
    category = Column(String, nullable=False, default="Needs Improvement")
    mentoring_score = Column(Float, nullable=True)
    student_growth_score = Column(Float, nullable=True)
    snapshot_date = Column(DateTime, default=datetime.datetime.utcnow)

class PlacementReadiness(Base):
    __tablename__ = "placement_readiness"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    score = Column(Float, nullable=False, default=0.0) # 0-100
    category = Column(String, nullable=False, default="Needs Improvement") # Ready, Nearly Ready, Needs Improvement, At Risk
    cgpa_factor = Column(Float, nullable=True)
    internship_factor = Column(Float, nullable=True)
    project_factor = Column(Float, nullable=True)
    snapshot_date = Column(DateTime, default=datetime.datetime.utcnow)

class InternshipGapAnalysis(Base):
    __tablename__ = "internship_gap_analysis"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    department_id = Column(UUID(as_uuid=True), ForeignKey("departments.id"), nullable=False)
    academic_year = Column(String, nullable=False)
    participation_rate = Column(Float, nullable=False, default=0.0)
    gap_score = Column(Float, nullable=False, default=0.0)
    snapshot_date = Column(DateTime, default=datetime.datetime.utcnow)

class StudentSuccessPrediction(Base):
    __tablename__ = "student_success_predictions"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    student_id = Column(UUID(as_uuid=True), ForeignKey("users.id"), nullable=False)
    improvement_probability = Column(Float, nullable=False, default=0.0) # 0-1
    dropout_risk = Column(Float, nullable=False, default=0.0) # 0-1
    requires_intervention = Column(String, nullable=False, default="NO") # YES, NO
    confidence_score = Column(Float, nullable=False, default=0.0) # 0-1
    explanation = Column(Text, nullable=True)
    snapshot_date = Column(DateTime, default=datetime.datetime.utcnow)

class AccreditationReport(Base):
    __tablename__ = "accreditation_reports"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    institute_id = Column(UUID(as_uuid=True), ForeignKey("institutes.id"), nullable=False)
    report_type = Column(String, nullable=False) # NAAC, NBA, NIRF, AICTE
    academic_year = Column(String, nullable=False)
    file_path = Column(String, nullable=True) # Path to generated PDF/DOCX
    data_snapshot = Column(JSON, nullable=True) # Structured JSON data used for the report
    generated_at = Column(DateTime, default=datetime.datetime.utcnow)

class InstitutionIntelligenceScore(Base):
    __tablename__ = "institution_intelligence_score"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    institute_id = Column(UUID(as_uuid=True), ForeignKey("institutes.id"), nullable=False)
    score = Column(Float, nullable=False, default=0.0) # 0-100 Master Metric
    category = Column(String, nullable=False, default="Emerging") # Emerging, Developing, Strong, Excellent, Model Institution
    academic_factor = Column(Float, nullable=True)
    placement_factor = Column(Float, nullable=True)
    research_factor = Column(Float, nullable=True)
    snapshot_date = Column(DateTime, default=datetime.datetime.utcnow)
