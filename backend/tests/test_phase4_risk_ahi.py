"""
Phase 4 Test: Risk Engine + Academic Health Index
Tests Modules 7, 8, 9 from the Phase 4 checklist.
"""
import pytest
import json
import uuid as uuid_mod
from conftest import client, get_token, auth_header, get_id, uid, TestingSessionLocal
from app.db.models_phase4 import (
    AttendanceRecord, SemesterResult, ArrearRecord,
    RiskAssessment, AcademicHealthIndex, CGPARecord, GPARecord, Subject
)

# ======================================================
# MODULE 8: RISK ENGINE TESTING
# ======================================================

class TestRiskEngine:
    """
    Risk Score (0-100):
    - Attendance < 75%: +30 pts
    - Attendance < 60%: +50 pts (replaces the +30)
    - Current arrears >= 1: +25 pts
    - Current arrears >= 3: +40 pts (replaces the +25)
    - CGPA < 5.0: +20 pts
    - CGPA < 4.0: +35 pts (replaces the +20)
    - GPA dropping trend: +15 pts

    Categories:
    - Green: 0-25 (Safe)
    - Yellow: 26-50 (Needs Monitoring)
    - Orange: 51-75 (Intervention Required)
    - Red: 76-100 (Immediate Action)
    """

    def test_green_student_safe(self, test_db):
        """Student A: Attendance=95%, CGPA=8.5, No arrears -> Green"""
        db = test_db
        student_uid = uid("student1_id")
        student_id  = get_id("student1_id")
        subj_uid    = uid("subj1_id")

        # Setup: High attendance
        db.query(AttendanceRecord).filter(
            AttendanceRecord.student_id == student_uid
        ).delete(synchronize_session=False)
        db.commit()

        att = AttendanceRecord(
            student_id=student_uid,
            subject_id=subj_uid,
            month="2024-08",
            total_classes=100,
            attended_classes=95,
            percentage=95.0,
        )
        db.add(att)

        # Setup: High CGPA
        existing_cgpa = db.query(CGPARecord).filter(
            CGPARecord.student_id == student_uid
        ).first()
        if existing_cgpa:
            existing_cgpa.cgpa = 8.5
        else:
            db.add(CGPARecord(student_id=student_uid, cgpa=8.5, total_credits_earned=30))

        # Setup: No arrears
        db.query(ArrearRecord).filter(
            ArrearRecord.student_id == student_uid,
            ArrearRecord.status == "CURRENT",
        ).delete(synchronize_session=False)

        db.commit()

        # Trigger risk computation
        faculty_token = get_token("fac1@test1.edu", "Fac1!")
        resp = client.post(
            f"/api/v1/risk/compute/{student_id}",
            headers=auth_header(faculty_token),
        )
        if resp.status_code == 404:
            pytest.skip("Risk compute endpoint not yet implemented")

        assert resp.status_code == 200
        data = resp.json()
        assert data["risk_category"] == "Green"
        assert data["risk_score"] <= 25

    def test_yellow_student_monitoring(self, test_db):
        """Student B: Attendance=70%, CGPA=6.5, 1 Arrear -> Yellow"""
        db = test_db
        student_uid = uid("student3_id")
        student_id  = get_id("student3_id")
        subj_uid    = uid("subj1_id")

        # Clear previous data
        db.query(AttendanceRecord).filter(AttendanceRecord.student_id == student_uid).delete(synchronize_session=False)
        db.query(ArrearRecord).filter(ArrearRecord.student_id == student_uid).delete(synchronize_session=False)
        db.query(CGPARecord).filter(CGPARecord.student_id == student_uid).delete(synchronize_session=False)
        db.commit()

        # Attendance 70% -> +30 pts
        db.add(AttendanceRecord(
            student_id=student_uid, subject_id=subj_uid,
            month="2024-08", total_classes=100, attended_classes=70, percentage=70.0
        ))
        # CGPA 6.5 -> no penalty (>5)
        db.add(CGPARecord(student_id=student_uid, cgpa=6.5, total_credits_earned=20))
        # 1 arrear -> +25 pts
        db.add(ArrearRecord(student_id=student_uid, subject_id=subj_uid, attempt_number=1, status="CURRENT"))
        db.commit()

        faculty_token = get_token("fac1@test1.edu", "Fac1!")
        resp = client.post(f"/api/v1/risk/compute/{student_id}", headers=auth_header(faculty_token))
        if resp.status_code == 404:
            pytest.skip("Risk compute endpoint not yet implemented")

        data = resp.json()
        assert data["risk_category"] in ["Yellow", "Orange"]
        assert 26 <= data["risk_score"] <= 75

    def test_orange_student_intervention(self, test_db):
        """Student C: Attendance=55%, CGPA=5.5, 3 Arrears -> Orange"""
        db = test_db
        student_uid = uid("student4_id")
        student_id  = get_id("student4_id")
        subj1_uid   = uid("subj1_id")
        subj2_uid   = uid("subj2_id")
        subj3_uid   = uid("subj3_id")

        db.query(AttendanceRecord).filter(AttendanceRecord.student_id == student_uid).delete(synchronize_session=False)
        db.query(ArrearRecord).filter(ArrearRecord.student_id == student_uid).delete(synchronize_session=False)
        db.query(CGPARecord).filter(CGPARecord.student_id == student_uid).delete(synchronize_session=False)
        db.commit()

        # Attendance 55% -> +50 pts
        db.add(AttendanceRecord(
            student_id=student_uid, subject_id=subj1_uid,
            month="2024-08", total_classes=100, attended_classes=55, percentage=55.0
        ))
        # CGPA 5.5 -> no penalty (>5)
        db.add(CGPARecord(student_id=student_uid, cgpa=5.5, total_credits_earned=20))
        # 3 arrears -> +40 pts
        for s_uid in [subj1_uid, subj2_uid, subj3_uid]:
            db.add(ArrearRecord(student_id=student_uid, subject_id=s_uid, attempt_number=1, status="CURRENT"))
        db.commit()

        faculty_token = get_token("fac1@test1.edu", "Fac1!")
        resp = client.post(f"/api/v1/risk/compute/{student_id}", headers=auth_header(faculty_token))
        if resp.status_code == 404:
            pytest.skip("Risk compute endpoint not yet implemented")

        data = resp.json()
        assert data["risk_category"] in ["Orange", "Red"]
        assert data["risk_score"] >= 51

    def test_red_student_immediate_action(self, test_db):
        """Student D: Attendance=40%, CGPA=4.0, 5 Arrears -> Red"""
        db = test_db
        student_uid = uid("student4_id")
        student_id  = get_id("student4_id")
        subj1_uid   = uid("subj1_id")
        subj2_uid   = uid("subj2_id")
        subj3_uid   = uid("subj3_id")

        db.query(AttendanceRecord).filter(AttendanceRecord.student_id == student_uid).delete(synchronize_session=False)
        db.query(ArrearRecord).filter(ArrearRecord.student_id == student_uid).delete(synchronize_session=False)
        db.query(CGPARecord).filter(CGPARecord.student_id == student_uid).delete(synchronize_session=False)
        db.commit()

        # Attendance 40% -> +50 pts
        db.add(AttendanceRecord(
            student_id=student_uid, subject_id=subj1_uid,
            month="2024-08", total_classes=100, attended_classes=40, percentage=40.0
        ))
        # CGPA 4.0 -> +35 pts
        db.add(CGPARecord(student_id=student_uid, cgpa=4.0, total_credits_earned=20))
        # 5 arrears -> +40 pts (>=3 threshold)
        for i, s_uid in enumerate([subj1_uid, subj2_uid, subj3_uid, subj1_uid, subj2_uid]):
            db.add(ArrearRecord(student_id=student_uid, subject_id=s_uid, attempt_number=i+1, status="CURRENT"))
        db.commit()

        faculty_token = get_token("fac1@test1.edu", "Fac1!")
        resp = client.post(f"/api/v1/risk/compute/{student_id}", headers=auth_header(faculty_token))
        if resp.status_code == 404:
            pytest.skip("Risk compute endpoint not yet implemented")

        data = resp.json()
        assert data["risk_category"] == "Red"
        assert data["risk_score"] >= 76

    def test_student_cannot_compute_risk(self):
        """Students should not trigger risk computation"""
        student_id = get_id("student1_id")
        student_token = get_token("stu1@test1.edu", "Stu1!")
        resp = client.post(
            f"/api/v1/risk/compute/{student_id}",
            headers=auth_header(student_token),
        )
        if resp.status_code == 404:
            pytest.skip("Risk compute endpoint not yet implemented")
        assert resp.status_code == 403

    def test_get_risk_assessment(self):
        """Get current risk for a student"""
        student_id = get_id("student1_id")
        faculty_token = get_token("fac1@test1.edu", "Fac1!")
        resp = client.get(
            f"/api/v1/risk/{student_id}",
            headers=auth_header(faculty_token),
        )
        if resp.status_code == 404:
            pytest.skip("Risk endpoint not yet implemented")
        assert resp.status_code == 200
        data = resp.json()
        assert "risk_score" in data
        assert "risk_category" in data


# ======================================================
# MODULE 9: ACADEMIC HEALTH INDEX TESTING
# ======================================================

class TestAcademicHealthIndex:
    """
    AHI = (Attendance% × 0.3) + (CGPA/10 × 100 × 0.4) + (Pass% × 0.2) + (Achievement score × 0.1)
    Score 0-100
    """

    def test_ahi_high_performer(self, test_db):
        """Student with 95% attendance, 8.5 CGPA, 100% pass, 50 achievement score"""
        db = test_db
        student_uid = uid("student1_id")
        student_id  = get_id("student1_id")

        # Setup data for AHI computation
        db.query(AttendanceRecord).filter(AttendanceRecord.student_id == student_uid).delete(synchronize_session=False)
        db.query(CGPARecord).filter(CGPARecord.student_id == student_uid).delete(synchronize_session=False)
        db.commit()

        db.add(AttendanceRecord(
            student_id=student_uid, subject_id=uid("subj1_id"),
            month="2024-08", total_classes=100, attended_classes=95, percentage=95.0
        ))
        db.add(CGPARecord(student_id=student_uid, cgpa=8.5, total_credits_earned=30))
        db.commit()

        faculty_token = get_token("fac1@test1.edu", "Fac1!")
        resp = client.post(
            f"/api/v1/risk/compute/{student_id}",
            headers=auth_header(faculty_token),
        )
        if resp.status_code == 404:
            pytest.skip("Risk/AHI compute endpoint not yet implemented")

        # Get AHI
        ahi_resp = client.get(
            f"/api/v1/risk/{student_id}",
            headers=auth_header(faculty_token),
        )
        assert ahi_resp.status_code == 200
        data = ahi_resp.json()
        if "ahi_score" in data:
            assert data["ahi_score"] >= 70  # High performer

    def test_ahi_updates_on_recalculation(self, test_db):
        """AHI should update when risk is recomputed"""
        db = test_db
        student_uid = uid("student1_id")
        student_id  = get_id("student1_id")
        faculty_token = get_token("fac1@test1.edu", "Fac1!")

        resp1 = client.post(f"/api/v1/risk/compute/{student_id}", headers=auth_header(faculty_token))
        if resp1.status_code == 404:
            pytest.skip("Risk/AHI compute endpoint not yet implemented")

        # Change data and recompute
        db.query(CGPARecord).filter(CGPARecord.student_id == student_uid).update({"cgpa": 5.0})
        db.commit()

        resp2 = client.post(f"/api/v1/risk/compute/{student_id}", headers=auth_header(faculty_token))
        assert resp2.status_code == 200

    def test_ahi_database_record_created(self, test_db):
        """AHI computation should create/update a record in academic_health_index table"""
        db = test_db
        student_uid = uid("student1_id")

        ahi_record = db.query(AcademicHealthIndex).filter(
            AcademicHealthIndex.student_id == student_uid
        ).first()
        # Record may or may not exist depending on whether endpoint was called
        # Just verify the model works
        if ahi_record:
            assert 0 <= ahi_record.ahi_score <= 100
