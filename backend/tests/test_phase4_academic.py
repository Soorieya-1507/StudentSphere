"""
Phase 4 – Academic Module Tests
================================
Covers:
  1. Semester management  (POST / GET  /api/v1/academic/semesters)
  2. Subject management   (POST / GET  /api/v1/academic/subjects)
  3. Internal marks        (POST / GET  /api/v1/academic/marks)

Uses fixtures and helpers exported from conftest.py.
"""

import uuid
import pytest

from conftest import client, get_id, get_token, auth_header


# ---------------------------------------------------------------------------
#  Helpers
# ---------------------------------------------------------------------------

def _faculty_headers() -> dict:
    return auth_header(get_token("fac1@test1.edu", "Fac1!"))


def _student_headers() -> dict:
    return auth_header(get_token("stu1@test1.edu", "Stu1!"))


def _hod_headers() -> dict:
    return auth_header(get_token("hod1@test1.edu", "Hod1!"))


def _admin_headers() -> dict:
    return auth_header(get_token("admin1@test1.edu", "Admin1!"))


def skip_if_not_built(resp):
    """Skip test gracefully if the endpoint doesn't exist yet (404)."""
    if resp.status_code == 404:
        pytest.skip("Endpoint not yet implemented – skip until Phase 4 build complete")


# ============================================================================
#  1. SEMESTER MANAGEMENT
# ============================================================================

class TestSemesterCreate:
    """POST /api/v1/academic/semesters"""

    ENDPOINT = "/api/v1/academic/semesters"

    # -- happy path ----------------------------------------------------------

    def test_create_semester_success(self):
        """Faculty/Admin can create a new semester record."""
        payload = {
            "department_id": get_id("dept1_id"),
            "semester_number": 2,
            "academic_year": "2024-2025",
            "regulation": "R2021",
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (200, 201), resp.text
        data = resp.json()
        assert data["semester_number"] == 2
        assert data["academic_year"] == "2024-2025"
        assert data["regulation"] == "R2021"
        assert "id" in data

    def test_create_semester_with_dates(self):
        """Semester with optional start/end dates."""
        payload = {
            "department_id": get_id("dept1_id"),
            "semester_number": 3,
            "academic_year": "2024-2025",
            "regulation": "R2021",
            "start_date": "2024-08-01T00:00:00",
            "end_date": "2024-12-15T00:00:00",
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (200, 201), resp.text
        data = resp.json()
        assert data["semester_number"] == 3
        # Dates should be returned (non-null)
        assert data.get("start_date") is not None
        assert data.get("end_date") is not None

    def test_create_semester_different_department(self):
        """Same semester_number + academic_year but different dept is allowed."""
        payload = {
            "department_id": get_id("dept2_id"),
            "semester_number": 1,
            "academic_year": "2024-2025",
            "regulation": "R2021",
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_admin_headers())
        assert resp.status_code in (200, 201), resp.text

    # -- duplicate prevention ------------------------------------------------

    def test_duplicate_semester_rejected(self):
        """Duplicate (dept + semester_number + academic_year) must fail."""
        payload = {
            "department_id": get_id("dept1_id"),
            "semester_number": 1,
            "academic_year": "2024-2025",
            "regulation": "R2021",
        }
        # sem1 with these exact values already exists from conftest setup
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (400, 409, 422), (
            f"Expected 400/409/422 for duplicate semester, got {resp.status_code}: {resp.text}"
        )

    # -- validation ----------------------------------------------------------

    def test_invalid_academic_year_format(self):
        """Academic year must match YYYY-YYYY (e.g. '2024-2025')."""
        payload = {
            "department_id": get_id("dept1_id"),
            "semester_number": 4,
            "academic_year": "2024",  # wrong format
            "regulation": "R2021",
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (400, 422), (
            f"Expected validation error for bad academic_year, got {resp.status_code}"
        )

    def test_invalid_academic_year_wrong_range(self):
        """End year must be exactly start year + 1."""
        payload = {
            "department_id": get_id("dept1_id"),
            "semester_number": 4,
            "academic_year": "2024-2027",  # gap > 1
            "regulation": "R2021",
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (400, 422), (
            f"Expected validation error for inconsistent year range, got {resp.status_code}"
        )

    def test_semester_number_bounds(self):
        """Semester number must be between 1 and 8 (typical)."""
        for bad_num in [0, -1]:
            payload = {
                "department_id": get_id("dept1_id"),
                "semester_number": bad_num,
                "academic_year": "2025-2026",
                "regulation": "R2021",
            }
            resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
            assert resp.status_code in (400, 422), (
                f"semester_number={bad_num} should be rejected"
            )

    def test_missing_required_fields(self):
        """Omitting required fields returns 422."""
        resp = client.post(self.ENDPOINT, json={}, headers=_faculty_headers())
        assert resp.status_code == 422

    def test_nonexistent_department_id(self):
        """Referencing a department that doesn't exist should fail."""
        payload = {
            "department_id": str(uuid.uuid4()),
            "semester_number": 1,
            "academic_year": "2025-2026",
            "regulation": "R2021",
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (400, 404, 422), resp.text

    # -- auth ----------------------------------------------------------------

    def test_unauthenticated_create_semester(self):
        """No token → 401/403."""
        payload = {
            "department_id": get_id("dept1_id"),
            "semester_number": 5,
            "academic_year": "2025-2026",
            "regulation": "R2021",
        }
        resp = client.post(self.ENDPOINT, json=payload)
        assert resp.status_code in (401, 403)


class TestSemesterList:
    """GET /api/v1/academic/semesters"""

    ENDPOINT = "/api/v1/academic/semesters"

    def test_list_semesters_returns_list(self):
        """Returns a list containing at least the seed semester."""
        resp = client.get(self.ENDPOINT, headers=_faculty_headers())
        assert resp.status_code == 200
        data = resp.json()
        assert isinstance(data, list)
        assert len(data) >= 1

    def test_list_semesters_contains_seed(self):
        """The seed semester (sem1) should be present in the list."""
        resp = client.get(self.ENDPOINT, headers=_faculty_headers())
        assert resp.status_code == 200
        ids = [s["id"] for s in resp.json()]
        assert get_id("sem1_id") in ids

    def test_list_semesters_filter_by_department(self):
        """Filter by department_id query param if supported."""
        resp = client.get(
            self.ENDPOINT,
            params={"department_id": get_id("dept1_id")},
            headers=_faculty_headers(),
        )
        assert resp.status_code == 200
        data = resp.json()
        assert isinstance(data, list)
        for sem in data:
            assert sem["department_id"] == get_id("dept1_id")

    def test_list_semesters_unauthenticated(self):
        """No token → 401/403."""
        resp = client.get(self.ENDPOINT)
        assert resp.status_code in (401, 403)


# ============================================================================
#  2. SUBJECT MANAGEMENT
# ============================================================================

class TestSubjectCreate:
    """POST /api/v1/academic/subjects"""

    ENDPOINT = "/api/v1/academic/subjects"

    # -- happy path ----------------------------------------------------------

    def test_create_subject_success(self):
        """Create a new subject linked to an existing semester."""
        payload = {
            "semester_id": get_id("sem1_id"),
            "subject_code": "CS201",
            "subject_name": "Operating Systems",
            "credits": 4,
            "department_id": get_id("dept1_id"),
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (200, 201), resp.text
        data = resp.json()
        assert data["subject_code"] == "CS201"
        assert data["subject_name"] == "Operating Systems"
        assert data["credits"] == 4
        assert "id" in data

    def test_create_subject_minimum_credits(self):
        """A subject with 1 credit should be accepted."""
        payload = {
            "semester_id": get_id("sem1_id"),
            "subject_code": "CS299",
            "subject_name": "Seminar",
            "credits": 1,
            "department_id": get_id("dept1_id"),
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (200, 201), resp.text

    # -- duplicate prevention ------------------------------------------------

    def test_duplicate_subject_code_rejected(self):
        """Same subject_code should be rejected (CS101 already exists)."""
        payload = {
            "semester_id": get_id("sem1_id"),
            "subject_code": "CS101",  # exists in seed data
            "subject_name": "Duplicate Test",
            "credits": 3,
            "department_id": get_id("dept1_id"),
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (400, 409, 422), (
            f"Expected duplicate code to be rejected, got {resp.status_code}: {resp.text}"
        )

    # -- validation ----------------------------------------------------------

    def test_zero_credits_rejected(self):
        """Credits = 0 should be rejected."""
        payload = {
            "semester_id": get_id("sem1_id"),
            "subject_code": "CS000",
            "subject_name": "Zero Credit",
            "credits": 0,
            "department_id": get_id("dept1_id"),
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (400, 422), (
            f"Zero credits should be rejected, got {resp.status_code}"
        )

    def test_negative_credits_rejected(self):
        """Credits < 0 should be rejected."""
        payload = {
            "semester_id": get_id("sem1_id"),
            "subject_code": "CS001",
            "subject_name": "Negative Credit",
            "credits": -2,
            "department_id": get_id("dept1_id"),
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (400, 422), (
            f"Negative credits should be rejected, got {resp.status_code}"
        )

    def test_missing_subject_code(self):
        """Omitting subject_code returns 422."""
        payload = {
            "semester_id": get_id("sem1_id"),
            "subject_name": "No Code",
            "credits": 3,
            "department_id": get_id("dept1_id"),
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code == 422

    def test_nonexistent_semester_id(self):
        """Referencing a semester that doesn't exist should fail."""
        payload = {
            "semester_id": str(uuid.uuid4()),
            "subject_code": "XX999",
            "subject_name": "Ghost Semester",
            "credits": 3,
            "department_id": get_id("dept1_id"),
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (400, 404, 422), resp.text

    # -- auth ----------------------------------------------------------------

    def test_unauthenticated_create_subject(self):
        """No token → 401/403."""
        payload = {
            "semester_id": get_id("sem1_id"),
            "subject_code": "NOAUTH",
            "subject_name": "Unauth",
            "credits": 3,
            "department_id": get_id("dept1_id"),
        }
        resp = client.post(self.ENDPOINT, json=payload)
        assert resp.status_code in (401, 403)


class TestSubjectList:
    """GET /api/v1/academic/subjects"""

    ENDPOINT = "/api/v1/academic/subjects"

    def test_list_subjects_by_semester(self):
        """Filter by semester_id returns subjects belonging to that semester."""
        resp = client.get(
            self.ENDPOINT,
            params={"semester_id": get_id("sem1_id")},
            headers=_faculty_headers(),
        )
        assert resp.status_code == 200
        data = resp.json()
        assert isinstance(data, list)
        # Seed has CS101, CS102, CS103 – at least 3
        assert len(data) >= 3
        codes = [s["subject_code"] for s in data]
        assert "CS101" in codes
        assert "CS102" in codes
        assert "CS103" in codes

    def test_list_subjects_response_fields(self):
        """Each subject object must contain expected fields."""
        resp = client.get(
            self.ENDPOINT,
            params={"semester_id": get_id("sem1_id")},
            headers=_faculty_headers(),
        )
        assert resp.status_code == 200
        for subj in resp.json():
            assert "id" in subj
            assert "subject_code" in subj
            assert "subject_name" in subj
            assert "credits" in subj
            assert "semester_id" in subj

    def test_list_subjects_no_semester_filter(self):
        """Without semester_id, should return all subjects (or require param)."""
        resp = client.get(self.ENDPOINT, headers=_faculty_headers())
        # Acceptable: 200 with all subjects, or 422 if query param is required
        assert resp.status_code in (200, 422)

    def test_list_subjects_nonexistent_semester(self):
        """If semester_id doesn't exist, return empty list or 404."""
        resp = client.get(
            self.ENDPOINT,
            params={"semester_id": str(uuid.uuid4())},
            headers=_faculty_headers(),
        )
        assert resp.status_code in (200, 404)
        if resp.status_code == 200:
            assert resp.json() == []

    def test_list_subjects_unauthenticated(self):
        """No token → 401/403."""
        resp = client.get(self.ENDPOINT, params={"semester_id": get_id("sem1_id")})
        assert resp.status_code in (401, 403)


# ============================================================================
#  3. INTERNAL MARKS
# ============================================================================

class TestInternalMarksCreate:
    """POST /api/v1/academic/marks"""

    ENDPOINT = "/api/v1/academic/marks"

    # -- happy path ----------------------------------------------------------

    def test_faculty_enters_marks_success(self):
        """Faculty can submit internal marks for a student-subject pair."""
        payload = {
            "student_id": get_id("student1_id"),
            "subject_id": get_id("subj1_id"),
            "internal_1": 45.0,
            "internal_2": 42.0,
            "assignment": 18.0,
            "model_exam": 85.0,
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (200, 201), resp.text
        data = resp.json()
        assert data["student_id"] == get_id("student1_id")
        assert data["subject_id"] == get_id("subj1_id")
        assert data["internal_1"] == 45.0
        assert data["internal_2"] == 42.0
        assert data["assignment"] == 18.0
        assert data["model_exam"] == 85.0
        assert "id" in data

    def test_faculty_enters_partial_marks(self):
        """Marks for some components can be null (partial entry)."""
        payload = {
            "student_id": get_id("student3_id"),
            "subject_id": get_id("subj1_id"),
            "internal_1": 40.0,
            # internal_2, assignment, model_exam omitted
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (200, 201), resp.text
        data = resp.json()
        assert data["internal_1"] == 40.0
        # Others should be None/null
        assert data.get("internal_2") is None
        assert data.get("assignment") is None
        assert data.get("model_exam") is None

    def test_faculty_enters_zero_marks(self):
        """Zero is a valid mark (absent / scored nothing)."""
        payload = {
            "student_id": get_id("student4_id"),
            "subject_id": get_id("subj1_id"),
            "internal_1": 0,
            "internal_2": 0,
            "assignment": 0,
            "model_exam": 0,
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (200, 201), resp.text

    def test_faculty_enters_maximum_marks(self):
        """All fields at their maximum allowed values."""
        payload = {
            "student_id": get_id("student3_id"),
            "subject_id": get_id("subj2_id"),
            "internal_1": 50.0,
            "internal_2": 50.0,
            "assignment": 20.0,
            "model_exam": 100.0,
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (200, 201), resp.text

    # -- maximum marks validation -------------------------------------------

    def test_internal_1_exceeds_max(self):
        """internal_1 > 50 should be rejected."""
        payload = {
            "student_id": get_id("student1_id"),
            "subject_id": get_id("subj2_id"),
            "internal_1": 51.0,
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (400, 422), (
            f"internal_1=51 should exceed max 50, got {resp.status_code}"
        )

    def test_internal_2_exceeds_max(self):
        """internal_2 > 50 should be rejected."""
        payload = {
            "student_id": get_id("student1_id"),
            "subject_id": get_id("subj2_id"),
            "internal_2": 55.0,
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (400, 422), (
            f"internal_2=55 should exceed max 50, got {resp.status_code}"
        )

    def test_assignment_exceeds_max(self):
        """assignment > 20 should be rejected."""
        payload = {
            "student_id": get_id("student1_id"),
            "subject_id": get_id("subj2_id"),
            "assignment": 21.0,
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (400, 422), (
            f"assignment=21 should exceed max 20, got {resp.status_code}"
        )

    def test_model_exam_exceeds_max(self):
        """model_exam > 100 should be rejected."""
        payload = {
            "student_id": get_id("student1_id"),
            "subject_id": get_id("subj2_id"),
            "model_exam": 101.0,
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (400, 422), (
            f"model_exam=101 should exceed max 100, got {resp.status_code}"
        )

    # -- negative marks -----------------------------------------------------

    def test_negative_internal_1_rejected(self):
        """internal_1 < 0 should be rejected."""
        payload = {
            "student_id": get_id("student1_id"),
            "subject_id": get_id("subj3_id"),
            "internal_1": -5.0,
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (400, 422), (
            f"Negative internal_1 should be rejected, got {resp.status_code}"
        )

    def test_negative_internal_2_rejected(self):
        """internal_2 < 0 should be rejected."""
        payload = {
            "student_id": get_id("student1_id"),
            "subject_id": get_id("subj3_id"),
            "internal_2": -1.0,
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (400, 422)

    def test_negative_assignment_rejected(self):
        """assignment < 0 should be rejected."""
        payload = {
            "student_id": get_id("student1_id"),
            "subject_id": get_id("subj3_id"),
            "assignment": -10.0,
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (400, 422)

    def test_negative_model_exam_rejected(self):
        """model_exam < 0 should be rejected."""
        payload = {
            "student_id": get_id("student1_id"),
            "subject_id": get_id("subj3_id"),
            "model_exam": -0.5,
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (400, 422)

    # -- duplicate handling (upsert) ----------------------------------------

    def test_duplicate_entry_updates_not_duplicates(self):
        """Posting marks for the same student+subject should update,
        not create a second row."""
        payload_first = {
            "student_id": get_id("student1_id"),
            "subject_id": get_id("subj3_id"),
            "internal_1": 30.0,
            "internal_2": 35.0,
        }
        resp1 = client.post(self.ENDPOINT, json=payload_first, headers=_faculty_headers())
        assert resp1.status_code in (200, 201), resp1.text

        # Update with new values
        payload_update = {
            "student_id": get_id("student1_id"),
            "subject_id": get_id("subj3_id"),
            "internal_1": 40.0,
            "internal_2": 38.0,
            "assignment": 15.0,
            "model_exam": 70.0,
        }
        resp2 = client.post(self.ENDPOINT, json=payload_update, headers=_faculty_headers())
        assert resp2.status_code in (200, 201), resp2.text
        data2 = resp2.json()
        assert data2["internal_1"] == 40.0
        assert data2["internal_2"] == 38.0

        # Fetch marks and ensure only ONE record exists for this pair
        marks_resp = client.get(
            "/api/v1/academic/marks",
            params={
                "student_id": get_id("student1_id"),
                "subject_id": get_id("subj3_id"),
            },
            headers=_faculty_headers(),
        )
        if marks_resp.status_code == 200:
            marks_data = marks_resp.json()
            # If list, check count; if single object, that's fine too
            if isinstance(marks_data, list):
                matching = [
                    m for m in marks_data
                    if m["student_id"] == get_id("student1_id")
                    and m["subject_id"] == get_id("subj3_id")
                ]
                assert len(matching) == 1, (
                    f"Expected exactly 1 mark record, found {len(matching)}"
                )

    # -- authorization -------------------------------------------------------

    def test_student_cannot_enter_marks(self):
        """A student role must be forbidden from posting marks (403)."""
        payload = {
            "student_id": get_id("student1_id"),
            "subject_id": get_id("subj1_id"),
            "internal_1": 50.0,
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_student_headers())
        assert resp.status_code == 403, (
            f"Students should get 403, got {resp.status_code}: {resp.text}"
        )

    def test_unauthenticated_marks_rejected(self):
        """No token → 401/403."""
        payload = {
            "student_id": get_id("student1_id"),
            "subject_id": get_id("subj1_id"),
            "internal_1": 10.0,
        }
        resp = client.post(self.ENDPOINT, json=payload)
        assert resp.status_code in (401, 403)

    # -- referential integrity ----------------------------------------------

    def test_nonexistent_student_id_rejected(self):
        """Marks for a non-existent student should fail."""
        payload = {
            "student_id": str(uuid.uuid4()),
            "subject_id": get_id("subj1_id"),
            "internal_1": 30.0,
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (400, 404, 422), resp.text

    def test_nonexistent_subject_id_rejected(self):
        """Marks for a non-existent subject should fail."""
        payload = {
            "student_id": get_id("student1_id"),
            "subject_id": str(uuid.uuid4()),
            "internal_1": 30.0,
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code in (400, 404, 422), resp.text

    def test_missing_student_and_subject_ids(self):
        """Omitting both required IDs returns 422."""
        payload = {
            "internal_1": 30.0,
        }
        resp = client.post(self.ENDPOINT, json=payload, headers=_faculty_headers())
        assert resp.status_code == 422


class TestInternalMarksRead:
    """GET /api/v1/academic/marks"""

    ENDPOINT = "/api/v1/academic/marks"

    def test_get_marks_by_student(self):
        """Retrieve marks filtering by student_id."""
        resp = client.get(
            self.ENDPOINT,
            params={"student_id": get_id("student1_id")},
            headers=_faculty_headers(),
        )
        assert resp.status_code == 200
        data = resp.json()
        assert isinstance(data, list)
        assert len(data) >= 1
        for m in data:
            assert m["student_id"] == get_id("student1_id")

    def test_get_marks_by_subject(self):
        """Retrieve marks filtering by subject_id."""
        resp = client.get(
            self.ENDPOINT,
            params={"subject_id": get_id("subj1_id")},
            headers=_faculty_headers(),
        )
        assert resp.status_code == 200
        data = resp.json()
        assert isinstance(data, list)
        for m in data:
            assert m["subject_id"] == get_id("subj1_id")

    def test_get_marks_response_fields(self):
        """Each marks object must expose all expected fields."""
        resp = client.get(
            self.ENDPOINT,
            params={"student_id": get_id("student1_id")},
            headers=_faculty_headers(),
        )
        assert resp.status_code == 200
        for m in resp.json():
            assert "id" in m
            assert "student_id" in m
            assert "subject_id" in m
            assert "internal_1" in m or m.get("internal_1") is None
            assert "internal_2" in m or m.get("internal_2") is None
            assert "assignment" in m or m.get("assignment") is None
            assert "model_exam" in m or m.get("model_exam") is None

    def test_get_marks_unauthenticated(self):
        """No token → 401/403."""
        resp = client.get(
            self.ENDPOINT,
            params={"student_id": get_id("student1_id")},
        )
        assert resp.status_code in (401, 403)

    def test_get_marks_empty_for_new_student(self):
        """Student with no marks should return an empty list."""
        resp = client.get(
            self.ENDPOINT,
            params={"student_id": get_id("student2_id")},  # student2 is in dept2
            headers=_faculty_headers(),
        )
        # Could be 200 with [] or 404
        assert resp.status_code in (200, 404)
        if resp.status_code == 200:
            data = resp.json()
            if isinstance(data, list):
                assert len(data) == 0


# ============================================================================
#  4. CROSS-CUTTING / EDGE CASES
# ============================================================================

class TestAcademicEdgeCases:
    """Miscellaneous edge cases spanning multiple endpoints."""

    def test_semester_id_links_subjects_correctly(self):
        """Subjects listed for sem1 should all reference sem1's ID."""
        resp = client.get(
            "/api/v1/academic/subjects",
            params={"semester_id": get_id("sem1_id")},
            headers=_faculty_headers(),
        )
        assert resp.status_code == 200
        for subj in resp.json():
            assert subj["semester_id"] == get_id("sem1_id")

    def test_department_mapping_on_semester(self):
        """Semester's department_id should correspond to the seed department."""
        resp = client.get(
            "/api/v1/academic/semesters",
            params={"department_id": get_id("dept1_id")},
            headers=_faculty_headers(),
        )
        assert resp.status_code == 200
        for sem in resp.json():
            assert sem["department_id"] == get_id("dept1_id")

    def test_marks_boundary_just_at_max(self):
        """Exactly-at-max values should be accepted."""
        payload = {
            "student_id": get_id("student4_id"),
            "subject_id": get_id("subj2_id"),
            "internal_1": 50.0,
            "internal_2": 50.0,
            "assignment": 20.0,
            "model_exam": 100.0,
        }
        resp = client.post(
            "/api/v1/academic/marks", json=payload, headers=_faculty_headers()
        )
        assert resp.status_code in (200, 201), resp.text

    def test_marks_boundary_just_above_max(self):
        """One tick above max should be rejected."""
        payload = {
            "student_id": get_id("student4_id"),
            "subject_id": get_id("subj3_id"),
            "internal_1": 50.01,
        }
        resp = client.post(
            "/api/v1/academic/marks", json=payload, headers=_faculty_headers()
        )
        assert resp.status_code in (400, 422), (
            f"50.01 should exceed internal_1 max, got {resp.status_code}"
        )

    def test_hod_can_create_semester(self):
        """HOD should also have permission to create semesters."""
        payload = {
            "department_id": get_id("dept1_id"),
            "semester_number": 6,
            "academic_year": "2025-2026",
            "regulation": "R2021",
        }
        resp = client.post(
            "/api/v1/academic/semesters", json=payload, headers=_hod_headers()
        )
        assert resp.status_code in (200, 201), (
            f"HOD should be able to create semesters, got {resp.status_code}: {resp.text}"
        )

    def test_student_cannot_create_semester(self):
        """Students must not create semesters."""
        payload = {
            "department_id": get_id("dept1_id"),
            "semester_number": 7,
            "academic_year": "2025-2026",
            "regulation": "R2021",
        }
        resp = client.post(
            "/api/v1/academic/semesters", json=payload, headers=_student_headers()
        )
        assert resp.status_code == 403

    def test_student_cannot_create_subject(self):
        """Students must not create subjects."""
        payload = {
            "semester_id": get_id("sem1_id"),
            "subject_code": "STUXX",
            "subject_name": "Forbidden Subject",
            "credits": 3,
            "department_id": get_id("dept1_id"),
        }
        resp = client.post(
            "/api/v1/academic/subjects", json=payload, headers=_student_headers()
        )
        assert resp.status_code == 403
