import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import api from '../api/axios';
import AdminDashboard from './AdminDashboard';
import FacultyDashboard from './FacultyDashboard';
import StudentDashboard from './StudentDashboard';

export default function Dashboard() {
  const [role, setRole] = useState('');
  const [instituteId, setInstituteId] = useState('');
  const [departments, setDepartments] = useState([]);
  const navigate = useNavigate();

  useEffect(() => {
    const token = localStorage.getItem('token');
    const userRole = localStorage.getItem('role');
    if (!token) {
      navigate('/login');
      return;
    }
    setRole(userRole);
    try {
      const payload = JSON.parse(atob(token.split('.')[1]));
      if (payload.institute_id) {
        setInstituteId(payload.institute_id);
        if (userRole === 'ADMIN') fetchDepartments(payload.institute_id);
      }
    } catch (e) {}
  }, [navigate]);

  const fetchDepartments = async (instId) => {
    try {
      const res = await api.get(`/institutes/${instId}/departments`);
      setDepartments(res.data);
    } catch (err) {}
  };

  const logout = () => {
    localStorage.removeItem('token');
    localStorage.removeItem('role');
    navigate('/login');
  };

  return (
    <div className="min-h-screen bg-gray-50 bg-[url('https://www.transparenttextures.com/patterns/cubes.png')]">
      <nav className="bg-white/90 backdrop-blur shadow sticky top-0 z-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16 items-center">
            <h1 className="text-2xl font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-purple-600">
              StudentSphere
            </h1>
            <div className="flex items-center gap-4">
              <span className="bg-gray-100 text-gray-800 px-3 py-1 rounded-full text-xs font-bold uppercase tracking-wide border border-gray-200">
                {role}
              </span>
              <button onClick={logout} className="text-sm font-medium text-red-500 hover:text-red-700 hover:bg-red-50 px-3 py-1 rounded transition">
                Logout
              </button>
            </div>
          </div>
        </div>
      </nav>

      <main className="p-8 max-w-7xl mx-auto">
        {role === 'ADMIN' && <AdminDashboard instituteId={instituteId} departments={departments} fetchDepartments={fetchDepartments} />}
        {role === 'FACULTY' && <FacultyDashboard />}
        {role === 'HOD' && <FacultyDashboard />}
        {role === 'STUDENT' && <StudentDashboard />}
      </main>
    </div>
  );
}
