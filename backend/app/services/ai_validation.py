import hashlib
from fastapi import UploadFile
from sqlalchemy.orm import Session
from app.db.models import Achievement

def generate_file_hash(content: bytes) -> str:
    return hashlib.md5(content).hexdigest()

def mock_ocr_extraction(filename: str):
    # In the future, this will connect to Tesseract/AWS Textract/Google Vision
    # For now, we mock the extraction structure.
    return {
        "student_name": "Extracted Name",
        "organization": "Mock Organization",
        "event_name": "Mock Event",
        "date": "2026-01-01"
    }

def detect_duplicates(db: Session, student_id: str, title: str, file_hash: str):
    # This is a basic mock. We don't store file hash in DB yet, but in a real scenario
    # we would compare hashes to find exact file matches.
    # We will search by similar title for the same student
    existing = db.query(Achievement).filter(
        Achievement.student_id == student_id,
        Achievement.title == title
    ).first()
    
    if existing:
        return "SUSPECTED", 85
    return "UNIQUE", 0
