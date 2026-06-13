import os
import uuid
import random
from datetime import datetime, timedelta
from passlib.context import CryptContext

os.environ["DATABASE_URL"] = "sqlite:///./phase5_test.db"

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from app.db import models
from app.db import models_phase4 as m4
from app.db import models_phase5 as m5
from app.db import models_phase6 as m6

engine = create_engine("sqlite:///./phase5_test.db", connect_args={"check_same_thread": False})
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def get_password_hash(password):
    return pwd_context.hash(password)

CHENNAI_INSTITUTES = [
    {"name": "Anna University CEG Campus", "domain": "ceg.annauniv.edu", "prefix": "ceg"},
    {"name": "Madras Institute of Technology", "domain": "mitindia.edu", "prefix": "mit"},
    {"name": "SSN College of Engineering", "domain": "ssn.edu.in", "prefix": "ssn"}
]

DEPARTMENTS = [
    "Computer Science Engineering",
    "Information Technology",
    "Electronics & Communication Engineering",
    "Electrical & Electronics Engineering",
    "Mechanical Engineering",
    "Civil Engineering",
    "Biomedical Engineering",
    "Automobile Engineering",
    "Aerospace Engineering",
    "Artificial Intelligence & Data Science"
]

MEN_PORTRAITS = [f"https://randomuser.me/api/portraits/men/{i}.jpg" for i in range(10, 60)]
WOMEN_PORTRAITS = [f"https://randomuser.me/api/portraits/women/{i}.jpg" for i in range(10, 60)]

def get_random_portrait(gender="M"):
    if gender == "M":
        return random.choice(MEN_PORTRAITS)
    return random.choice(WOMEN_PORTRAITS)

def seed_chennai_data():
    db = SessionLocal()
    default_password = get_password_hash("password123")
    
    print("Starting seeding for 3 Chennai Institutes...")

    for inst_data in CHENNAI_INSTITUTES:
        print(f"\n--- Seeding Institute: {inst_data['name']} ---")
        
        # 1. Create Institute
        inst_id_str = str(uuid.uuid4())
        institute = models.Institute(
            institute_id=inst_id_str,
            name=inst_data['name'],
            domain=inst_data['domain'],
            total_faculty=20,
            total_students=50
        )
        db.add(institute)
        db.commit()
        db.refresh(institute)
        
        # 2. Create Admin
        admin_email = f"admin@{inst_data['domain']}"
        admin = models.User(
            email=admin_email,
            hashed_password=default_password,
            role="ADMIN",
            mobile_number=f"98{random.randint(10000000, 99999999)}",
            institute_id=institute.id
        )
        db.add(admin)
        db.commit()
        
        # 3. Create Departments
        depts = []
        for d_name in DEPARTMENTS:
            dept = models.Department(name=d_name, institute_id=institute.id)
            db.add(dept)
            depts.append(dept)
        db.commit()
        for d in depts: db.refresh(d)
        
        # 4. Create Faculties (20 per institute: 1 HOD + 1 Faculty per department)
        faculties = []
        for i, dept in enumerate(depts):
            for role_type in ["HOD", "FACULTY"]:
                gender = random.choice(["M", "F"])
                idx = 0 if role_type == "HOD" else 1
                email = f"{inst_data['prefix']}_{dept.name.lower().replace(' ', '_').replace('&', '')}_{role_type.lower()}{idx}@{inst_data['domain']}"
                
                fac = models.User(
                    email=email,
                    hashed_password=default_password,
                    role=role_type,
                    mobile_number=f"94{random.randint(10000000, 99999999)}",
                    institute_id=institute.id,
                    department_id=dept.id
                )
                db.add(fac)
                db.commit()
                db.refresh(fac)
                faculties.append(fac)
                
                if role_type == "HOD":
                    dept.hod_id = fac.id
                    db.commit()

                # Add Faculty Profile with realistic image
                fac_prof = models.FacultyProfile(
                    user_id=fac.id,
                    employee_id=f"EMP{inst_data['prefix'].upper()}{random.randint(1000, 9999)}",
                    department_id=dept.id,
                    profile_photo_url=get_random_portrait(gender),
                    qualification="Ph.D" if role_type == "HOD" else "M.E/M.Tech",
                    experience=random.randint(5, 25),
                    research_papers_count=random.randint(2, 15),
                    biography="Experienced faculty member specializing in core engineering subjects."
                )
                db.add(fac_prof)
                
        db.commit()
        
        # 5. Create Students (50 per institute -> 5 per department)
        for dept in depts:
            for j in range(5):
                gender = random.choice(["M", "F"])
                email = f"{inst_data['prefix']}_stu{j}_{dept.name.lower().replace(' ', '')}@{inst_data['domain']}"
                stu = models.User(
                    email=email,
                    hashed_password=default_password,
                    role="STUDENT",
                    mobile_number=f"90{random.randint(10000000, 99999999)}",
                    institute_id=institute.id,
                    department_id=dept.id
                )
                db.add(stu)
                db.commit()
                db.refresh(stu)
                
                # Student Profile
                stu_prof = models.StudentProfile(
                    user_id=stu.id,
                    enrollment_number=f"ENR{inst_data['prefix'].upper()}{random.randint(10000, 99999)}",
                    department_id=dept.id,
                    batch_year=2025,
                    gender="Male" if gender == "M" else "Female"
                )
                db.add(stu_prof)
                
                # CGPA
                cgpa_val = round(random.uniform(6.0, 9.5), 2)
                db.add(m4.CGPARecord(student_id=stu.id, cgpa=cgpa_val, total_credits_earned=60))
                
                # Attendance
                attendance_val = round(random.uniform(65.0, 98.0), 2)
                db.add(m4.AttendanceRecord(student_id=stu.id, subject_id=uuid.uuid4(), month="2024-08", total_classes=100, attended_classes=int(attendance_val), percentage=attendance_val))
                
                # Career Readiness
                db.add(m6.CareerProfile(student_id=stu.id, career_readiness_score=round(random.uniform(40, 90), 2), preferred_role="Software Engineer"))
                
        db.commit()
        print(f"Finished {inst_data['name']}")
    
    print("\n--- Seeding Complete! ---")
    print("Test users ready. Passwords are 'password123'")

if __name__ == "__main__":
    seed_chennai_data()
