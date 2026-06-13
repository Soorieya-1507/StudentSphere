import React, { useState, useEffect } from 'react';
import api from '../api/axios';
import StudentProfileForm from '../components/StudentProfileForm';
import AchievementUpload from '../components/AchievementUpload';
import AchievementTimeline from '../components/AchievementTimeline';
import QRCodeDisplay from '../components/QRCodeDisplay';

export default function StudentDashboard() {
  const [metrics, setMetrics] = useState({ completion_percentage: 0, uploaded_documents_count: 0, approval_status: 'NOT_STARTED', rejection_reason: null, public_profile_id: null });
  const [achievements, setAchievements] = useState([]);
  const [activeTab, setActiveTab] = useState('overview');

  useEffect(() => {
    fetchMetrics();
    fetchAchievements();
  }, []);

  const fetchMetrics = async () => {
    try {
      const res = await api.get('/dashboards/student');
      setMetrics(res.data);
    } catch (err) {}
  };

  const fetchAchievements = async () => {
    try {
      const res = await api.get('/achievements/');
      setAchievements(res.data);
    } catch (err) {}
  };

  if (activeTab === 'profile') {
    return (
      <div>
        <button onClick={() => { setActiveTab('overview'); fetchMetrics(); }} className="mb-4 text-blue-600 hover:underline flex items-center font-medium">
          ← Back to Dashboard
        </button>
        <StudentProfileForm />
      </div>
    );
  }

  const statusColors = {
    'NOT_STARTED': 'bg-gray-100 text-gray-800',
    'PENDING': 'bg-yellow-100 text-yellow-800',
    'APPROVED': 'bg-green-100 text-green-800',
    'REJECTED': 'bg-red-100 text-red-800'
  };

  const totalPoints = achievements.filter(a => a.status === 'APPROVED').reduce((sum, a) => sum + a.points_awarded, 0);

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center border-b pb-4">
        <h2 className="text-2xl font-bold text-gray-800">Student Dashboard</h2>
        <div className="space-x-4">
            <button onClick={() => setActiveTab('overview')} className={`px-4 py-2 font-medium rounded ${activeTab === 'overview' ? 'bg-indigo-600 text-white' : 'text-gray-600 hover:bg-gray-100'}`}>Overview</button>
            <button onClick={() => setActiveTab('achievements')} className={`px-4 py-2 font-medium rounded ${activeTab === 'achievements' ? 'bg-indigo-600 text-white' : 'text-gray-600 hover:bg-gray-100'}`}>Achievements</button>
            <button onClick={() => setActiveTab('profile')} className="px-4 py-2 bg-gradient-to-r from-blue-500 to-cyan-600 text-white rounded shadow hover:opacity-90 transition font-medium">Edit Profile</button>
        </div>
      </div>

      {metrics.approval_status === 'REJECTED' && (
        <div className="bg-red-50 border-l-4 border-red-500 p-4 rounded-r shadow-sm">
          <h3 className="text-red-800 font-bold">Profile Rejected</h3>
          <p className="text-red-600 text-sm mt-1">Reason: {metrics.rejection_reason}</p>
          <p className="text-red-500 text-xs mt-2">Please update your profile and resubmit.</p>
        </div>
      )}

      {activeTab === 'overview' && (
        <>
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6">
          <div className="bg-white/80 backdrop-blur-sm rounded-xl shadow-lg p-6 relative overflow-hidden">
            <div className="relative z-10">
              <h3 className="text-gray-500 font-medium text-sm uppercase tracking-wide">Profile Completion</h3>
              <p className="text-4xl font-bold text-gray-800 mt-2">{metrics.completion_percentage}%</p>
            </div>
            <div className="absolute bottom-0 left-0 h-2 bg-blue-500 transition-all duration-1000" style={{ width: `${metrics.completion_percentage}%` }}></div>
          </div>

          <div className="bg-white/80 backdrop-blur-sm rounded-xl shadow-lg p-6">
            <h3 className="text-gray-500 font-medium text-sm uppercase tracking-wide">Documents Uploaded</h3>
            <p className="text-4xl font-bold text-gray-800 mt-2">{metrics.uploaded_documents_count} <span className="text-lg text-gray-400 font-normal">/ 5</span></p>
          </div>

          <div className="bg-white/80 backdrop-blur-sm rounded-xl shadow-lg p-6">
            <h3 className="text-gray-500 font-medium text-sm uppercase tracking-wide mb-2">Approval Status</h3>
            <span className={`px-4 py-2 rounded-full text-sm font-bold uppercase tracking-wider inline-block ${statusColors[metrics.approval_status] || 'bg-gray-100 text-gray-800'}`}>
              {metrics.approval_status ? metrics.approval_status.replace('_', ' ') : 'NOT STARTED'}
            </span>
          </div>

          <div className="bg-indigo-50 border border-indigo-100 rounded-xl shadow-lg p-6">
            <h3 className="text-indigo-600 font-medium text-sm uppercase tracking-wide mb-2">Total Points</h3>
            <p className="text-4xl font-bold text-indigo-900">{totalPoints} <span className="text-lg text-indigo-400 font-normal">pts</span></p>
          </div>
        </div>
        
        <div className="mt-8 grid grid-cols-1 lg:grid-cols-3 gap-6">
            <div className="lg:col-span-2 bg-white rounded-xl shadow-lg p-6">
                <h3 className="text-xl font-bold text-gray-800 mb-6 border-b pb-2">Achievement Timeline</h3>
                <AchievementTimeline achievements={achievements} />
            </div>
            <div className="lg:col-span-1">
                {/* Note: In a real app we'd pass the actual public profile ID here when generated by backend profile update */}
                {metrics.approval_status === 'APPROVED' ? (
                  <QRCodeDisplay publicId={metrics.public_profile_id || "demo-id-123"} />
                ) : (
                  <div className="bg-gray-50 border p-6 rounded-lg text-center">
                    <p className="text-gray-500">Your profile must be approved by faculty to generate your Achievement Passport QR code.</p>
                  </div>
                )}
            </div>
        </div>
        </>
      )}

      {activeTab === 'achievements' && (
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <AchievementUpload onSuccess={fetchAchievements} />
            
            <div className="bg-white p-6 rounded-lg shadow-md border border-gray-200 h-[600px] overflow-y-auto">
                <h3 className="text-xl font-semibold mb-4 text-gray-800 sticky top-0 bg-white pb-2 border-b">My Submissions</h3>
                {achievements.length === 0 ? <p className="text-gray-500">No achievements submitted yet.</p> : (
                    <div className="space-y-4">
                        {achievements.map(a => (
                            <div key={a.id} className="border rounded p-4 flex justify-between items-center hover:bg-gray-50 transition">
                                <div>
                                    <h4 className="font-medium text-gray-900">{a.title}</h4>
                                    <p className="text-sm text-gray-500">{a.organization_name} • {new Date(a.created_at).toLocaleDateString()}</p>
                                </div>
                                <div className="text-right">
                                    <span className={`px-2 py-1 text-xs rounded-full font-semibold ${a.status === 'APPROVED' ? 'bg-green-100 text-green-800' : a.status === 'REJECTED' ? 'bg-red-100 text-red-800' : 'bg-yellow-100 text-yellow-800'}`}>
                                        {a.status}
                                    </span>
                                    {a.status === 'APPROVED' && <p className="text-xs text-indigo-600 font-bold mt-1">+{a.points_awarded} pts</p>}
                                </div>
                            </div>
                        ))}
                    </div>
                )}
            </div>
        </div>
      )}
    </div>
  );
}
