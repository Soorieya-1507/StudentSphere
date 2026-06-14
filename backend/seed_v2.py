import os
import sys
import uuid
import random
from datetime import datetime
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

# Add app to path
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
from app.db import models, models_phase4 as m4, models_phase5 as m5, models_phase6 as m6
from app.db.database import Base
from app.core.config import settings
from app.core.security import get_password_hash

engine = create_engine(settings.DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

INSTITUTES = [
    {"name": "Kalaignar Institute of Technology", "code": "KIT001", "domain": "kit.ac.in", "city": "Chennai"},
    {"name": "Karpagam College of Engineering", "code": "KCE001", "domain": "kce.ac.in", "city": "Chennai"},
    {"name": "Chennai Institute of Technology", "code": "CIT001", "domain": "cit.edu.in", "city": "Chennai"},
]

DEPARTMENTS = [
    "Computer Science Engineering", "Information Technology", "Artificial Intelligence",
    "Electronics & Communication", "Mechanical Engineering", "Civil Engineering",
    "Electrical Engineering", "Cyber Security", "Data Science", "Biomedical Engineering"
]

MALE_FACES = [
    "https://api.dicebear.com/7.x/avataaars/svg?seed=John&gender=male",
    "https://api.dicebear.com/7.x/avataaars/svg?seed=Robert&gender=male",
    "https://api.dicebear.com/7.x/avataaars/svg?seed=Michael&gender=male",
    "https://api.dicebear.com/7.x/avataaars/svg?seed=William&gender=male"
]
FEMALE_FACES = [
    "https://api.dicebear.com/7.x/avataaars/svg?seed=Mary&gender=female",
    "https://api.dicebear.com/7.x/avataaars/svg?seed=Patricia&gender=female",
    "https://api.dicebear.com/7.x/avataaars/svg?seed=Linda&gender=female",
    "https://api.dicebear.com/7.x/avataaars/svg?seed=Barbara&gender=female"
]

def seed_database():
    db = SessionLocal()
    try:
        # Base setup
        print("Starting V2.5 Seeding Process...")
        Base.metadata.create_all(bind=engine)
        
        # Add basic achievement categories
        categories = [
            {"name": "Hackathon Winner", "default_points": 50},
            {"name": "Internship Completion", "default_points": 30},
            {"name": "Research Publication", "default_points": 40},
            {"name": "Online Certification", "default_points": 10},
        ]
        cat_ids = []
        for cat in categories:
            c = models.AchievementCategory(name=cat["name"], default_points=cat["default_points"])
            db.add(c)
            db.flush()
            cat_ids.append(c.id)
            
        common_pass = get_password_hash("Password@123")
        
        for inst in INSTITUTES:
            print(f"Seeding Institute: {inst['name']}")
            # Institute
            institute = models.Institute(
                institute_id=inst["code"],
                name=inst["name"],
                domain=inst["domain"],
                total_faculty=20,
                total_students=50
            )
            db.add(institute)
            db.flush()
            
            # Admin
            admin = models.User(
                email=f"admin@{inst['domain']}",
                hashed_password=common_pass,
                role="ADMIN",
                mobile_number=f"98765{random.randint(10000, 99999)}",
                institute_id=institute.id
            )
            db.add(admin)
            db.flush()
            
            # Departments
            dept_ids = []
            for d_name in DEPARTMENTS:
                dept = models.Department(name=d_name, institute_id=institute.id)
                db.add(dept)
                db.flush()
                dept_ids.append(dept.id)
                
            # Faculty & HODs (20 per institute)
            faculty_list = []
            for i in range(20):
                role = "HOD" if i < 10 else "FACULTY"
                dept_id = dept_ids[i % 10]
                gender = "Male" if random.random() > 0.5 else "Female"
                profile_pic = random.choice(MALE_FACES if gender == "Male" else FEMALE_FACES)
                
                fac = models.User(
                    email=f"faculty{i+1}@{inst['domain']}",
                    hashed_password=common_pass,
                    role=role,
                    name=f"{role} Name {i+1}",
                    profile_photo_url=profile_pic,
                    mobile_number=f"88888{random.randint(10000, 99999)}",
                    institute_id=institute.id,
                    department_id=dept_id
                )
                db.add(fac)
                db.flush()
                faculty_list.append(fac)
                
                prof = models.FacultyProfile(
                    user_id=fac.id,
                    employee_id=f"EMP_{inst['code']}_{i+1}_{uuid.uuid4().hex[:4]}",
                    department_id=dept_id
                )
                db.add(prof)
                
            # Students (50 per institute)
            for i in range(50):
                dept_id = dept_ids[i % 10]
                gender = "Male" if random.random() > 0.5 else "Female"
                profile_pic = random.choice(MALE_FACES if gender == "Male" else FEMALE_FACES)
                
                stu = models.User(
                    email=f"student{i+1}@{inst['domain']}",
                    hashed_password=common_pass,
                    role="STUDENT",
                    name=f"Student {inst['code']} {i+1}",
                    profile_photo_url=profile_pic,
                    mobile_number=f"99999{random.randint(10000, 99999)}",
                    institute_id=institute.id,
                    department_id=dept_id
                )
                db.add(stu)
                db.flush()
                
                # Assign Mentor
                mentor = random.choice(faculty_list)
                mr = models.MentorAssignment(
                    faculty_id=mentor.id,
                    department_id=dept_id,
                    batch_year=2025
                )
                db.add(mr)
                
                # Student Profile
                s_prof = models.StudentProfile(
                    user_id=stu.id,
                    enrollment_number=f"{inst['code']}{2025000+i}",
                    department_id=dept_id,
                    batch_year=2025,
                    gender=gender,
                    profile_status="APPROVED" if random.random() > 0.2 else "PENDING"
                )
                db.add(s_prof)
                db.flush()
                
                # Mock achievements
                for _ in range(random.randint(1, 4)):
                    ach = models.Achievement(
                        student_id=stu.id,
                        category_id=random.choice(cat_ids),
                        title=f"Sample Achievement {random.randint(1, 100)}",
                        organization_name="Tech Corp",
                        start_date=datetime.utcnow(),
                        end_date=datetime.utcnow(),
                        status="APPROVED",
                        points_awarded=random.choice([10, 30, 40, 50]),
                        duplicate_status="UNIQUE"
                    )
                    db.add(ach)

                # Mock CGPA
                db.add(m4.CGPARecord(
                    student_id=stu.id,
                    cgpa=round(random.uniform(7.0, 9.8), 2),
                    total_credits_earned=random.randint(40, 120)
                ))

        db.commit()
        print("Successfully seeded 3 Institutes, 30 Departments, 60 Faculties, and 150 Students.")
        
    except Exception as e:
        db.rollback()
        print(f"Error seeding database: {e}")
    finally:
        db.close()

if __name__ == "__main__":
    seed_database()
