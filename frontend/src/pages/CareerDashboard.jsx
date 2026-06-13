import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { toast } from 'react-toastify';
import { useNavigate } from 'react-router-dom';

const CareerDashboard = () => {
  const [digitalTwin, setDigitalTwin] = useState(null);
  const [portfolioData, setPortfolioData] = useState(null);
  const navigate = useNavigate();

  useEffect(() => {
    const fetchData = async () => {
      try {
        const token = localStorage.getItem('token');
        const studentId = localStorage.getItem('user_id');
        if (!token || !studentId) {
          navigate('/login');
          return;
        }

        const config = { headers: { Authorization: `Bearer ${token}` } };
        
        // Fetch Digital Twin
        const twinRes = await axios.get(`http://localhost:8000/api/v1/career/digital-twin/${studentId}`, config);
        setDigitalTwin(twinRes.data);

        // Fetch Portfolio
        const portRes = await axios.get(`http://localhost:8000/api/v1/portfolio/${studentId}`, config);
        setPortfolioData(portRes.data);

      } catch (err) {
        toast.error('Failed to load career data');
      }
    };
    fetchData();
  }, [navigate]);

  if (!digitalTwin || !portfolioData) return <div className="p-8 text-center text-gray-500">Loading Career Intelligence Engine...</div>;

  return (
    <div className="p-8 max-w-7xl mx-auto space-y-8">
      <h1 className="text-3xl font-bold text-gray-800">Student Success Digital Twin</h1>
      
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        {/* CRS Card */}
        <div className="bg-white p-6 rounded-lg shadow-sm border-l-4 border-indigo-500">
          <h3 className="text-gray-500 text-sm font-semibold uppercase tracking-wider mb-2">Career Readiness Score</h3>
          <div className="flex items-end gap-2">
            <span className="text-4xl font-bold text-indigo-600">{digitalTwin.career.crs}</span>
            <span className="text-gray-400 mb-1">/ 100</span>
          </div>
          <p className="mt-4 text-sm text-gray-600 font-medium">Category: <span className="text-indigo-800">{digitalTwin.category}</span></p>
        </div>

        {/* SSI Card */}
        <div className="bg-white p-6 rounded-lg shadow-sm border-l-4 border-green-500">
          <h3 className="text-gray-500 text-sm font-semibold uppercase tracking-wider mb-2">Master Success Index</h3>
          <div className="flex items-end gap-2">
            <span className="text-4xl font-bold text-green-600">{digitalTwin.ssi}</span>
            <span className="text-gray-400 mb-1">/ 100</span>
          </div>
          <p className="mt-4 text-sm text-gray-600 font-medium">Based on Academic + Skills + Projects</p>
        </div>

        {/* Academic Snapshot */}
        <div className="bg-white p-6 rounded-lg shadow-sm border-l-4 border-blue-500">
          <h3 className="text-gray-500 text-sm font-semibold uppercase tracking-wider mb-2">Academic Core</h3>
          <div className="space-y-2 mt-4">
            <div className="flex justify-between">
              <span className="text-gray-600">CGPA</span>
              <span className="font-bold">{digitalTwin.academic.cgpa}</span>
            </div>
            <div className="flex justify-between">
              <span className="text-gray-600">Attendance</span>
              <span className="font-bold">{digitalTwin.academic.attendance}%</span>
            </div>
            <div className="flex justify-between">
              <span className="text-gray-600">Active Arrears</span>
              <span className="font-bold text-red-500">{digitalTwin.academic.arrears}</span>
            </div>
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
        {/* Portfolio Link */}
        <div className="bg-gradient-to-r from-indigo-900 to-purple-900 text-white p-8 rounded-lg shadow-lg">
          <h2 className="text-2xl font-bold mb-2">Your Public Portfolio is Live</h2>
          <p className="text-indigo-200 mb-6">Recruiters can view your verified skills, projects, and achievements via this link.</p>
          
          <div className="bg-white/10 p-4 rounded-md mb-6 break-all font-mono text-sm">
            http://localhost:3000{portfolioData.public_url}
          </div>

          <button 
            onClick={() => {
              window.open(portfolioData.public_url, '_blank');
              toast.success('Opening public passport');
            }}
            className="bg-white text-indigo-900 px-6 py-2 rounded font-bold hover:bg-gray-100 transition"
          >
            View Public Passport
          </button>
        </div>

        {/* Smart Recommendations */}
        <div className="bg-white p-6 rounded-lg shadow-sm border border-gray-100">
          <h2 className="text-xl font-bold text-gray-800 mb-4">AI Learning Roadmap</h2>
          <ul className="space-y-4">
            <li className="flex items-start gap-4 p-4 bg-yellow-50 rounded-md border border-yellow-100">
              <div className="bg-yellow-500 text-white p-2 rounded-full mt-1">✓</div>
              <div>
                <h4 className="font-bold text-yellow-900">Complete React Certification</h4>
                <p className="text-sm text-yellow-800">Based on your target role: Frontend Engineer</p>
              </div>
            </li>
            <li className="flex items-start gap-4 p-4 bg-gray-50 rounded-md border border-gray-100">
              <div className="bg-gray-300 text-white p-2 rounded-full mt-1">!</div>
              <div>
                <h4 className="font-bold text-gray-700">Improve Attendance</h4>
                <p className="text-sm text-gray-500">Your attendance is below 85% which negatively impacts PRI.</p>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
  );
};

export default CareerDashboard;
