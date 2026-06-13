# StudentSphere - Phase 1

This repository contains the complete working code for Phase 1 of the StudentSphere application.

## Prerequisites
- Node.js (v18+)
- Python 3.10+
- PostgreSQL

## 1. Database Setup
1. Ensure your PostgreSQL server is running.
2. Create a new database named `studentsphere`:
   ```sql
   CREATE DATABASE studentsphere;
   ```
   *(Note: Tables are created automatically when the FastAPI server starts)*

## 2. Backend Setup
1. Open a terminal and navigate to the backend directory:
   ```bash
   cd c:\StudentSphere\backend
   ```
2. Create and activate a Python virtual environment:
   ```bash
   python -m venv venv
   # On Windows:
   .\venv\Scripts\activate
   ```
3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
4. Configure environment variables:
   Inside the `c:\StudentSphere\backend` directory, create a new file named `.env` and copy the contents of `.env.example` into it, or set:
   ```
   DATABASE_URL=postgresql://postgres:postgres@localhost:5432/studentsphere
   SECRET_KEY=your_secret_key_here
   ```
5. Run the FastAPI server:
   ```bash
   uvicorn app.main:app --reload --port 8000
   ```
   *The API will be available at http://localhost:8000*
   *Swagger UI available at http://localhost:8000/docs*

## 3. Frontend Setup
1. Open a new terminal and navigate to the frontend directory:
   ```bash
   cd c:\StudentSphere\frontend
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Configure environment variables:
   Create a `.env.local` file in the frontend root and add:
   ```
   VITE_API_URL=http://localhost:8000/api/v1
   ```
4. Run the React development server:
   ```bash
   npm run dev
   ```
   *The frontend will be available at http://localhost:5173*

## 4. Usage Flow
1. **Admin Registration**: Go to `http://localhost:5173/register/admin`. Register an Admin account (email must end with `.edu` or `.ac`).
2. **Login**: Login with the Admin credentials.
3. **Add Departments**: In the Admin Dashboard, add new departments for your Institute.
4. **Faculty/Student Registration**: Go to the respective registration pages. Select the newly created Institute, then select a Department to complete the registration.
