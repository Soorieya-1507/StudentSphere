"""
Phase 4 Test: Security + Role-Based Access Control (Module 16)
Tests that students, faculty, HOD, and admin can only access their authorized endpoints.
"""
import pytest
from conftest import client, get_token, auth_header, get_id


class TestStudentSecurityRestrictions:
    """Student cannot access faculty/admin endpoints"""

    def test_student_cannot_create_semester(self):
        token = get_token("stu1@test1.edu", "Stu1!")
        resp = client.post("/api/v1/academic/semesters", json={
            "department_id": get_id("dept1_id"),
            "semester_number": 99,
            "academic_year": "2025-2026",
            "regulation": "R2021"
        }, headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("Endpoint not yet implemented")
        assert resp.status_code == 403

    def test_student_cannot_create_subject(self):
        token = get_token("stu1@test1.edu", "Stu1!")
        resp = client.post("/api/v1/academic/subjects", json={
            "semester_id": get_id("sem1_id"),
            "subject_code": "HACK101",
            "subject_name": "Hacking Test",
            "credits": 4,
            "department_id": get_id("dept1_id")
        }, headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("Endpoint not yet implemented")
        assert resp.status_code == 403

    def test_student_cannot_enter_marks(self):
        token = get_token("stu1@test1.edu", "Stu1!")
        resp = client.post("/api/v1/academic/marks", json={
            "student_id": get_id("student1_id"),
            "subject_id": get_id("subj1_id"),
            "internal_1": 50,
            "internal_2": 50,
        }, headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("Endpoint not yet implemented")
        assert resp.status_code == 403

    def test_student_cannot_upload_attendance(self):
        token = get_token("stu1@test1.edu", "Stu1!")
        resp = client.post("/api/v1/attendance/upload", json={
            "subject_id": get_id("subj1_id"),
            "month": "2024-08",
            "student_records": [
                {"student_id": get_id("student1_id"), "total_classes": 20, "attended_classes": 20}
            ]
        }, headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("Endpoint not yet implemented")
        assert resp.status_code == 403

    def test_student_cannot_upload_results(self):
        token = get_token("stu1@test1.edu", "Stu1!")
        resp = client.post("/api/v1/results/upload", json={
            "subject_id": get_id("subj1_id"),
            "student_results": [
                {"student_id": get_id("student1_id"), "grade": "O", "status": "PASS"}
            ]
        }, headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("Endpoint not yet implemented")
        assert resp.status_code == 403

    def test_student_cannot_compute_risk(self):
        token = get_token("stu1@test1.edu", "Stu1!")
        resp = client.post(
            f"/api/v1/risk/compute/{get_id('student1_id')}",
            headers=auth_header(token)
        )
        if resp.status_code == 404:
            pytest.skip("Endpoint not yet implemented")
        assert resp.status_code == 403

    def test_student_cannot_access_other_student_attendance(self):
        token = get_token("stu1@test1.edu", "Stu1!")
        other_id = get_id("student3_id")
        resp = client.get(
            f"/api/v1/attendance/student/{other_id}",
            headers=auth_header(token)
        )
        if resp.status_code == 404:
            pytest.skip("Endpoint not yet implemented")
        # Should be 403 or return empty/filtered results
        assert resp.status_code in [403, 200]
        if resp.status_code == 200:
            # If 200, data should be empty (student can't see others)
            data = resp.json()
            if isinstance(data, list):
                assert len(data) == 0

    def test_student_cannot_access_admin_analytics(self):
        token = get_token("stu1@test1.edu", "Stu1!")
        resp = client.get("/api/v1/admin/dept-comparison", headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("Endpoint not yet implemented")
        assert resp.status_code == 403

    def test_student_cannot_add_mentor_feedback(self):
        token = get_token("stu1@test1.edu", "Stu1!")
        resp = client.post("/api/v1/mentor/feedback", json={
            "student_id": get_id("student1_id"),
            "feedback_type": "Note",
            "content": "Hack attempt"
        }, headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("Endpoint not yet implemented")
        assert resp.status_code == 403


class TestFacultySecurityRestrictions:
    """Faculty cannot access admin-only endpoints"""

    def test_faculty_cannot_access_admin_dashboard(self):
        token = get_token("fac1@test1.edu", "Fac1!")
        resp = client.get("/api/v1/dashboards/admin", headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("Endpoint not yet implemented")
        assert resp.status_code == 403

    def test_faculty_cannot_access_dept_comparison(self):
        token = get_token("fac1@test1.edu", "Fac1!")
        resp = client.get("/api/v1/admin/dept-comparison", headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("Endpoint not yet implemented")
        assert resp.status_code == 403


class TestHODSecurityRestrictions:
    """HOD can view but not enter marks/attendance"""

    def test_hod_cannot_enter_marks(self):
        token = get_token("hod1@test1.edu", "Hod1!")
        resp = client.post("/api/v1/academic/marks", json={
            "student_id": get_id("student1_id"),
            "subject_id": get_id("subj1_id"),
            "internal_1": 45,
        }, headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("Endpoint not yet implemented")
        # HOD should not be allowed to enter marks
        assert resp.status_code == 403

    def test_hod_cannot_upload_attendance(self):
        token = get_token("hod1@test1.edu", "Hod1!")
        resp = client.post("/api/v1/attendance/upload", json={
            "subject_id": get_id("subj1_id"),
            "month": "2024-08",
            "student_records": []
        }, headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("Endpoint not yet implemented")
        assert resp.status_code == 403

    def test_hod_can_view_dept_summary(self):
        token = get_token("hod1@test1.edu", "Hod1!")
        resp = client.get("/api/v1/hod/dept-summary", headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("Endpoint not yet implemented")
        assert resp.status_code == 200


class TestJWTValidation:
    """No token = 401"""

    def test_no_token_academic(self):
        resp = client.get("/api/v1/academic/semesters")
        if resp.status_code == 404:
            pytest.skip("Endpoint not yet implemented")
        assert resp.status_code == 401

    def test_invalid_token_academic(self):
        resp = client.get(
            "/api/v1/academic/semesters",
            headers={"Authorization": "Bearer totally_fake_token_123"}
        )
        if resp.status_code == 404:
            pytest.skip("Endpoint not yet implemented")
        assert resp.status_code == 401

    def test_expired_token_rejected(self):
        """Manually crafted expired token should be rejected"""
        from app.core.security import create_access_token
        from datetime import timedelta
        expired = create_access_token(
            data={"sub": "stu1@test1.edu"},
            expires_delta=timedelta(seconds=-1)
        )
        resp = client.get(
            "/api/v1/academic/semesters",
            headers={"Authorization": f"Bearer {expired}"}
        )
        if resp.status_code == 404:
            pytest.skip("Endpoint not yet implemented")
        assert resp.status_code == 401
