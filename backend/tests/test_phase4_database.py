"""
Phase 4 Test: Database Integrity + Foreign Key Validation (Module 15)
Tests that all Phase 4 tables are properly structured and referentially intact.
"""
import pytest
import uuid as uuid_mod
from conftest import TestingSessionLocal, get_id, uid
from app.db.models_phase4 import (
    Semester, Subject, InternalMark, AttendanceRecord, SemesterResult,
    GPARecord, CGPARecord, ArrearRecord, RiskAssessment,
    AcademicHealthIndex, MentorFeedback,
)
from app.db.models import User, Department, Institute
from sqlalchemy import inspect
from app.db.database import Base, engine



class TestTableCreation:
    """Verify all Phase 4 tables exist in the database"""

    @pytest.mark.parametrize("table_name", [
        "semesters", "subjects", "internal_marks", "attendance_records",
        "semester_results", "gpa_records", "cgpa_records", "arrear_records",
        "risk_assessments", "academic_health_index", "mentor_feedback",
    ])
    def test_table_exists(self, table_name):
        inspector = inspect(engine)
        tables = inspector.get_table_names()
        assert table_name in tables, f"Table '{table_name}' does not exist"


class TestForeignKeyIntegrity:
    """Verify foreign key relationships are properly enforced"""

    def test_semester_links_to_department(self, test_db):
        db = test_db
        sem = db.query(Semester).first()
        if sem is None:
            pytest.skip("No semesters in DB")
        dept = db.query(Department).filter(Department.id == sem.department_id).first()
        assert dept is not None, "Semester has orphan department_id"

    def test_subject_links_to_semester(self, test_db):
        db = test_db
        subj = db.query(Subject).first()
        if subj is None:
            pytest.skip("No subjects in DB")
        sem = db.query(Semester).filter(Semester.id == subj.semester_id).first()
        assert sem is not None, "Subject has orphan semester_id"

    def test_subject_links_to_department(self, test_db):
        db = test_db
        subj = db.query(Subject).first()
        if subj is None:
            pytest.skip("No subjects in DB")
        dept = db.query(Department).filter(Department.id == subj.department_id).first()
        assert dept is not None, "Subject has orphan department_id"

    def test_internal_mark_links_to_student(self, test_db):
        db = test_db
        mark = db.query(InternalMark).first()
        if mark is None:
            pytest.skip("No internal marks in DB")
        user = db.query(User).filter(User.id == mark.student_id).first()
        assert user is not None, "InternalMark has orphan student_id"

    def test_internal_mark_links_to_subject(self, test_db):
        db = test_db
        mark = db.query(InternalMark).first()
        if mark is None:
            pytest.skip("No internal marks in DB")
        subj = db.query(Subject).filter(Subject.id == mark.subject_id).first()
        assert subj is not None, "InternalMark has orphan subject_id"

    def test_attendance_links_to_student(self, test_db):
        db = test_db
        rec = db.query(AttendanceRecord).first()
        if rec is None:
            pytest.skip("No attendance records in DB")
        user = db.query(User).filter(User.id == rec.student_id).first()
        assert user is not None, "AttendanceRecord has orphan student_id"

    def test_result_links_to_student(self, test_db):
        db = test_db
        result = db.query(SemesterResult).first()
        if result is None:
            pytest.skip("No semester results in DB")
        user = db.query(User).filter(User.id == result.student_id).first()
        assert user is not None, "SemesterResult has orphan student_id"

    def test_gpa_links_to_student_and_semester(self, test_db):
        db = test_db
        gpa = db.query(GPARecord).first()
        if gpa is None:
            pytest.skip("No GPA records in DB")
        user = db.query(User).filter(User.id == gpa.student_id).first()
        sem = db.query(Semester).filter(Semester.id == gpa.semester_id).first()
        assert user is not None, "GPARecord has orphan student_id"
        assert sem is not None, "GPARecord has orphan semester_id"

    def test_cgpa_links_to_student(self, test_db):
        db = test_db
        cgpa = db.query(CGPARecord).first()
        if cgpa is None:
            pytest.skip("No CGPA records in DB")
        user = db.query(User).filter(User.id == cgpa.student_id).first()
        assert user is not None, "CGPARecord has orphan student_id"

    def test_arrear_links_to_student_and_subject(self, test_db):
        db = test_db
        arrear = db.query(ArrearRecord).first()
        if arrear is None:
            pytest.skip("No arrear records in DB")
        user = db.query(User).filter(User.id == arrear.student_id).first()
        subj = db.query(Subject).filter(Subject.id == arrear.subject_id).first()
        assert user is not None, "ArrearRecord has orphan student_id"
        assert subj is not None, "ArrearRecord has orphan subject_id"

    def test_risk_assessment_links_to_student(self, test_db):
        db = test_db
        risk = db.query(RiskAssessment).first()
        if risk is None:
            pytest.skip("No risk assessments in DB")
        user = db.query(User).filter(User.id == risk.student_id).first()
        assert user is not None, "RiskAssessment has orphan student_id"

    def test_ahi_links_to_student(self, test_db):
        db = test_db
        ahi = db.query(AcademicHealthIndex).first()
        if ahi is None:
            pytest.skip("No AHI records in DB")
        user = db.query(User).filter(User.id == ahi.student_id).first()
        assert user is not None, "AHI has orphan student_id"

    def test_mentor_feedback_links_to_student_and_mentor(self, test_db):
        db = test_db
        fb = db.query(MentorFeedback).first()
        if fb is None:
            pytest.skip("No mentor feedback in DB")
        student = db.query(User).filter(User.id == fb.student_id).first()
        mentor = db.query(User).filter(User.id == fb.mentor_id).first()
        assert student is not None, "MentorFeedback has orphan student_id"
        assert mentor is not None, "MentorFeedback has orphan mentor_id"


class TestDirectDatabaseOperations:
    """Verify CRUD operations work directly on models"""

    def test_create_and_read_internal_mark(self, test_db):
        db = test_db
        mark = InternalMark(
            student_id=uid("student1_id"),
            subject_id=uid("subj1_id"),
            internal_1=42.0,
            internal_2=38.5,
            assignment=18.0,
            model_exam=85.0,
        )
        db.add(mark)
        db.commit()
        db.refresh(mark)
        assert mark.id is not None
        assert mark.internal_1 == 42.0
        assert mark.model_exam == 85.0
        # Cleanup
        db.delete(mark)
        db.commit()

    def test_create_attendance_record(self, test_db):
        db = test_db
        rec = AttendanceRecord(
            student_id=uid("student1_id"),
            subject_id=uid("subj1_id"),
            month="2024-09",
            total_classes=30,
            attended_classes=27,
            percentage=90.0,
        )
        db.add(rec)
        db.commit()
        db.refresh(rec)
        assert rec.percentage == 90.0
        db.delete(rec)
        db.commit()

    def test_create_semester_result(self, test_db):
        db = test_db
        result = SemesterResult(
            student_id=uid("student1_id"),
            subject_id=uid("subj1_id"),
            grade="A+",
            credits=4,
            status="PASS",
        )
        db.add(result)
        db.commit()
        db.refresh(result)
        assert result.grade == "A+"
        assert result.status == "PASS"
        db.delete(result)
        db.commit()

    def test_create_arrear_record(self, test_db):
        db = test_db
        arrear = ArrearRecord(
            student_id=uid("student1_id"),
            subject_id=uid("subj2_id"),
            attempt_number=1,
            status="CURRENT",
        )
        db.add(arrear)
        db.commit()
        db.refresh(arrear)
        assert arrear.status == "CURRENT"
        # Clear the arrear
        arrear.status = "CLEARED"
        from datetime import datetime
        arrear.cleared_date = datetime.utcnow()
        db.commit()
        db.refresh(arrear)
        assert arrear.status == "CLEARED"
        assert arrear.cleared_date is not None
        db.delete(arrear)
        db.commit()

    def test_create_risk_assessment(self, test_db):
        db = test_db
        risk = RiskAssessment(
            student_id=uid("student1_id"),
            risk_score=25.0,
            risk_category="Green",
            factors='{"attendance": "ok", "cgpa": "ok"}',
        )
        db.add(risk)
        db.commit()
        db.refresh(risk)
        assert risk.risk_category == "Green"
        db.delete(risk)
        db.commit()

    def test_create_ahi(self, test_db):
        db = test_db
        ahi = AcademicHealthIndex(
            student_id=uid("student1_id"),
            ahi_score=82.5,
        )
        db.add(ahi)
        db.commit()
        db.refresh(ahi)
        assert ahi.ahi_score == 82.5
        db.delete(ahi)
        db.commit()

    def test_create_mentor_feedback(self, test_db):
        db = test_db
        fb = MentorFeedback(
            student_id=uid("student1_id"),
            mentor_id=uid("mentor1_id"),
            feedback_type="Comment",
            content="Excellent improvement in attendance this month.",
        )
        db.add(fb)
        db.commit()
        db.refresh(fb)
        assert fb.content == "Excellent improvement in attendance this month."
        db.delete(fb)
        db.commit()
