import React, { useState, useEffect } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import api from '../api/axios';

export default function StudentRegister() {
  const [formData, setFormData] = useState({
    institute_id: '', department_id: '', email: '', mobile_number: '', password: ''
  });
  const [institutes, setInstitutes] = useState([]);
  const [departments, setDepartments] = useState([]);
  const [error, setError] = useState('');
  const navigate = useNavigate();

  useEffect(() => {
    api.get('/institutes').then(res => setInstitutes(res.data)).catch(console.error);
  }, []);

  const handleInstituteChange = async (e) => {
    const instId = e.target.value;
    setFormData({ ...formData, institute_id: instId, department_id: '' });
    if (instId) {
      try {
        const res = await api.get(`/institutes/${instId}/departments`);
        setDepartments(res.data);
      } catch (err) {
        console.error(err);
      }
    } else {
      setDepartments([]);
    }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await api.post('/auth/register/student', formData);
      alert('Student Registration successful! Please login.');
      navigate('/login');
    } catch (err) {
      if (err.response?.data?.detail && Array.isArray(err.response.data.detail)) {
         setError(err.response.data.detail[0].msg);
      } else {
         setError(err.response?.data?.detail || 'Registration failed');
      }
    }
  };

  const handleChange = (e) => setFormData({...formData, [e.target.name]: e.target.value});

  return (
    <div className="flex items-center justify-center min-h-screen bg-gray-100 py-10">
      <div className="bg-white p-8 rounded-lg shadow-lg w-full max-w-md">
        <h2 className="text-2xl font-bold mb-6 text-center text-orange-600">Student Registration</h2>
        {error && <p className="text-red-500 mb-4 text-sm text-center">{error}</p>}
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium mb-1">Select Institute</label>
            <select name="institute_id" required className="w-full border rounded p-2 focus:outline-orange-500" onChange={handleInstituteChange}>
              <option value="">-- Select Institute --</option>
              {institutes.map(inst => (
                <option key={inst.id} value={inst.id}>{inst.name} ({inst.institute_id})</option>
              ))}
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium mb-1">Select Department</label>
            <select name="department_id" required className="w-full border rounded p-2 focus:outline-orange-500" onChange={handleChange} value={formData.department_id} disabled={!formData.institute_id}>
              <option value="">-- Select Department --</option>
              {departments.map(dept => (
                <option key={dept.id} value={dept.id}>{dept.name}</option>
              ))}
            </select>
            {formData.institute_id && departments.length === 0 && (
              <p className="text-xs text-red-500 mt-1">No departments found. Did you select the correct institute?</p>
            )}
          </div>
          <div>
            <label className="block text-sm font-medium mb-1">Email</label>
            <input type="email" name="email" required className="w-full border rounded p-2 focus:outline-orange-500" onChange={handleChange} />
          </div>
          <div>
            <label className="block text-sm font-medium mb-1">Mobile Number (10 digits)</label>
            <input name="mobile_number" required className="w-full border rounded p-2 focus:outline-orange-500" onChange={handleChange} />
          </div>
          <div>
            <label className="block text-sm font-medium mb-1">Password</label>
            <input type="password" name="password" required className="w-full border rounded p-2 focus:outline-orange-500" onChange={handleChange} />
            <p className="text-xs text-gray-500 mt-1">Min 6 chars, uppercase, lowercase, number, special char</p>
          </div>
          <button type="submit" className="w-full bg-orange-600 text-white p-2 rounded hover:bg-orange-700 transition">
            Register as Student
          </button>
        </form>
        <div className="mt-4 text-sm text-center">
          <Link to="/login" className="text-orange-500 hover:underline">Back to Login</Link>
        </div>
      </div>
    </div>
  );
}
