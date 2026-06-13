import uuid
import random
import datetime
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

# Import models
from app.db.database import Base
from app.db import models
from app.db import models_phase4 as m4
from app.db import models as m3
from app.db import models_phase5 as m5
from app.core.security import get_password_hash

# Set up testing DB
SQLALCHEMY_DATABASE_URL = "sqlite:///./phase5_test.db"
engine = create_engine(SQLALCHEMY_DATABASE_URL, connect_args={"check_same_thread": False})
TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

def seed():
    Base.metadata.drop_all(bind=engine)
    Base.metadata.create_all(bind=engine)
    db = TestingSessionLocal()
    
    print("Seeding Institute...")
    inst = models.Institute(institute_id="ABC001", name="ABC Institute of Technology", domain="abc.edu")
    db.add(inst)
    db.commit()
    
    print("Seeding Departments...")
    dept_names = ["CSE", "IT", "ECE", "MECH", "CIVIL"]
    depts = {}
    for name in dept_names:
        d = models.Department(name=name, institute_id=inst.id)
        db.add(d)
        db.commit()
        db.refresh(d)
        depts[name] = d
        
    print("Seeding Faculty...")
    faculty_dist = {"CSE": 5, "IT": 4, "ECE": 4, "MECH": 4, "CIVIL": 3}
    faculty_list = []
    
    for dept_name, count in faculty_dist.items():
        dept_id = depts[dept_name].id
        for i in range(count):
            role = "HOD" if i == 0 else "FACULTY"
            f = models.User(
                email=f"{dept_name.lower()}_fac{i}@abc.edu",
                hashed_password=get_password_hash("Password123!"),
                role=role,
                mobile_number="9999999999",
                institute_id=inst.id,
                department_id=dept_id
            )
            db.add(f)
            db.commit()
            db.refresh(f)
            faculty_list.append(f)
            
            fp = models.FacultyProfile(
                user_id=f.id,
                employee_id=f"EMP{dept_name}{i}",
                department_id=dept_id
            )
            db.add(fp)
            
            if role == "HOD":
                depts[dept_name].hod_id = f.id
    db.commit()
    
    print("Seeding Students...")
    student_dist = {"CSE": 25, "IT": 20, "ECE": 20, "MECH": 20, "CIVIL": 15}
    students = []
    
    cat = models.AchievementCategory(name="Internship", default_points=50)
    cat2 = models.AchievementCategory(name="Hackathon", default_points=30)
    cat3 = models.AchievementCategory(name="Research Paper", default_points=100)
    db.add_all([cat, cat2, cat3])
    db.commit()
    
    for dept_name, count in student_dist.items():
        dept_id = depts[dept_name].id
        
        for i in range(count):
            s = models.User(
                email=f"{dept_name.lower()}_stu{i}@abc.edu",
                hashed_password=get_password_hash("Password123!"),
                role="STUDENT",
                mobile_number="8888888888",
                institute_id=inst.id,
                department_id=dept_id
            )
            db.add(s)
            db.commit()
            db.refresh(s)
            students.append(s)
            
            sp = models.StudentProfile(
                user_id=s.id,
                enrollment_number=f"ENR{dept_name}{i}",
                department_id=dept_id,
                batch_year=2024
            )
            db.add(sp)
            
            # Mix Profiles: High, Average, At-Risk
            rand = random.random()
            if rand > 0.8: # High Performer
                cgpa = random.uniform(8.5, 9.8)
                attendance = random.uniform(85, 100)
                arrears = 0
                ach_count = random.randint(2, 5)
            elif rand > 0.3: # Average
                cgpa = random.uniform(6.5, 8.4)
                attendance = random.uniform(75, 84)
                arrears = random.choice([0, 1])
                ach_count = random.randint(0, 2)
            else: # At-Risk
                cgpa = random.uniform(4.0, 6.4)
                attendance = random.uniform(50, 74)
                arrears = random.randint(1, 4)
                ach_count = 0
                
            # CGPA Record
            db.add(m4.CGPARecord(student_id=s.id, cgpa=cgpa, total_credits_earned=60))
            
            # Attendance Record
            db.add(m4.AttendanceRecord(student_id=s.id, subject_id=uuid.uuid4(), month="2024-08", total_classes=100, attended_classes=int(attendance), percentage=attendance))
            
            # Arrears
            for a in range(arrears):
                db.add(m4.ArrearRecord(student_id=s.id, subject_id=uuid.uuid4(), status="CURRENT"))
                
            # Achievements
            for a in range(ach_count):
                db.add(m3.Achievement(
                    student_id=s.id,
                    department_id=dept_id,
                    title=random.choice(["Software Engineering Intern", "SIH 2024 Finalist", "IEEE Paper Published"]),
                    points_awarded=50
                ))
    db.commit()
    print("Seed Complete!")
    db.close()

if __name__ == "__main__":
    seed()
