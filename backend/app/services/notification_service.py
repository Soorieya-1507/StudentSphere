from sqlalchemy.orm import Session
from app.db.models import Notification

def create_notification(db: Session, user_id, title: str, message: str):
    notification = Notification(
        user_id=user_id,
        title=title,
        message=message
    )
    db.add(notification)
    db.commit()
    db.refresh(notification)
    return notification

def get_user_notifications(db: Session, user_id, unread_only: bool = False):
    query = db.query(Notification).filter(Notification.user_id == user_id)
    if unread_only:
        query = query.filter(Notification.is_read == False)
    return query.order_by(Notification.created_at.desc()).all()

def mark_notification_read(db: Session, notification_id):
    import uuid
    if isinstance(notification_id, str):
        notification_id = uuid.UUID(notification_id)
    notification = db.query(Notification).filter(Notification.id == notification_id).first()
    if notification:
        notification.is_read = True
        db.commit()
    return notification
