import os
import sys

# Point to the seeded database
os.environ["DATABASE_URL"] = "sqlite:///./phase5_test.db"

# Override the app DB config or directly bind
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

engine = create_engine("sqlite:///./phase5_test.db", connect_args={"check_same_thread": False})
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

from app.api.endpoints.intelligence import calculate_department_health, calculate_faculty_fii, calculate_student_pri
from app.db import models
from app.db import models_phase5 as m5
from app.db import models_phase4 as m4

def run_validations():
    db = SessionLocal()
    
    print("--- 1. Validating Institute Data ---")
    inst = db.query(models.Institute).first()
    assert inst.name == "ABC Institute of Technology"
    print("Institute: OK")

    print("\n--- 2. Validating Department Data ---")
    depts = db.query(models.Department).all()
    assert len(depts) == 5
    print("Departments: OK")

    print("\n--- 3. Validating Faculty Distribution ---")
    facs = db.query(models.User).filter(models.User.role.in_(["FACULTY", "HOD"])).all()
    assert len(facs) == 20
    print("Faculty Count: OK")

    print("\n--- 4. Validating Student Distribution ---")
    students = db.query(models.User).filter(models.User.role == "STUDENT").all()
    assert len(students) == 100
    print("Student Count: OK")

    print("\n--- 5. Validating DHI (Department Health Index) ---")
    for d in depts:
        dhi = calculate_department_health(d.id, db)
        print(f"Dept {d.name}: DHI={dhi.score} Category={dhi.category}")
    print("DHI Calculations: OK")

    print("\n--- 6. Validating PRI (Placement Readiness Index) ---")
    # Take a few students
    for s in students[:5]:
        pri = calculate_student_pri(s.id, db)
        print(f"Student {s.email}: PRI={pri.score} Category={pri.category}")
    print("PRI Calculations: OK")

    print("\n--- 7. Validating Predictive Analytics ---")
    # Using the router logic
    from app.api.endpoints.intelligence import get_predictive_students
    # We pass a dummy current user (HOD)
    dummy_hod = db.query(models.User).filter(models.User.role == "HOD").first()
    preds = get_predictive_students(db, dummy_hod)
    print(f"Generated {len(preds)} predictive records for HOD.")
    print("Predictive Engine: OK")
    
    print("\n--- 8. Validating FII (Faculty Impact Index) ---")
    for f in facs[:3]:
        fii = calculate_faculty_fii(f.id, db)
        print(f"Faculty {f.email}: FII={fii.score} Category={fii.category}")
    print("FII Calculations: OK")
    
    print("\n--- 9. Validating Accreditation Data Hub (NAAC/NBA) ---")
    from app.api.endpoints.reports import get_accreditation_data
    admin_user = models.User(role="ADMIN", institute_id=inst.id)
    naac_data = get_accreditation_data("NAAC", db, admin_user)
    print(f"NAAC Data Hub generated: Students={naac_data['student_strength']}, Faculty={naac_data['faculty_strength']}")
    print("Accreditation Hub: OK")

    print("\n--- 10. Validating Smart Recommendations ---")
    from app.api.endpoints.recommendations import get_department_recommendations
    recs = get_department_recommendations(depts[0].id, db, dummy_hod)
    print(f"Found {len(recs)} recommendations for Dept {depts[0].name}.")
    print("Recommendations: OK")

    print("\n--- Phase 5 Validations Completed Successfully ---")

if __name__ == "__main__":
    run_validations()
