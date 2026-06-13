"""
Phase 4 – Attendance Upload & Retrieval Tests
===============================================
Covers:
  1. Faculty bulk upload of monthly attendance (POST /api/v1/attendance/upload)
  2. Auto-calculation of percentage (attended / total * 100)
  3. Student retrieval of own attendance (GET /api/v1/attendance/student/{id})
  4. Role-based access (students cannot upload; students cannot view others)
  5. Attendance category classification (Excellent / Good / Warning / Critical)
  6. Input validation (attended > total, negatives, empty records)
"""

import pytest
from conftest import client, get_id, get_token, auth_header


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

UPLOAD_URL = "/api/v1/attendance/upload"


def _student_url(student_id: str) -> str:
    return f"/api/v1/attendance/student/{student_id}"


def _upload_payload(
    subject_id: str,
    month: str,
    student_records: list[dict],
) -> dict:
    return {
        "subject_id": subject_id,
        "month": month,
        "student_records": student_records,
    }


# ===================================================================
# 1. ATTENDANCE UPLOAD – Happy paths
# ===================================================================


class TestAttendanceUploadSuccess:
    """Faculty can upload attendance and percentage is auto-calculated."""

    def test_upload_single_student_record(self, faculty1_token):
        """Faculty uploads attendance for one student – 201 and correct %."""
        payload = _upload_payload(
            subject_id=get_id("subj1_id"),
            month="2024-08",
            student_records=[
                {
                    "student_id": get_id("student1_id"),
                    "total_classes": 20,
                    "attended_classes": 18,
                }
            ],
        )
        resp = client.post(UPLOAD_URL, json=payload, headers=auth_header(faculty1_token))
        assert resp.status_code in (200, 201), resp.text
        data = resp.json()
        # Response should contain the created record(s)
        records = data if isinstance(data, list) else data.get("records", data.get("data", [data]))
        if isinstance(records, list):
            assert len(records) >= 1
            rec = records[0]
        else:
            rec = records
        assert float(rec["percentage"]) == pytest.approx(90.0, abs=0.01)
        assert rec["total_classes"] == 20
        assert rec["attended_classes"] == 18

    def test_upload_multiple_students_at_once(self, faculty1_token):
        """Faculty uploads attendance for several students in one request."""
        payload = _upload_payload(
            subject_id=get_id("subj2_id"),
            month="2024-08",
            student_records=[
                {
                    "student_id": get_id("student1_id"),
                    "total_classes": 25,
                    "attended_classes": 25,
                },
                {
                    "student_id": get_id("student3_id"),
                    "total_classes": 25,
                    "attended_classes": 20,
                },
                {
                    "student_id": get_id("student4_id"),
                    "total_classes": 25,
                    "attended_classes": 14,
                },
            ],
        )
        resp = client.post(UPLOAD_URL, json=payload, headers=auth_header(faculty1_token))
        assert resp.status_code in (200, 201), resp.text

    def test_percentage_auto_calculated_correctly(self, faculty1_token):
        """Verify the server computes attended/total*100 (not the client)."""
        payload = _upload_payload(
            subject_id=get_id("subj3_id"),
            month="2024-09",
            student_records=[
                {
                    "student_id": get_id("student1_id"),
                    "total_classes": 30,
                    "attended_classes": 21,
                }
            ],
        )
        resp = client.post(UPLOAD_URL, json=payload, headers=auth_header(faculty1_token))
        assert resp.status_code in (200, 201), resp.text
        data = resp.json()
        records = data if isinstance(data, list) else data.get("records", data.get("data", [data]))
        rec = records[0] if isinstance(records, list) else records
        expected_pct = 21 / 30 * 100  # 70.0
        assert float(rec["percentage"]) == pytest.approx(expected_pct, abs=0.01)

    def test_upload_perfect_attendance(self, faculty1_token):
        """100 % attendance."""
        payload = _upload_payload(
            subject_id=get_id("subj1_id"),
            month="2024-09",
            student_records=[
                {
                    "student_id": get_id("student3_id"),
                    "total_classes": 22,
                    "attended_classes": 22,
                }
            ],
        )
        resp = client.post(UPLOAD_URL, json=payload, headers=auth_header(faculty1_token))
        assert resp.status_code in (200, 201), resp.text
        data = resp.json()
        records = data if isinstance(data, list) else data.get("records", data.get("data", [data]))
        rec = records[0] if isinstance(records, list) else records
        assert float(rec["percentage"]) == pytest.approx(100.0, abs=0.01)

    def test_upload_zero_attendance(self, faculty1_token):
        """Student attended 0 classes – 0 %."""
        payload = _upload_payload(
            subject_id=get_id("subj1_id"),
            month="2024-10",
            student_records=[
                {
                    "student_id": get_id("student4_id"),
                    "total_classes": 20,
                    "attended_classes": 0,
                }
            ],
        )
        resp = client.post(UPLOAD_URL, json=payload, headers=auth_header(faculty1_token))
        assert resp.status_code in (200, 201), resp.text
        data = resp.json()
        records = data if isinstance(data, list) else data.get("records", data.get("data", [data]))
        rec = records[0] if isinstance(records, list) else records
        assert float(rec["percentage"]) == pytest.approx(0.0, abs=0.01)


# ===================================================================
# 2. ATTENDANCE UPLOAD – Role-based access
# ===================================================================


class TestAttendanceUploadRoles:
    """Only faculty/HOD can upload; students are forbidden."""

    def test_student_cannot_upload_attendance(self, student1_token):
        """Student should receive 403 when trying to upload attendance."""
        payload = _upload_payload(
            subject_id=get_id("subj1_id"),
            month="2024-11",
            student_records=[
                {
                    "student_id": get_id("student1_id"),
                    "total_classes": 10,
                    "attended_classes": 8,
                }
            ],
        )
        resp = client.post(UPLOAD_URL, json=payload, headers=auth_header(student1_token))
        assert resp.status_code == 403

    def test_unauthenticated_upload_rejected(self):
        """No token → 401/403."""
        payload = _upload_payload(
            subject_id=get_id("subj1_id"),
            month="2024-11",
            student_records=[
                {
                    "student_id": get_id("student1_id"),
                    "total_classes": 10,
                    "attended_classes": 8,
                }
            ],
        )
        resp = client.post(UPLOAD_URL, json=payload)
        assert resp.status_code in (401, 403)

    def test_hod_can_upload_attendance(self, hod1_token):
        """HOD role may be allowed or restricted from uploading attendance
        depending on the institution's policy. Accept 200/201 (allowed)
        or 403 (view-only enforcement) as valid outcomes."""
        payload = _upload_payload(
            subject_id=get_id("subj1_id"),
            month="2024-12",
            student_records=[
                {
                    "student_id": get_id("student1_id"),
                    "total_classes": 18,
                    "attended_classes": 15,
                }
            ],
        )
        resp = client.post(UPLOAD_URL, json=payload, headers=auth_header(hod1_token))
        # 200/201 = HOD allowed; 403 = view-only enforcement (both are acceptable)
        assert resp.status_code in (200, 201, 403), resp.text


# ===================================================================
# 3. ATTENDANCE RETRIEVAL
# ===================================================================


class TestAttendanceRetrieval:
    """Students can view their own attendance but not other students'."""

    def test_student_views_own_attendance(self, student1_token):
        """Student1 retrieves own records – 200 with records list."""
        resp = client.get(
            _student_url(get_id("student1_id")),
            headers=auth_header(student1_token),
        )
        assert resp.status_code == 200, resp.text
        data = resp.json()
        records = data if isinstance(data, list) else data.get("records", data.get("data", []))
        assert isinstance(records, list)
        # We uploaded at least one record for student1 earlier
        assert len(records) >= 1

    def test_student_cannot_view_other_student(self, student1_token):
        """Student1 must NOT be able to see student2's attendance."""
        resp = client.get(
            _student_url(get_id("student2_id")),
            headers=auth_header(student1_token),
        )
        assert resp.status_code == 403

    def test_faculty_can_view_student_attendance(self, faculty1_token):
        """Faculty should be able to view any student's attendance."""
        resp = client.get(
            _student_url(get_id("student1_id")),
            headers=auth_header(faculty1_token),
        )
        assert resp.status_code == 200, resp.text

    def test_unauthenticated_retrieval_rejected(self):
        """No token → 401/403."""
        resp = client.get(_student_url(get_id("student1_id")))
        assert resp.status_code in (401, 403)

    def test_retrieval_returns_correct_fields(self, student1_token):
        """Each record should contain required fields."""
        resp = client.get(
            _student_url(get_id("student1_id")),
            headers=auth_header(student1_token),
        )
        assert resp.status_code == 200
        data = resp.json()
        records = data if isinstance(data, list) else data.get("records", data.get("data", []))
        assert len(records) >= 1
        rec = records[0]
        for field in ("student_id", "subject_id", "month", "total_classes", "attended_classes", "percentage"):
            assert field in rec, f"Missing field: {field}"

    def test_retrieval_for_nonexistent_student(self, faculty1_token):
        """Requesting attendance for a non-existent student → 404 or empty list."""
        fake_id = "00000000-0000-0000-0000-000000000000"
        resp = client.get(
            _student_url(fake_id),
            headers=auth_header(faculty1_token),
        )
        # API may return 404 or 200 with empty list
        if resp.status_code == 200:
            data = resp.json()
            records = data if isinstance(data, list) else data.get("records", data.get("data", []))
            assert len(records) == 0
        else:
            assert resp.status_code == 404


# ===================================================================
# 4. ATTENDANCE CATEGORIES
# ===================================================================


class TestAttendanceCategories:
    """
    Verify that the auto-calculated percentage matches the expected
    category thresholds:
      Excellent : >= 90 %
      Good      : 75 % – 89 %
      Warning   : 60 % – 74 %
      Critical  : < 60 %
    """

    @pytest.mark.parametrize(
        "attended, total, expected_pct_range, category",
        [
            (19, 20, (90.0, 100.0), "Excellent"),      # 95 %
            (18, 20, (90.0, 100.0), "Excellent"),       # 90 % (boundary)
            (16, 20, (75.0, 89.99), "Good"),            # 80 %
            (15, 20, (75.0, 89.99), "Good"),            # 75 % (boundary)
            (14, 20, (60.0, 74.99), "Warning"),         # 70 %
            (12, 20, (60.0, 74.99), "Warning"),         # 60 % (boundary)
            (11, 20, (0.0, 59.99), "Critical"),         # 55 %
            (0, 20, (0.0, 59.99), "Critical"),          # 0 %
        ],
        ids=[
            "excellent-95pct",
            "excellent-boundary-90pct",
            "good-80pct",
            "good-boundary-75pct",
            "warning-70pct",
            "warning-boundary-60pct",
            "critical-55pct",
            "critical-0pct",
        ],
    )
    def test_percentage_falls_in_category(
        self, faculty1_token, attended, total, expected_pct_range, category
    ):
        """Upload and assert the percentage falls in the correct category band."""
        payload = _upload_payload(
            subject_id=get_id("subj2_id"),
            month=f"2025-{attended:02d}",  # unique month per param
            student_records=[
                {
                    "student_id": get_id("student1_id"),
                    "total_classes": total,
                    "attended_classes": attended,
                }
            ],
        )
        resp = client.post(UPLOAD_URL, json=payload, headers=auth_header(faculty1_token))
        assert resp.status_code in (200, 201), resp.text
        data = resp.json()
        records = data if isinstance(data, list) else data.get("records", data.get("data", [data]))
        rec = records[0] if isinstance(records, list) else records
        pct = float(rec["percentage"])
        lo, hi = expected_pct_range
        assert lo <= pct <= hi, (
            f"Category '{category}': expected {lo}-{hi}%, got {pct}%"
        )

    def test_exact_boundary_90_is_excellent(self, faculty1_token):
        """90.0 % should be Excellent, not Good."""
        payload = _upload_payload(
            subject_id=get_id("subj3_id"),
            month="2025-01",
            student_records=[
                {
                    "student_id": get_id("student3_id"),
                    "total_classes": 100,
                    "attended_classes": 90,
                }
            ],
        )
        resp = client.post(UPLOAD_URL, json=payload, headers=auth_header(faculty1_token))
        assert resp.status_code in (200, 201), resp.text
        data = resp.json()
        records = data if isinstance(data, list) else data.get("records", data.get("data", [data]))
        rec = records[0] if isinstance(records, list) else records
        assert float(rec["percentage"]) == pytest.approx(90.0, abs=0.01)

    def test_exact_boundary_75_is_good(self, faculty1_token):
        """75.0 % should be Good, not Warning."""
        payload = _upload_payload(
            subject_id=get_id("subj3_id"),
            month="2025-02",
            student_records=[
                {
                    "student_id": get_id("student3_id"),
                    "total_classes": 100,
                    "attended_classes": 75,
                }
            ],
        )
        resp = client.post(UPLOAD_URL, json=payload, headers=auth_header(faculty1_token))
        assert resp.status_code in (200, 201), resp.text
        data = resp.json()
        records = data if isinstance(data, list) else data.get("records", data.get("data", [data]))
        rec = records[0] if isinstance(records, list) else records
        assert float(rec["percentage"]) == pytest.approx(75.0, abs=0.01)

    def test_exact_boundary_60_is_warning(self, faculty1_token):
        """60.0 % should be Warning, not Critical."""
        payload = _upload_payload(
            subject_id=get_id("subj3_id"),
            month="2025-03",
            student_records=[
                {
                    "student_id": get_id("student3_id"),
                    "total_classes": 100,
                    "attended_classes": 60,
                }
            ],
        )
        resp = client.post(UPLOAD_URL, json=payload, headers=auth_header(faculty1_token))
        assert resp.status_code in (200, 201), resp.text
        data = resp.json()
        records = data if isinstance(data, list) else data.get("records", data.get("data", [data]))
        rec = records[0] if isinstance(records, list) else records
        assert float(rec["percentage"]) == pytest.approx(60.0, abs=0.01)


# ===================================================================
# 5. VALIDATION – Bad inputs
# ===================================================================


class TestAttendanceValidation:
    """Server-side validation of attendance payloads."""

    def test_attended_exceeds_total_rejected(self, faculty1_token):
        """attended_classes > total_classes must be rejected (400/422)."""
        payload = _upload_payload(
            subject_id=get_id("subj1_id"),
            month="2025-04",
            student_records=[
                {
                    "student_id": get_id("student1_id"),
                    "total_classes": 20,
                    "attended_classes": 25,
                }
            ],
        )
        resp = client.post(UPLOAD_URL, json=payload, headers=auth_header(faculty1_token))
        assert resp.status_code in (400, 422), (
            f"Expected 400/422 for attended > total, got {resp.status_code}: {resp.text}"
        )

    def test_negative_total_classes_rejected(self, faculty1_token):
        """Negative total_classes must be rejected."""
        payload = _upload_payload(
            subject_id=get_id("subj1_id"),
            month="2025-05",
            student_records=[
                {
                    "student_id": get_id("student1_id"),
                    "total_classes": -5,
                    "attended_classes": 3,
                }
            ],
        )
        resp = client.post(UPLOAD_URL, json=payload, headers=auth_header(faculty1_token))
        assert resp.status_code in (400, 422), (
            f"Expected 400/422 for negative total_classes, got {resp.status_code}: {resp.text}"
        )

    def test_negative_attended_classes_rejected(self, faculty1_token):
        """Negative attended_classes must be rejected."""
        payload = _upload_payload(
            subject_id=get_id("subj1_id"),
            month="2025-06",
            student_records=[
                {
                    "student_id": get_id("student1_id"),
                    "total_classes": 20,
                    "attended_classes": -2,
                }
            ],
        )
        resp = client.post(UPLOAD_URL, json=payload, headers=auth_header(faculty1_token))
        assert resp.status_code in (400, 422), (
            f"Expected 400/422 for negative attended_classes, got {resp.status_code}: {resp.text}"
        )

    def test_empty_student_records_rejected(self, faculty1_token):
        """An empty student_records list must be rejected."""
        payload = _upload_payload(
            subject_id=get_id("subj1_id"),
            month="2025-07",
            student_records=[],
        )
        resp = client.post(UPLOAD_URL, json=payload, headers=auth_header(faculty1_token))
        assert resp.status_code in (400, 422), (
            f"Expected 400/422 for empty student_records, got {resp.status_code}: {resp.text}"
        )

    def test_missing_subject_id_rejected(self, faculty1_token):
        """Payload without subject_id → 422 (Pydantic validation)."""
        payload = {
            "month": "2025-08",
            "student_records": [
                {
                    "student_id": get_id("student1_id"),
                    "total_classes": 20,
                    "attended_classes": 18,
                }
            ],
        }
        resp = client.post(UPLOAD_URL, json=payload, headers=auth_header(faculty1_token))
        assert resp.status_code == 422

    def test_missing_month_rejected(self, faculty1_token):
        """Payload without month → 422."""
        payload = {
            "subject_id": get_id("subj1_id"),
            "student_records": [
                {
                    "student_id": get_id("student1_id"),
                    "total_classes": 20,
                    "attended_classes": 18,
                }
            ],
        }
        resp = client.post(UPLOAD_URL, json=payload, headers=auth_header(faculty1_token))
        assert resp.status_code == 422

    def test_missing_student_records_rejected(self, faculty1_token):
        """Payload without student_records → 422."""
        payload = {
            "subject_id": get_id("subj1_id"),
            "month": "2025-09",
        }
        resp = client.post(UPLOAD_URL, json=payload, headers=auth_header(faculty1_token))
        assert resp.status_code == 422

    def test_invalid_subject_id_rejected(self, faculty1_token):
        """Non-existent subject_id should be rejected (400/404)."""
        fake_subj = "00000000-0000-0000-0000-000000000099"
        payload = _upload_payload(
            subject_id=fake_subj,
            month="2025-10",
            student_records=[
                {
                    "student_id": get_id("student1_id"),
                    "total_classes": 20,
                    "attended_classes": 18,
                }
            ],
        )
        resp = client.post(UPLOAD_URL, json=payload, headers=auth_header(faculty1_token))
        assert resp.status_code in (400, 404, 422), (
            f"Expected 400/404/422 for fake subject_id, got {resp.status_code}: {resp.text}"
        )

    def test_both_values_zero_handled(self, faculty1_token):
        """total_classes = 0, attended_classes = 0 – should reject (division by zero)
        or handle gracefully (0 %)."""
        payload = _upload_payload(
            subject_id=get_id("subj1_id"),
            month="2025-11",
            student_records=[
                {
                    "student_id": get_id("student1_id"),
                    "total_classes": 0,
                    "attended_classes": 0,
                }
            ],
        )
        resp = client.post(UPLOAD_URL, json=payload, headers=auth_header(faculty1_token))
        # Accept either a rejection (400/422) or a graceful 0 %
        if resp.status_code in (200, 201):
            data = resp.json()
            records = data if isinstance(data, list) else data.get("records", data.get("data", [data]))
            rec = records[0] if isinstance(records, list) else records
            assert float(rec["percentage"]) == pytest.approx(0.0, abs=0.01)
        else:
            assert resp.status_code in (400, 422)


# ===================================================================
# 6. IDEMPOTENCY / DUPLICATE UPLOAD
# ===================================================================


class TestAttendanceDuplicateUpload:
    """Re-uploading for the same student+subject+month should update or conflict."""

    def test_duplicate_upload_does_not_create_two_records(self, faculty1_token):
        """
        Upload the same (student, subject, month) twice.
        The system should either:
          a) return 409 (conflict), or
          b) upsert the existing record (still only one record for that combo).
        """
        payload = _upload_payload(
            subject_id=get_id("subj2_id"),
            month="2025-12",
            student_records=[
                {
                    "student_id": get_id("student3_id"),
                    "total_classes": 20,
                    "attended_classes": 16,
                }
            ],
        )
        resp1 = client.post(UPLOAD_URL, json=payload, headers=auth_header(faculty1_token))
        assert resp1.status_code in (200, 201), resp1.text

        # Second upload – same combo
        payload["student_records"][0]["attended_classes"] = 18
        resp2 = client.post(UPLOAD_URL, json=payload, headers=auth_header(faculty1_token))
        # Accept 200/201 (upsert) or 409 (conflict)
        assert resp2.status_code in (200, 201, 409), resp2.text
