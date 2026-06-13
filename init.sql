-- init.sql
-- Note: FastAPI's Base.metadata.create_all(bind=engine) will automatically create these tables.
-- But here is the raw SQL schema for reference.

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE institutes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    institute_id VARCHAR UNIQUE NOT NULL,
    name VARCHAR NOT NULL
);

CREATE TABLE departments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR NOT NULL,
    institute_id UUID NOT NULL REFERENCES institutes(id)
);

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR UNIQUE NOT NULL,
    hashed_password VARCHAR NOT NULL,
    role VARCHAR NOT NULL,
    mobile_number VARCHAR NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    institute_id UUID REFERENCES institutes(id),
    department_id UUID REFERENCES departments(id)
);
