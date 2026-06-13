import os
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    PROJECT_NAME: str = "StudentSphere Phase 1"
    SECRET_KEY: str = os.getenv("SECRET_KEY", "this_is_a_super_secret_key_123")
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60
    DATABASE_URL: str = os.getenv("DATABASE_URL", "postgresql://postgres:postgres@localhost:5432/studentsphere")

    class Config:
        env_file = ".env"

settings = Settings()
