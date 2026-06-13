import os
import shutil
import uuid
from fastapi import APIRouter, UploadFile, File, HTTPException

router = APIRouter()

UPLOAD_DIR = "uploads"
os.makedirs(UPLOAD_DIR, exist_ok=True)
ALLOWED_EXTENSIONS = {"png", "jpg", "jpeg"}

def get_file_extension(filename: str):
    return filename.split(".")[-1].lower() if "." in filename else ""

@router.post("")
async def upload_file(file: UploadFile = File(...)):
    ext = get_file_extension(file.filename)
    if ext not in ALLOWED_EXTENSIONS:
        raise HTTPException(status_code=400, detail="Only PNG, JPG, and JPEG files are allowed.")
    
    file_id = str(uuid.uuid4())
    new_filename = f"{file_id}.{ext}"
    file_path = os.path.join(UPLOAD_DIR, new_filename)
    
    with open(file_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)
        
    return {"url": f"/uploads/{new_filename}"}
