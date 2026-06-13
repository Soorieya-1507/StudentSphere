from sqlalchemy import text
from app.db.database import Base, engine
from app.db.models import *

with engine.connect() as conn:
    print("Dropping schema public cascade...")
    conn.execute(text("DROP SCHEMA public CASCADE;"))
    conn.execute(text("CREATE SCHEMA public;"))
    conn.execute(text("GRANT ALL ON SCHEMA public TO postgres;"))
    conn.execute(text("GRANT ALL ON SCHEMA public TO public;"))
    conn.commit()

print("Creating all tables...")
Base.metadata.create_all(bind=engine)
print("Database reset successfully.")
