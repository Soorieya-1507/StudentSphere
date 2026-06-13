import pytest
from fastapi.testclient import TestClient
from app.main import app
from app.db.database import get_db
from tests.conftest import client, get_token, auth_header, get_id

class TestPhase5Intelligence:
    def test_iis_unauthorized_student(self):
        token = get_token("stu1@test1.edu", "Stu1!")
        resp = client.get("/api/v1/intelligence/iis", headers=auth_header(token))
        assert resp.status_code == 403
        
    def test_iis_admin_authorized(self):
        token = get_token("admin1@test1.edu", "Admin1!")
        resp = client.get("/api/v1/intelligence/iis", headers=auth_header(token))
        assert resp.status_code == 200
        data = resp.json()
        assert "score" in data
        assert "category" in data
        
    def test_dhi_hod_authorized(self):
        token = get_token("hod1@test1.edu", "Hod1!")
        dept_id = get_id("dept1_id")
        resp = client.get(f"/api/v1/intelligence/dhi/{dept_id}", headers=auth_header(token))
        assert resp.status_code == 200
        data = resp.json()
        assert "score" in data
        assert "category" in data
        
    def test_pri_student_own_profile(self):
        token = get_token("stu1@test1.edu", "Stu1!")
        student_id = get_id("student1_id")
        resp = client.get(f"/api/v1/intelligence/pri/{student_id}", headers=auth_header(token))
        assert resp.status_code == 200
        data = resp.json()
        assert "score" in data
        assert "category" in data
        
    def test_pri_student_cannot_view_others(self):
        token = get_token("stu1@test1.edu", "Stu1!")
        student_id = get_id("student2_id")
        resp = client.get(f"/api/v1/intelligence/pri/{student_id}", headers=auth_header(token))
        assert resp.status_code == 403
