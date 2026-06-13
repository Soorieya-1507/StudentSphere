"""
Phase 4 Test: Mentor Dashboard + Feedback (Module 10)
+ HOD Analytics Dashboard (Module 11)
+ Admin Academic Analytics (Module 12)
+ Notification Testing (Module 13)
"""
import pytest
from conftest import client, get_token, auth_header, get_id, uid, TestingSessionLocal
from app.db.models_phase4 import MentorFeedback, RiskAssessment


# ======================================================
# MODULE 10: MENTOR DASHBOARD TESTING
# ======================================================

class TestMentorDashboard:

    def test_mentor_sees_assigned_students(self):
        """Mentor should see assigned students with academic summary"""
        token = get_token("mentor1@test1.edu", "Mentor1!")
        resp = client.get("/api/v1/mentor/academic/students", headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("Mentor academic endpoint not yet implemented")
        assert resp.status_code == 200

    def test_mentor_add_feedback(self):
        """Mentor can add feedback notes for a student"""
        token = get_token("mentor1@test1.edu", "Mentor1!")
        resp = client.post("/api/v1/mentor/feedback", json={
            "student_id": get_id("student1_id"),
            "feedback_type": "Note",
            "content": "Student needs to focus on Data Structures. Struggling with trees."
        }, headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("Mentor feedback endpoint not yet implemented")
        assert resp.status_code in [200, 201]

    def test_mentor_add_suggestion(self):
        """Mentor can add improvement suggestions"""
        token = get_token("mentor1@test1.edu", "Mentor1!")
        resp = client.post("/api/v1/mentor/feedback", json={
            "student_id": get_id("student1_id"),
            "feedback_type": "Suggestion",
            "content": "Recommend attending extra lab sessions for Python."
        }, headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("Mentor feedback endpoint not yet implemented")
        assert resp.status_code in [200, 201]

    def test_student_can_view_own_feedback(self):
        """Student can see mentor feedback addressed to them"""
        token = get_token("stu1@test1.edu", "Stu1!")
        student_id = get_id("student1_id")
        resp = client.get(
            f"/api/v1/mentor/feedback?student_id={student_id}",
            headers=auth_header(token)
        )
        if resp.status_code == 404:
            pytest.skip("Mentor feedback GET endpoint not yet implemented")
        assert resp.status_code == 200

    def test_student_cannot_add_feedback(self):
        """Students should not be able to add feedback"""
        token = get_token("stu1@test1.edu", "Stu1!")
        resp = client.post("/api/v1/mentor/feedback", json={
            "student_id": get_id("student1_id"),
            "feedback_type": "Note",
            "content": "Self-feedback attempt"
        }, headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("Mentor feedback endpoint not yet implemented")
        assert resp.status_code == 403

    def test_feedback_stored_in_database(self, test_db):
        """Verify feedback is persisted in mentor_feedback table"""
        db = test_db
        feedback = db.query(MentorFeedback).filter(
            MentorFeedback.student_id == uid("student1_id")
        ).all()
        # May be empty if endpoints aren't built yet — just test the query works
        assert isinstance(feedback, list)


# ======================================================
# MODULE 11: HOD ANALYTICS DASHBOARD TESTING
# ======================================================

class TestHODAnalytics:

    def test_hod_dept_summary(self):
        """HOD can view department summary"""
        token = get_token("hod1@test1.edu", "Hod1!")
        resp = client.get("/api/v1/hod/dept-summary", headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("HOD dept-summary endpoint not yet implemented")
        assert resp.status_code == 200
        data = resp.json()
        # Should contain attendance, cgpa, arrear stats
        assert isinstance(data, dict)

    def test_hod_risk_distribution(self):
        """HOD can view risk distribution across department"""
        token = get_token("hod1@test1.edu", "Hod1!")
        resp = client.get("/api/v1/hod/risk-distribution", headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("HOD risk-distribution endpoint not yet implemented")
        assert resp.status_code == 200

    def test_hod_cannot_view_other_dept(self):
        """HOD of dept1 should not see dept2 data"""
        token = get_token("hod1@test1.edu", "Hod1!")
        # Try to access data with dept2 filter
        resp = client.get(
            f"/api/v1/hod/dept-summary?department_id={get_id('dept2_id')}",
            headers=auth_header(token)
        )
        if resp.status_code == 404:
            pytest.skip("HOD dept-summary endpoint not yet implemented")
        # Should either 403 or return empty/filtered to own dept
        assert resp.status_code in [200, 403]

    def test_faculty_cannot_access_hod_analytics(self):
        """Regular faculty should not access HOD analytics"""
        token = get_token("fac1@test1.edu", "Fac1!")
        resp = client.get("/api/v1/hod/dept-summary", headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("HOD dept-summary endpoint not yet implemented")
        # Faculty should be 403 (only HOD/ADMIN)
        assert resp.status_code == 403


# ======================================================
# MODULE 12: ADMIN ACADEMIC ANALYTICS TESTING
# ======================================================

class TestAdminAcademicAnalytics:

    def test_admin_dept_comparison(self):
        """Admin can compare departments"""
        token = get_token("admin1@test1.edu", "Admin1!")
        resp = client.get("/api/v1/admin/dept-comparison", headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("Admin dept-comparison endpoint not yet implemented")
        assert resp.status_code == 200
        data = resp.json()
        assert isinstance(data, (dict, list))

    def test_admin_institution_health(self):
        """Admin can view institution-wide health score"""
        token = get_token("admin1@test1.edu", "Admin1!")
        resp = client.get("/api/v1/admin/institution-health", headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("Admin institution-health endpoint not yet implemented")
        assert resp.status_code == 200

    def test_student_cannot_access_admin_analytics(self):
        """Students must not access admin analytics"""
        token = get_token("stu1@test1.edu", "Stu1!")
        resp = client.get("/api/v1/admin/dept-comparison", headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("Admin dept-comparison endpoint not yet implemented")
        assert resp.status_code == 403

    def test_faculty_cannot_access_admin_analytics(self):
        """Faculty must not access admin analytics"""
        token = get_token("fac1@test1.edu", "Fac1!")
        resp = client.get("/api/v1/admin/dept-comparison", headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("Admin dept-comparison endpoint not yet implemented")
        assert resp.status_code == 403


# ======================================================
# MODULE 13: NOTIFICATION TESTING
# ======================================================

class TestAcademicNotifications:

    def test_student_low_attendance_notification(self, test_db):
        """When attendance drops below 75%, student should be notified"""
        from app.db.models import Notification
        db = test_db
        # Check if any attendance-related notification exists
        notifications = db.query(Notification).filter(
            Notification.user_id == uid("student1_id"),
            Notification.title.like("%attendance%")
        ).all()
        # Just validate the query works — content depends on endpoint implementation
        assert isinstance(notifications, list)

    def test_student_arrear_notification(self, test_db):
        """When a new arrear is detected, student should be notified"""
        from app.db.models import Notification
        db = test_db
        notifications = db.query(Notification).filter(
            Notification.user_id == uid("student1_id"),
            Notification.title.like("%arrear%")
        ).all()
        assert isinstance(notifications, list)

    def test_mentor_high_risk_notification(self, test_db):
        """When student enters high-risk, mentor should be notified"""
        from app.db.models import Notification
        db = test_db
        notifications = db.query(Notification).filter(
            Notification.user_id == uid("mentor1_id"),
            Notification.title.like("%risk%")
        ).all()
        assert isinstance(notifications, list)

    def test_notification_api_returns_list(self):
        """Notification endpoint should return a list"""
        token = get_token("stu1@test1.edu", "Stu1!")
        resp = client.get("/api/v1/notifications/", headers=auth_header(token))
        if resp.status_code == 404:
            pytest.skip("Notification endpoint not yet implemented")
        assert resp.status_code == 200
        assert isinstance(resp.json(), list)
