import pytest
from fastapi.testclient import TestClient
from app.main import app
from app.db.database import get_db

# Re-use the conftest's SQLite test engine and session to avoid overwriting
# the global dependency override with the production PostgreSQL engine.
import sys, os
sys.path.insert(0, os.path.dirname(__file__))
from conftest import (
    TestingSessionLocal as _TestingSessionLocal,
    engine as _engine,
    override_get_db as _override_get_db,
)
from sqlalchemy.orm import sessionmaker
from app.db.models import User, Institute, Department, StudentProfile, Achievement
import uuid

# Use the same SQLite test session as conftest to keep the override consistent
TestEngine = _engine
TestingSessionLocal = _TestingSessionLocal

def override_get_db():
    try:
        db = TestingSessionLocal()
        yield db
    finally:
        db.close()

# NOTE: conftest already sets app.dependency_overrides[get_db]; don't overwrite it here.
# app.dependency_overrides[get_db] = override_get_db  ← intentionally removed

@pytest.fixture(scope="module")
def client():
    # Tables already created by conftest's setup_database
    with TestClient(app) as c:
        yield c

@pytest.fixture(scope="module")
def test_db():
    db = TestingSessionLocal()
    yield db
    db.close()

def _create_user(db, role, email, password, institute_id, department_id=None):
    from app.core.security import get_password_hash
    hashed = get_password_hash(password)
    user = User(email=email, hashed_password=hashed, role=role, mobile_number="1234567890", institute_id=institute_id, department_id=department_id)
    db.add(user)
    db.commit()
    db.refresh(user)
    if role == "STUDENT":
        profile = StudentProfile(user_id=user.id, enrollment_number=f"ENR{uuid.uuid4().hex[:6]}", department_id=department_id)
        db.add(profile)
        db.commit()
    return user

def _login(client, email, password):
    resp = client.post("/api/v1/auth/login", json={"email": email, "password": password})
    assert resp.status_code == 200
    return resp.json()["access_token"]

def _setup_data(db):
    institute = Institute(institute_id=str(uuid.uuid4()), name="Test Institute", domain=f"test{uuid.uuid4().hex[:4]}.edu", total_faculty=10, total_students=100)
    db.add(institute)
    db.commit()
    db.refresh(institute)
    dept = Department(name="Computer Science", institute_id=institute.id)
    db.add(dept)
    db.commit()
    db.refresh(dept)
    return institute, dept

def test_student_cannot_access_others_achievements(client, test_db):
    institute, dept = _setup_data(test_db)
    # Create two students
    student_a = _create_user(test_db, "STUDENT", f"a{uuid.uuid4().hex[:4]}@student.test.edu", "Pass@123", institute.id, dept.id)
    student_b = _create_user(test_db, "STUDENT", f"b{uuid.uuid4().hex[:4]}@student.test.edu", "Pass@123", institute.id, dept.id)
    
    token_a = _login(client, student_a.email, "Pass@123")
    token_b = _login(client, student_b.email, "Pass@123")
    
    cats_resp = client.get("/api/v1/achievements/categories", headers={"Authorization": f"Bearer {token_a}"})
    assert cats_resp.status_code == 200
    categories = cats_resp.json()
    if not categories:
        pytest.skip("No achievement categories found. Run seed script first.")
        
    cat_id = categories[0]["id"]
    
    # Student A uploads an achievement
    achievement_payload = {
        "category_id": cat_id,
        "title": "Student A Cert",
        "description": "Test cert",
        "organization_name": "TestOrg",
        "academic_year": 2025,
        "semester": 1,
        "status": "DRAFT"
    }
    
    upload_resp = client.post("/api/v1/achievements/", json=achievement_payload, headers={"Authorization": f"Bearer {token_a}"})
    assert upload_resp.status_code == 200
    
    # Student B requests their own achievements list
    list_b = client.get("/api/v1/achievements/", headers={"Authorization": f"Bearer {token_b}"})
    assert list_b.status_code == 200
    
    # Ensure Student A's achievement is not in Student B's list
    titles_b = [a["title"] for a in list_b.json()]
    assert "Student A Cert" not in titles_b
    
def test_public_passport_shows_only_approved(client, test_db):
    institute, dept = _setup_data(test_db)
    student = _create_user(test_db, "STUDENT", f"pub{uuid.uuid4().hex[:4]}@student.test.edu", "Pass@123", institute.id, dept.id)
    token = _login(client, student.email, "Pass@123")
    
    cats = client.get("/api/v1/achievements/categories", headers={"Authorization": f"Bearer {token}"}).json()
    if not cats:
        pytest.skip("No categories")
        
    cat_id = cats[0]["id"]
    
    # Upload Approved
    approved_payload = {
        "category_id": cat_id,
        "title": "Approved Cert Test",
        "academic_year": 2025,
        "semester": 1,
        "status": "APPROVED" # Depending on API, students shouldn't be able to force APPROVED. Assuming admin later changes it.
    }
    appr_resp = client.post("/api/v1/achievements/", json=approved_payload, headers={"Authorization": f"Bearer {token}"})
    assert appr_resp.status_code == 200
    
    # Upload Pending
    pending_payload = {
        "category_id": cat_id,
        "title": "Pending Cert Test",
        "academic_year": 2025,
        "semester": 1,
        "status": "PENDING"
    }
    pend_resp = client.post("/api/v1/achievements/", json=pending_payload, headers={"Authorization": f"Bearer {token}"})
    assert pend_resp.status_code == 200
    
    # Fetch student profile to get public_profile_id
    prof_resp = client.get("/api/v1/profiles/student/me", headers={"Authorization": f"Bearer {token}"})
    assert prof_resp.status_code == 200
    public_id = prof_resp.json()["public_profile_id"]
    
    # Get public passport
    passport_resp = client.get(f"/api/v1/public/{public_id}")
    assert passport_resp.status_code == 200
    
    data = passport_resp.json()
    titles = [a["title"] for a in data["achievements"]]
    
    # If the backend correctly respects status on upload, the student setting it to APPROVED might be ignored, 
    # but let's test if the public route isolates them.
    # Actually, we should force it to APPROVED in DB just in case
    ach = test_db.query(Achievement).filter(Achievement.id == appr_resp.json()["id"]).first()
    ach.status = "APPROVED"
    test_db.commit()
    
    passport_resp2 = client.get(f"/api/v1/public/{public_id}")
    data2 = passport_resp2.json()
    titles2 = [a["title"] for a in data2["achievements"]]
    
    assert "Approved Cert Test" in titles2
    assert "Pending Cert Test" not in titles2
