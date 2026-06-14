from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
import uuid

from app.db.database import get_db
from app.db.models import User, Institute, Department
from app.schemas.schemas import (AdminRegister, FacultyRegister, StudentRegister, UserLogin,
                                 Token, DepartmentCreate, DepartmentResponse, InstituteResponse)
from app.core.security import get_password_hash, verify_password, create_access_token
from app.api.deps import get_current_user
from app.api.endpoints import dashboards, profiles, mentors, achievements, approvals, notifications, analytics, public, academic, attendance, results, risk, hod, intelligence, reports, recommendations, career, portfolio, recruiter, resume

router = APIRouter()

# Phase 2
router.include_router(dashboards.router, prefix="/dashboards", tags=["dashboards"])
router.include_router(profiles.router, prefix="/profiles", tags=["profiles"])
router.include_router(mentors.router, prefix="/mentors", tags=["mentors"])

# Phase 3
router.include_router(achievements.router, prefix="/achievements", tags=["achievements"])
router.include_router(approvals.router, prefix="/approvals", tags=["approvals"])
router.include_router(notifications.router, prefix="/notifications", tags=["notifications"])
router.include_router(analytics.router, prefix="/analytics", tags=["analytics"])
router.include_router(public.router, prefix="/public", tags=["public"])

# Phase 4
router.include_router(academic.router, prefix="/academic", tags=["academic"])
router.include_router(attendance.router, prefix="/attendance", tags=["attendance"])
router.include_router(results.router, prefix="/results", tags=["results"])
router.include_router(risk.router, prefix="/risk", tags=["risk"])
router.include_router(hod.router, prefix="/hod", tags=["hod"])

# Phase 5
router.include_router(intelligence.router, prefix="/intelligence", tags=["intelligence"])
router.include_router(reports.router, prefix="/reports", tags=["reports"])
router.include_router(recommendations.router, prefix="/recommendations", tags=["recommendations"])

# Phase 6
router.include_router(career.router, prefix="/career", tags=["career"])
router.include_router(portfolio.router, prefix="/portfolio", tags=["portfolio"])
router.include_router(recruiter.router, prefix="/recruiter", tags=["recruiter"])
router.include_router(resume.router, prefix="/resume", tags=["resume"])


@router.post("/auth/register/admin")
def register_admin(user_in: AdminRegister, db: Session = Depends(get_db)):
    db_user = db.query(User).filter(User.email == user_in.email).first()
    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered")
    
    # Create Institute with additional fields
    institute_id_str = str(uuid.uuid4())
    new_institute = Institute(
        institute_id=institute_id_str,
        name=user_in.institute_name,
        domain=user_in.domain,
        total_faculty=user_in.total_faculty,
        total_students=user_in.total_students,
    )
    db.add(new_institute)
    db.commit()
    db.refresh(new_institute)

    # Create Admin
    hashed_password = get_password_hash(user_in.password)
    new_admin = User(
        email=user_in.email,
        hashed_password=hashed_password,
        role="ADMIN",
        mobile_number=user_in.mobile_number,
        institute_id=new_institute.id
    )
    db.add(new_admin)
    db.commit()
    return {"message": "Admin and Institute registered successfully", "institute_id": new_institute.institute_id}

@router.post("/auth/register/faculty")
def register_faculty(user_in: FacultyRegister, db: Session = Depends(get_db)):
    institute = db.query(Institute).filter(Institute.id == user_in.institute_id).first()
    if not institute:
        raise HTTPException(status_code=404, detail="Institution not found")
        
    domain = user_in.email.split('@')[-1]
    if domain != institute.domain:
        raise HTTPException(status_code=400, detail=f"Email domain must be @{institute.domain}")
    
    db_user = db.query(User).filter(User.email == user_in.email).first()
    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered")
    
    hashed_password = get_password_hash(user_in.password)
    new_user = User(
        email=user_in.email,
        hashed_password=hashed_password,
        role="FACULTY", # Default to faculty, admin can change later
        mobile_number=user_in.mobile_number,
        institute_id=institute.id,
        department_id=user_in.department_id
    )
    db.add(new_user)
    db.commit()
    return {"message": "Faculty registered successfully"}

@router.post("/auth/register/student")
def register_student(user_in: StudentRegister, db: Session = Depends(get_db)):
    institute = db.query(Institute).filter(Institute.id == user_in.institute_id).first()
    if not institute:
        raise HTTPException(status_code=404, detail="Institution not found")
        
    domain = user_in.email.split('@')[-1]
    if domain != institute.domain:
        raise HTTPException(status_code=400, detail=f"Email domain must be @{institute.domain}")
        
    db_user = db.query(User).filter(User.email == user_in.email).first()
    if db_user:
        raise HTTPException(status_code=400, detail="Email already registered")
    
    hashed_password = get_password_hash(user_in.password)
    new_user = User(
        email=user_in.email,
        hashed_password=hashed_password,
        role="STUDENT",
        mobile_number=user_in.mobile_number,
        institute_id=institute.id,
        department_id=user_in.department_id
    )
    db.add(new_user)
    db.commit()
    return {"message": "Student registered successfully"}

@router.post("/auth/login", response_model=Token)
def login(user_in: UserLogin, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.email == user_in.email).first()
    if not user or not verify_password(user_in.password, user.hashed_password):
        raise HTTPException(status_code=400, detail="Incorrect email or password")
    
    access_token = create_access_token(data={"sub": user.email, "role": user.role, "id": str(user.id), "institute_id": str(user.institute_id)})
    return {"access_token": access_token, "token_type": "bearer", "role": user.role}

@router.get("/institutes", response_model=List[InstituteResponse])
def get_institutes(db: Session = Depends(get_db)):
    institutes = db.query(Institute).all()
    return institutes

@router.get("/institutes/{institute_id}/departments", response_model=List[DepartmentResponse])
def get_departments(institute_id: uuid.UUID, db: Session = Depends(get_db)):
    departments = db.query(Department).filter(Department.institute_id == institute_id).all()
    return departments

@router.post("/departments", response_model=DepartmentResponse)
def create_department(dept_in: DepartmentCreate, institute_id: uuid.UUID, db: Session = Depends(get_db)):
    new_dept = Department(name=dept_in.name, institute_id=institute_id)
    db.add(new_dept)
    db.commit()
    db.refresh(new_dept)
    return new_dept
