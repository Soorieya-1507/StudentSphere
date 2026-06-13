import bcrypt
if not hasattr(bcrypt, "__about__"):
    class About:
        __version__ = bcrypt.__version__
    bcrypt.__about__ = About()

import os
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from app.api.api import router
from app.api.endpoints.uploads import router as uploads_router
from app.api.endpoints.profiles import router as profiles_router
from app.api.endpoints.mentors import router as mentors_router
from app.api.endpoints.dashboards import router as dashboards_router
from app.db.database import Base, engine
from app.db import models, models_phase4, models_phase5

# Create tables in DB
Base.metadata.create_all(bind=engine)

app = FastAPI(title="StudentSphere API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

os.makedirs("uploads", exist_ok=True)
app.mount("/uploads", StaticFiles(directory="uploads"), name="uploads")

app.include_router(router, prefix="/api/v1")
app.include_router(uploads_router, prefix="/api/v1/uploads", tags=["uploads"])
app.include_router(profiles_router, prefix="/api/v1/profiles", tags=["profiles"])
app.include_router(mentors_router, prefix="/api/v1/mentors", tags=["mentors"])
app.include_router(dashboards_router, prefix="/api/v1/dashboards", tags=["dashboards"])
