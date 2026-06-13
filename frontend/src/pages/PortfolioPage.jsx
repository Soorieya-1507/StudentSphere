import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import axios from 'axios';
import { QRCodeSVG } from 'qrcode.react';
import { toast } from 'react-toastify';

export default function PortfolioPage() {
  const { studentId } = useParams();
  const [portfolio, setPortfolio] = useState(null);

  useEffect(() => {
    const fetchPortfolio = async () => {
      try {
        const token = localStorage.getItem('token');
        const res = await axios.get(`http://localhost:8000/api/v1/portfolio/${studentId}`, {
          headers: { Authorization: `Bearer ${token}` }
        });
        setPortfolio(res.data);
      } catch (err) {
        toast.error("Failed to load portfolio");
      }
    };
    fetchPortfolio();
  }, [studentId]);

  if (!portfolio) return <div className="p-8 text-center text-gray-500">Generating AI Portfolio...</div>;

  return (
    <div className="min-h-screen bg-gray-50 py-12 px-4 font-sans">
      <div className="max-w-4xl mx-auto bg-white shadow-xl rounded-2xl overflow-hidden border border-gray-100">
        
        {/* Header */}
        <div className="bg-gradient-to-r from-gray-900 to-indigo-900 text-white p-12 text-center relative">
          <h1 className="text-5xl font-extrabold mb-4">{portfolio.name}</h1>
          <p className="text-xl text-indigo-200">Software Engineering Student | Batch 2025</p>
          
          <div className="absolute top-8 right-8 bg-white p-2 rounded-lg shadow-lg">
             <QRCodeSVG value={`http://localhost:3000${portfolio.public_url}`} size={80} />
             <p className="text-gray-900 text-[10px] text-center mt-1 font-bold">Scan to Verify</p>
          </div>
        </div>

        {/* Content */}
        <div className="p-12 space-y-12">
          
          {/* Summary / Stats */}
          <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
            <div className="bg-indigo-50 p-4 rounded-xl text-center border border-indigo-100">
              <span className="block text-indigo-500 text-sm font-bold uppercase">CGPA</span>
              <span className="block text-2xl font-black text-indigo-900">{portfolio.cgpa.toFixed(2)}</span>
            </div>
            <div className="bg-green-50 p-4 rounded-xl text-center border border-green-100">
              <span className="block text-green-600 text-sm font-bold uppercase">Skills</span>
              <span className="block text-2xl font-black text-green-900">{portfolio.skills.length}</span>
            </div>
            <div className="bg-blue-50 p-4 rounded-xl text-center border border-blue-100">
              <span className="block text-blue-500 text-sm font-bold uppercase">Projects</span>
              <span className="block text-2xl font-black text-blue-900">3</span>
            </div>
            <div className="bg-purple-50 p-4 rounded-xl text-center border border-purple-100">
              <span className="block text-purple-500 text-sm font-bold uppercase">Verified</span>
              <span className="block text-2xl font-black text-purple-900">{portfolio.achievements.length}</span>
            </div>
          </div>

          {/* Skills */}
          <div>
            <h3 className="text-2xl font-bold text-gray-800 border-b pb-2 mb-6">Technical Skills</h3>
            <div className="flex flex-wrap gap-3">
              {portfolio.skills.map((skill, i) => (
                <span key={i} className="px-4 py-2 bg-gray-100 text-gray-700 rounded-full font-medium shadow-sm border border-gray-200">
                  {skill}
                </span>
              ))}
            </div>
          </div>

          {/* Achievements */}
          <div>
            <h3 className="text-2xl font-bold text-gray-800 border-b pb-2 mb-6">Verified Achievements & Projects</h3>
            <div className="space-y-6">
              {portfolio.achievements.map((ach, i) => (
                <div key={i} className="flex items-start gap-4">
                  <div className="w-3 h-3 bg-indigo-500 rounded-full mt-2"></div>
                  <div>
                    <h4 className="text-lg font-bold text-gray-900">{ach.title}</h4>
                    <p className="text-gray-500">{ach.organization} • {new Date(ach.date).toLocaleDateString()}</p>
                  </div>
                </div>
              ))}
              {portfolio.achievements.length === 0 && (
                <p className="text-gray-500">No verified achievements found.</p>
              )}
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
