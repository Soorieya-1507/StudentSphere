from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.db.database import get_db
from app.db.models import User, MentorAssignment, StudentProfile, FacultyProfile
from app.schemas.schemas import MentorAssignmentCreate
from app.api.deps import get_current_user

router = APIRouter()

@router.post("/assign")
def assign_mentor(data: MentorAssignmentCreate, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if current_user.role != "ADMIN":
        raise HTTPException(status_code=403, detail="Only Admin can assign mentors")
        
    assignment = MentorAssignment(
        faculty_id=data.faculty_id,
        department_id=data.department_id,
        batch_year=data.batch_year
    )
    db.add(assignment)
    db.commit()
    
    # Auto link students (if any) to the assigned mentor
    students = db.query(StudentProfile).filter(
        StudentProfile.department_id == data.department_id,
        StudentProfile.batch_year == data.batch_year
    ).all()
    linked_count = 0
    for student in students:
        student.mentor_id = data.faculty_id
        linked_count += 1
    db.commit()
    return {"message": "Mentor assigned successfully",
            "students_linked": linked_count}
    
@router.get("/faculty")
def get_faculty_list(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if current_user.role != "ADMIN":
        raise HTTPException(status_code=403, detail="Not authorized")
    faculty = db.query(User).filter(User.role.in_(["FACULTY", "HOD"]), User.institute_id == current_user.institute_id).all()
    return [{"id": f.id, "email": f.email, "department_id": f.department_id} for f in faculty]
