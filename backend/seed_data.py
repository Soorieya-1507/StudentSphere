import sys
import os
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

import uuid
import random
from app.db.database import SessionLocal, engine
from app.db.models import Base, User, Institute, Department, StudentProfile, FacultyProfile
from app.core.security import get_password_hash
from sqlalchemy.orm import Session

def seed_data():
    db: Session = SessionLocal()
    from app.db.models import AchievementCategory
    
    # Categories configuration
    categories_data = [
        {"name": "Workshop", "points": 5, "priority": "LOW"},
        {"name": "Certificate", "points": 10, "priority": "LOW"},
        {"name": "Event Participation", "points": 10, "priority": "MEDIUM"},
        {"name": "Project", "points": 30, "priority": "MEDIUM"},
        {"name": "Internship", "points": 25, "priority": "HIGH"},
        {"name": "Research Paper", "points": 50, "priority": "HIGH"},
        {"name": "Hackathon Participation", "points": 40, "priority": "HIGH"},
        {"name": "Hackathon Winner", "points": 75, "priority": "HIGH"},
        {"name": "Sports Achievement", "points": 20, "priority": "MEDIUM"},
        {"name": "Cultural Achievement", "points": 20, "priority": "MEDIUM"}
    ]
    
    # Base configuration
    institutes_data = [
        {"name": "Karpagam Institute of Technology", "domain": "karpagamtech.ac.in", "code": "kit"},
        {"name": "SRM Institute of Science and Technology", "domain": "srmist.edu.in", "code": "srm"},
        {"name": "Rajalakshmi Engineering College", "domain": "rajalakshmi.edu.in", "code": "rec"},
        {"name": "PSG College of Technology", "domain": "psgtech.edu", "code": "psg"},
        {"name": "SSN College of Engineering", "domain": "ssn.edu.in", "code": "ssn"},
        {"name": "Vellore Institute of Technology", "domain": "vit.ac.in", "code": "vit"},
        {"name": "Anna University", "domain": "annauniv.edu", "code": "au"},
        {"name": "Madras Institute of Technology", "domain": "mitindia.edu", "code": "mit"}
    ]
    
    departments_list = ["Computer Science", "Information Technology", "Artificial Intelligence"]
    
    print("Starting database seeding...")
    
    # 0. Seed Categories
    for cat in categories_data:
        existing_cat = db.query(AchievementCategory).filter(AchievementCategory.name == cat["name"]).first()
        if not existing_cat:
            new_cat = AchievementCategory(name=cat["name"], default_points=cat["points"], priority=cat["priority"])
            db.add(new_cat)
    db.commit()
    print("Categories seeded successfully.")
    
    for inst_data in institutes_data:
        # 1. Create Institute
        inst_id_str = str(uuid.uuid4())
        institute = Institute(
            institute_id=inst_id_str,
            name=inst_data["name"],
            domain=inst_data["domain"],
            total_faculty=20,
            total_students=50
        )
        db.add(institute)
        db.commit()
        db.refresh(institute)
        print(f"\n--- Created Institute: {institute.name} ---")
        
        # 2. Create Departments
        depts = []
        for dept_name in departments_list:
            dept = Department(name=dept_name, institute_id=institute.id)
            db.add(dept)
            db.commit()
            db.refresh(dept)
            depts.append(dept)
        
        # 3. Create Admin
        admin_email = f"admin@{inst_data['domain']}"
        admin_pass = f"Admin@{inst_data['code'].upper()}2026!"
        admin_user = User(
            email=admin_email,
            hashed_password=get_password_hash(admin_pass),
            role="ADMIN",
            mobile_number=f"98765432{random.randint(10, 99)}",
            institute_id=institute.id
        )
        db.add(admin_user)
        db.commit()
        print(f"Admin created - Email: {admin_email} | Password: {admin_pass}")
        
        # 4. Create 20 Faculty
        faculty_users = []
        for i in range(1, 21):
            fac_email = f"faculty{i}@{inst_data['domain']}"
            fac_pass = f"Faculty{i}@{inst_data['code'].upper()}!"
            dept = random.choice(depts)
            
            fac_user = User(
                email=fac_email,
                hashed_password=get_password_hash(fac_pass),
                role="FACULTY",
                mobile_number=f"99887766{i:02d}",
                institute_id=institute.id,
                department_id=dept.id
            )
            db.add(fac_user)
            db.commit()
            db.refresh(fac_user)
            
            # Faculty Profile
            fac_profile = FacultyProfile(
                user_id=fac_user.id,
                employee_id=f"EMP{inst_data['code'].upper()}{i:03d}",
                department_id=dept.id
            )
            db.add(fac_profile)
            faculty_users.append(fac_user)
        db.commit()
        print(f"Created 20 Faculty members. Example - Email: faculty1@{inst_data['domain']} | Password: Faculty1@{inst_data['code'].upper()}!")
        
        # 5. Create 50 Students
        for i in range(1, 51):
            roll_no = f"24{inst_data['code']}{i:03d}"
            stu_email = f"{roll_no}@{inst_data['domain']}"
            stu_pass = f"Student{i}@{inst_data['code'].upper()}!"
            dept = random.choice(depts)
            
            stu_user = User(
                email=stu_email,
                hashed_password=get_password_hash(stu_pass),
                role="STUDENT",
                mobile_number=f"90000000{i:02d}",
                institute_id=institute.id,
                department_id=dept.id
            )
            db.add(stu_user)
            db.commit()
            db.refresh(stu_user)
            
            # Student Profile
            stu_profile = StudentProfile(
                user_id=stu_user.id,
                enrollment_number=f"ENR{inst_data['code'].upper()}{i:04d}",
                roll_number=roll_no,
                department_id=dept.id,
                batch_year=2024,
                mentor_id=random.choice(faculty_users).id
            )
            db.add(stu_profile)
        db.commit()
        print(f"Created 50 Students. Example - Email: 24{inst_data['code']}001@{inst_data['domain']} | Password: Student1@{inst_data['code'].upper()}!")

    db.close()
    print("\nSeeding completed successfully!")

if __name__ == "__main__":
    seed_data()
