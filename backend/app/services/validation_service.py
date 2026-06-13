import os
from fastapi import UploadFile, HTTPException
from PIL import Image
import io

ALLOWED_EXTENSIONS = {"png", "jpg", "jpeg", "pdf"}
MAX_FILE_SIZE = 5 * 1024 * 1024 # 5 MB

def validate_file(file: UploadFile):
    # Check extension
    filename = file.filename
    ext = filename.split(".")[-1].lower() if "." in filename else ""
    if ext not in ALLOWED_EXTENSIONS:
        raise HTTPException(status_code=400, detail="Unsupported file format. Allowed: PNG, JPG, JPEG, PDF")
    
    # Read content
    content = file.file.read()
    if len(content) > MAX_FILE_SIZE:
        file.file.seek(0)
        raise HTTPException(status_code=400, detail="File size exceeds 5MB limit")
    
    # Image integrity validation
    if ext in {"png", "jpg", "jpeg"}:
        try:
            image = Image.open(io.BytesIO(content))
            image.verify() # Verify that it is, in fact, an image
        except Exception:
            file.file.seek(0)
            raise HTTPException(status_code=400, detail="Corrupted image file")
            
    # Reset cursor for future reads
    file.file.seek(0)
    return True
