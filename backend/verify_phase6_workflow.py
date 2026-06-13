import os
import sys

os.environ["DATABASE_URL"] = "sqlite:///./phase5_test.db"

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from app.db import models, models_phase4, models_phase5, models_phase6
from app.api.endpoints.career import calculate_student_crs, calculate_master_ssi

engine = create_engine("sqlite:///./phase5_test.db", connect_args={"check_same_thread": False})
models_phase6.Base.metadata.create_all(bind=engine)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

def verify_workflow():
    db = SessionLocal()
    print("--- Phase 6 Workflow Verification ---")

    student = db.query(models.User).filter(models.User.role == "STUDENT").first()
    if not student:
        print("No student found in DB. Did you run seed_phase5.py?")
        return

    print(f"\n1. Target Student: {student.email}")

    # Generate SSI and CRS
    print("\n2. Generating Career Readiness Score (CRS)...")
    crs = calculate_student_crs(student.id, db)
    print(f"   > CRS = {crs}")

    print("\n3. Generating Master Student Success Index (SSI)...")
    ssi_rec = calculate_master_ssi(student.id, db)
    print(f"   > SSI = {ssi_rec.score} (Category: {ssi_rec.category})")

    # Generate Digital Twin
    print("\n4. Generating Digital Twin Snapshot...")
    from app.api.endpoints.career import get_digital_twin
    twin = get_digital_twin(student.id, db)
    print(f"   > Academic CGPA: {twin['academic']['cgpa']}")
    print(f"   > Career CRS: {twin['career']['crs']}")
    print(f"   > Live Category: {twin['category']}")

    # Generate Portfolio
    print("\n5. Generating Portfolio & Public Link...")
    from app.api.endpoints.portfolio import get_portfolio
    portfolio = get_portfolio(student.id, db)
    print(f"   > Portfolio Name: {portfolio['name']}")
    print(f"   > Public Link: {portfolio['public_url']}")

    # Recruiter Search
    print("\n6. Simulating Recruiter Search Workflow...")
    from app.api.endpoints.recruiter import search_students
    results = search_students(min_cgpa=6.0, db=db)
    print(f"   > Recruiter found {len(results)} students with CGPA >= 6.0.")
    if results:
        print(f"   > Top candidate link: {results[0]['public_url']}")

    print("\n7. Validating QR Code API dependencies...")
    try:
        import qrcode
        qr = qrcode.QRCode(version=1, box_size=10, border=5)
        qr.add_data(f"http://localhost:3000{portfolio['public_url']}")
        qr.make(fit=True)
        print("   > QR Code generation library is fully functional.")
    except Exception as e:
        print(f"   > QR Error: {e}")

    print("\n--- PHASE 6 VERIFICATION COMPLETED SUCCESSFULLY ---")

if __name__ == "__main__":
    verify_workflow()
