import uuid
from typing import List
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.db.database import get_db
from app.db.models import User
from app.api.deps import get_current_user
from app.schemas.schemas import NotificationResponse
from app.services.notification_service import get_user_notifications, mark_notification_read

router = APIRouter()

@router.get("/", response_model=List[NotificationResponse])
def get_my_notifications(unread_only: bool = False, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return get_user_notifications(db, current_user.id, unread_only)

@router.post("/{notification_id}/read")
def read_notification(notification_id: uuid.UUID, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    mark_notification_read(db, str(notification_id))
    return {"message": "Notification marked as read"}
