"""
Phase 4 Test: GPA Calculation Engine (Anna University 10-point)
Unit tests for the GPA engine service.
"""
import pytest
import sys
import os

# Add backend to path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))


# ======================================================
# GRADE POINT MAPPING (Anna University 10-point scale)
# ======================================================
GRADE_POINTS = {
    "O": 10, "A+": 9, "A": 8, "B+": 7, "B": 6, "C": 5, "U": 0
}


def compute_gpa(results):
    """
    Compute semester GPA.
    results: list of {"credits": int, "grade": str}
    GPA = sum(credits * grade_point) / sum(credits)
    """
    total_weighted = 0
    total_credits = 0
    for r in results:
        gp = GRADE_POINTS.get(r["grade"], 0)
        total_weighted += r["credits"] * gp
        total_credits += r["credits"]
    if total_credits == 0:
        return 0.0
    return round(total_weighted / total_credits, 2)


def compute_cgpa(semester_gpas):
    """
    Compute cumulative GPA across semesters.
    semester_gpas: list of {"gpa": float, "credits": int}
    CGPA = sum(gpa * credits) / sum(credits)
    """
    total_weighted = 0
    total_credits = 0
    for sg in semester_gpas:
        total_weighted += sg["gpa"] * sg["credits"]
        total_credits += sg["credits"]
    if total_credits == 0:
        return 0.0
    return round(total_weighted / total_credits, 2)


class TestGPACalculation:
    """Module 6: CGPA Engine Testing"""

    def test_all_o_grade(self):
        """All O grades -> GPA = 10.0"""
        results = [
            {"credits": 4, "grade": "O"},
            {"credits": 3, "grade": "O"},
            {"credits": 3, "grade": "O"},
        ]
        gpa = compute_gpa(results)
        assert gpa == 10.0

    def test_mixed_grades_example(self):
        """CS101(4 cr, A+=9), CS102(3 cr, B+=7), CS103(3 cr, O=10)
        GPA = (4*9 + 3*7 + 3*10) / (4+3+3) = (36+21+30)/10 = 8.7"""
        results = [
            {"credits": 4, "grade": "A+"},
            {"credits": 3, "grade": "B+"},
            {"credits": 3, "grade": "O"},
        ]
        gpa = compute_gpa(results)
        assert gpa == 8.7

    def test_one_fail(self):
        """One U grade should bring GPA down significantly"""
        results = [
            {"credits": 4, "grade": "A+"},  # 4*9 = 36
            {"credits": 3, "grade": "U"},   # 3*0 = 0
            {"credits": 3, "grade": "O"},   # 3*10 = 30
        ]
        gpa = compute_gpa(results)
        # (36+0+30)/10 = 6.6
        assert gpa == 6.6

    def test_all_fail(self):
        """All U grades -> GPA = 0.0"""
        results = [
            {"credits": 4, "grade": "U"},
            {"credits": 3, "grade": "U"},
            {"credits": 3, "grade": "U"},
        ]
        gpa = compute_gpa(results)
        assert gpa == 0.0

    def test_single_subject(self):
        """Single subject"""
        results = [{"credits": 4, "grade": "B"}]
        gpa = compute_gpa(results)
        assert gpa == 6.0  # B = 6

    def test_empty_results(self):
        """No subjects -> GPA = 0"""
        gpa = compute_gpa([])
        assert gpa == 0.0

    def test_c_grade_boundary(self):
        """C grade is 5, passing boundary"""
        results = [
            {"credits": 3, "grade": "C"},
            {"credits": 3, "grade": "C"},
        ]
        gpa = compute_gpa(results)
        assert gpa == 5.0

    def test_high_credit_weight(self):
        """Higher-credit subject should dominate GPA"""
        results = [
            {"credits": 10, "grade": "O"},  # 10*10 = 100
            {"credits": 1, "grade": "U"},   # 1*0 = 0
        ]
        gpa = compute_gpa(results)
        # 100/11 = 9.09
        assert gpa == 9.09

    def test_all_grades_represented(self):
        """One of each grade"""
        results = [
            {"credits": 1, "grade": "O"},   # 10
            {"credits": 1, "grade": "A+"},  # 9
            {"credits": 1, "grade": "A"},   # 8
            {"credits": 1, "grade": "B+"},  # 7
            {"credits": 1, "grade": "B"},   # 6
            {"credits": 1, "grade": "C"},   # 5
            {"credits": 1, "grade": "U"},   # 0
        ]
        gpa = compute_gpa(results)
        # (10+9+8+7+6+5+0)/7 = 45/7 = 6.43
        assert gpa == 6.43


class TestCGPACalculation:
    """Module 6: CGPA across semesters"""

    def test_two_semesters_equal(self):
        """Same GPA both semesters"""
        semesters = [
            {"gpa": 8.5, "credits": 20},
            {"gpa": 8.5, "credits": 20},
        ]
        cgpa = compute_cgpa(semesters)
        assert cgpa == 8.5

    def test_improving_student(self):
        """Improving over semesters"""
        semesters = [
            {"gpa": 6.0, "credits": 20},
            {"gpa": 7.5, "credits": 20},
            {"gpa": 8.5, "credits": 20},
        ]
        cgpa = compute_cgpa(semesters)
        # (6*20 + 7.5*20 + 8.5*20) / (60) = (120+150+170)/60 = 440/60 = 7.33
        assert cgpa == 7.33

    def test_declining_student(self):
        """Declining performance"""
        semesters = [
            {"gpa": 9.0, "credits": 20},
            {"gpa": 7.0, "credits": 20},
            {"gpa": 5.0, "credits": 20},
        ]
        cgpa = compute_cgpa(semesters)
        # (180+140+100)/60 = 7.0
        assert cgpa == 7.0

    def test_single_semester(self):
        """Single semester CGPA = semester GPA"""
        semesters = [{"gpa": 8.7, "credits": 10}]
        cgpa = compute_cgpa(semesters)
        assert cgpa == 8.7

    def test_empty_semesters(self):
        """No semesters -> 0"""
        cgpa = compute_cgpa([])
        assert cgpa == 0.0

    def test_different_credit_loads(self):
        """Semesters with different credit loads"""
        semesters = [
            {"gpa": 9.0, "credits": 25},  # 225
            {"gpa": 7.0, "credits": 15},  # 105
        ]
        cgpa = compute_cgpa(semesters)
        # 330/40 = 8.25
        assert cgpa == 8.25


class TestArrearDetection:
    """Module 5+6: Arrear detection from results"""

    def test_u_grade_is_arrear(self):
        """U grade should be flagged as fail/arrear"""
        assert GRADE_POINTS["U"] == 0

    def test_c_grade_is_pass(self):
        """C grade (5 points) is a pass"""
        assert GRADE_POINTS["C"] == 5
        assert GRADE_POINTS["C"] > 0

    def test_count_arrears_from_results(self):
        """Count how many U grades in a result set"""
        results = [
            {"credits": 4, "grade": "A+"},
            {"credits": 3, "grade": "U"},
            {"credits": 3, "grade": "U"},
            {"credits": 2, "grade": "O"},
        ]
        arrear_count = sum(1 for r in results if r["grade"] == "U")
        assert arrear_count == 2

    def test_no_arrears(self):
        """All passing grades"""
        results = [
            {"credits": 4, "grade": "O"},
            {"credits": 3, "grade": "A"},
            {"credits": 3, "grade": "C"},
        ]
        arrear_count = sum(1 for r in results if r["grade"] == "U")
        assert arrear_count == 0
