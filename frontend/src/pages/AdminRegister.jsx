import React, { useState } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import api from '../api/axios';

export default function AdminRegister() {
  const [formData, setFormData] = useState({
    institute_name: '', email: '', mobile_number: '', password: '', domain: '', total_faculty: 0, total_students: 0
  });
  const [error, setError] = useState('');
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await api.post('/auth/register/admin', formData);
      alert('Registration successful! Please login.');
      navigate('/login');
    } catch (err) {
      if (err.response?.data?.detail && Array.isArray(err.response.data.detail)) {
         setError(err.response.data.detail[0].msg);
      } else {
         setError(err.response?.data?.detail || 'Registration failed');
      }
    }
  };

  const handleChange = (e) => {
    const value = e.target.type === 'number' ? parseInt(e.target.value, 10) || 0 : e.target.value;
    setFormData({...formData, [e.target.name]: value});
  };

  return (
    <div className="flex items-center justify-center min-h-screen bg-gray-100 py-10">
      <div className="bg-white p-8 rounded-lg shadow-lg w-full max-w-md">
        <h2 className="text-2xl font-bold mb-6 text-center text-indigo-600">Admin Registration</h2>
        {error && <p className="text-red-500 mb-4 text-sm text-center">{error}</p>}
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium mb-1">Institute Name</label>
            <input name="institute_name" required className="w-full border rounded p-2 focus:outline-indigo-500" onChange={handleChange} />
          </div>
          <div>
            <label className="block text-sm font-medium mb-1">Institute Domain (e.g., karpagamtech.ac.in)</label>
            <input name="domain" required className="w-full border rounded p-2 focus:outline-indigo-500" onChange={handleChange} />
          </div>
          <div className="flex gap-4">
            <div className="flex-1">
              <label className="block text-sm font-medium mb-1">Total Faculty</label>
              <input type="number" name="total_faculty" min="0" required className="w-full border rounded p-2 focus:outline-indigo-500" onChange={handleChange} />
            </div>
            <div className="flex-1">
              <label className="block text-sm font-medium mb-1">Total Students</label>
              <input type="number" name="total_students" min="0" required className="w-full border rounded p-2 focus:outline-indigo-500" onChange={handleChange} />
            </div>
          </div>
          <div>
            <label className="block text-sm font-medium mb-1">Admin Email (.edu or .ac)</label>
            <input type="email" name="email" required className="w-full border rounded p-2 focus:outline-indigo-500" onChange={handleChange} />
          </div>
          <div>
            <label className="block text-sm font-medium mb-1">Mobile Number (10 digits)</label>
            <input name="mobile_number" required className="w-full border rounded p-2 focus:outline-indigo-500" onChange={handleChange} />
          </div>
          <div>
            <label className="block text-sm font-medium mb-1">Password</label>
            <input type="password" name="password" required className="w-full border rounded p-2 focus:outline-indigo-500" onChange={handleChange} />
            <p className="text-xs text-gray-500 mt-1">Min 6 chars, uppercase, lowercase, number, special char</p>
          </div>
          <button type="submit" className="w-full bg-indigo-600 text-white p-2 rounded hover:bg-indigo-700 transition">
            Register as Admin
          </button>
        </form>
        <div className="mt-4 text-sm text-center">
          <Link to="/login" className="text-indigo-500 hover:underline">Back to Login</Link>
        </div>
      </div>
    </div>
  );
}
