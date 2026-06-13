import React, { useState, useEffect } from 'react';
import api from '../api/axios';
import PlacementReadinessView from '../components/PlacementReadinessView';
import FacultyProfileForm from '../components/FacultyProfileForm';

export default function FacultyDashboard() {
  const [metrics, setMetrics] = useState({ assigned_students: 0, pending_profiles: 0, approved_profiles: 0 });
  const [pendingStudents, setPendingStudents] = useState([]);
  const [approvalQueue, setApprovalQueue] = useState([]);
  const [mentorInsights, setMentorInsights] = useState({ top_performers: [], least_active: [] });
  const [activeTab, setActiveTab] = useState('overview'); // overview, profile, achievements, insights
  const [facultyProfile, setFacultyProfile] = useState(null);

  useEffect(() => {
    fetchMetrics();
    fetchPending();
    fetchApprovalQueue();
    fetchMentorInsights();
    fetchFacultyProfile();
  }, []);

  const fetchMetrics = async () => {
    try {
      const res = await api.get('/dashboards/faculty');
      setMetrics(res.data);
    } catch (err) {}
  };

  const fetchPending = async () => {
    try {
      const res = await api.get('/dashboards/faculty/pending-students');
      setPendingStudents(res.data);
    } catch (err) {}
  };

  const fetchApprovalQueue = async () => {
    try {
      const res = await api.get('/approvals/queue');
      setApprovalQueue(res.data);
    } catch (err) {}
  };

  const fetchMentorInsights = async () => {
    try {
      const res = await api.get('/analytics/mentor-insights');
      setMentorInsights(res.data);
    } catch (err) {}
  };

  const fetchFacultyProfile = async () => {
    try {
      const res = await api.get('/profiles/faculty/me');
      if (res.data) setFacultyProfile(res.data);
    } catch (err) {}
  };

  const handleProfileApproval = async (studentId, status) => {
    let reason = null;
    if (status === 'REJECTED') {
      reason = prompt('Please enter a rejection reason:');
      if (!reason) return;
    }
    try {
      await api.put(`/profiles/student/${studentId}/approve`, { status, rejection_reason: reason });
      fetchMetrics();
      fetchPending();
      alert(`Profile ${status.toLowerCase()}!`);
    } catch (err) {
      alert('Action failed.');
    }
  };

  const handleAchievementApproval = async (achievementId, status) => {
    let comments = prompt('Enter comments/feedback:');
    if (status === 'REJECTED' && !comments) {
        alert('Comments are required for rejection');
        return;
    }
    if (!comments) comments = 'Approved automatically.';
    try {
      await api.post(`/approvals/${achievementId}/review`, { action: status, comments });
      fetchApprovalQueue();
      alert(`Achievement ${status.toLowerCase()}!`);
    } catch (err) {
      alert('Action failed.');
    }
  };

  if (activeTab === 'profile') {
    return (
      <div>
        <button onClick={() => setActiveTab('overview')} className="mb-4 text-blue-600 hover:underline flex items-center font-medium">
          ← Back to Dashboard
        </button>
        <FacultyProfileForm />
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center border-b pb-4">
        <div className="flex items-center gap-4">
          {facultyProfile?.profile_photo_url ? (
            <img 
              src={facultyProfile.profile_photo_url.startsWith('http') ? facultyProfile.profile_photo_url : `http://localhost:8000${facultyProfile.profile_photo_url}`} 
              alt="Faculty Profile" 
              className="w-12 h-12 rounded-full object-cover shadow-sm border border-gray-200"
            />
          ) : (
            <div className="w-12 h-12 rounded-full bg-indigo-100 flex items-center justify-center text-indigo-500 font-bold text-xl">
              F
            </div>
          )}
          <h2 className="text-2xl font-bold text-gray-800">Faculty Overview</h2>
        </div>
        <div className="space-x-4">
            <button onClick={() => setActiveTab('overview')} className={`px-4 py-2 font-medium rounded ${activeTab === 'overview' ? 'bg-purple-600 text-white' : 'text-gray-600 hover:bg-gray-100'}`}>Overview</button>
            <button onClick={() => setActiveTab('achievements')} className={`px-4 py-2 font-medium rounded ${activeTab === 'achievements' ? 'bg-purple-600 text-white' : 'text-gray-600 hover:bg-gray-100'}`}>Achievement Queue</button>
            <button onClick={() => setActiveTab('insights')} className={`px-4 py-2 font-medium rounded ${activeTab === 'insights' ? 'bg-purple-600 text-white' : 'text-gray-600 hover:bg-gray-100'}`}>Mentor Insights</button>
            <button onClick={() => setActiveTab('readiness')} className={`px-4 py-2 font-medium rounded flex items-center ${activeTab === 'readiness' ? 'bg-indigo-600 text-white' : 'text-gray-600 hover:bg-gray-100'}`}><span className="mr-2">🚀</span> Predictive Readiness</button>
            <button onClick={() => setActiveTab('profile')} className="px-4 py-2 bg-gradient-to-r from-purple-500 to-indigo-600 text-white rounded shadow hover:opacity-90 transition font-medium">My Profile</button>
        </div>
      </div>

      {activeTab === 'overview' && (
        <>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div className="bg-white/80 backdrop-blur-sm rounded-xl shadow-lg p-6 border-l-4 border-blue-500">
            <h3 className="text-gray-500 font-medium text-sm uppercase tracking-wide">Assigned Students</h3>
            <p className="text-3xl font-bold text-gray-800 mt-2">{metrics.assigned_students}</p>
          </div>
          <div className="bg-white/80 backdrop-blur-sm rounded-xl shadow-lg p-6 border-l-4 border-orange-500">
            <h3 className="text-gray-500 font-medium text-sm uppercase tracking-wide">Pending Profiles</h3>
            <p className="text-3xl font-bold text-gray-800 mt-2">{metrics.pending_profiles}</p>
          </div>
          <div className="bg-white/80 backdrop-blur-sm rounded-xl shadow-lg p-6 border-l-4 border-green-500">
            <h3 className="text-gray-500 font-medium text-sm uppercase tracking-wide">Approved Profiles</h3>
            <p className="text-3xl font-bold text-gray-800 mt-2">{metrics.approved_profiles}</p>
          </div>
        </div>

        <div className="bg-white/90 backdrop-blur-sm rounded-xl shadow-lg overflow-hidden">
          <div className="p-6 border-b border-gray-100">
            <h3 className="text-lg font-bold text-gray-800">Pending Student Approvals</h3>
          </div>
          <div className="overflow-x-auto">
            <table className="w-full text-left border-collapse">
              <thead>
                <tr className="bg-gray-50 text-gray-600 text-sm uppercase tracking-wider">
                  <th className="p-4 font-semibold">Student Name</th>
                  <th className="p-4 font-semibold">Email</th>
                  <th className="p-4 font-semibold">Enrollment No.</th>
                  <th className="p-4 font-semibold text-right">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {pendingStudents.length === 0 ? (
                  <tr><td colSpan="4" className="p-4 text-center text-gray-500">No pending profiles found.</td></tr>
                ) : pendingStudents.map(student => (
                  <tr key={student.user_id} className="hover:bg-gray-50/50 transition">
                    <td className="p-4 font-medium text-gray-800">{student.name}</td>
                    <td className="p-4 text-gray-600">{student.email}</td>
                    <td className="p-4 text-gray-600">{student.enrollment_number}</td>
                    <td className="p-4 text-right space-x-2">
                      <button onClick={() => handleProfileApproval(student.user_id, 'APPROVED')} className="bg-green-100 text-green-700 px-3 py-1 rounded hover:bg-green-200 transition text-sm font-medium">Approve</button>
                      <button onClick={() => handleProfileApproval(student.user_id, 'REJECTED')} className="bg-red-100 text-red-700 px-3 py-1 rounded hover:bg-red-200 transition text-sm font-medium">Reject</button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
        </>
      )}

      {activeTab === 'achievements' && (
          <div className="bg-white/90 backdrop-blur-sm rounded-xl shadow-lg overflow-hidden">
          <div className="p-6 border-b border-gray-100 flex justify-between items-center">
            <h3 className="text-lg font-bold text-gray-800">Achievement Approval Queue</h3>
            <span className="bg-orange-100 text-orange-800 px-3 py-1 rounded-full text-xs font-bold">{approvalQueue.length} Pending</span>
          </div>
          <div className="overflow-x-auto">
            <table className="w-full text-left border-collapse">
              <thead>
                <tr className="bg-gray-50 text-gray-600 text-sm uppercase tracking-wider">
                  <th className="p-4 font-semibold">Achievement</th>
                  <th className="p-4 font-semibold">AI Validation</th>
                  <th className="p-4 font-semibold">Date</th>
                  <th className="p-4 font-semibold text-right">Actions</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {approvalQueue.length === 0 ? (
                  <tr><td colSpan="4" className="p-4 text-center text-gray-500">No achievements pending review.</td></tr>
                ) : approvalQueue.map(a => (
                  <tr key={a.id} className="hover:bg-gray-50/50 transition">
                    <td className="p-4">
                        <p className="font-medium text-gray-800">{a.title}</p>
                        <p className="text-sm text-gray-500">{a.organization_name}</p>
                    </td>
                    <td className="p-4">
                        {a.duplicate_status === 'UNIQUE' ? (
                            <span className="text-green-600 text-sm font-medium flex items-center"><svg className="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M5 13l4 4L19 7"></path></svg> Unique</span>
                        ) : (
                            <span className="text-red-600 text-sm font-medium flex items-center"><svg className="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path></svg> Suspected Duplicate ({a.duplicate_confidence}%)</span>
                        )}
                    </td>
                    <td className="p-4 text-gray-600 text-sm">{new Date(a.created_at).toLocaleDateString()}</td>
                    <td className="p-4 text-right space-x-2">
                      <button onClick={() => handleAchievementApproval(a.id, 'APPROVED')} className="bg-green-100 text-green-700 px-3 py-1 rounded hover:bg-green-200 transition text-sm font-medium">Verify</button>
                      <button onClick={() => handleAchievementApproval(a.id, 'REJECTED')} className="bg-red-100 text-red-700 px-3 py-1 rounded hover:bg-red-200 transition text-sm font-medium">Reject</button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}

      {activeTab === 'insights' && (
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div className="bg-white rounded-xl shadow-md p-6">
                  <h3 className="text-lg font-bold text-gray-800 mb-4 border-b pb-2">Top Performers</h3>
                  {mentorInsights.top_performers.length === 0 ? <p className="text-gray-500">No data available.</p> : (
                      <ul className="space-y-3">
                          {mentorInsights.top_performers.map((p, idx) => (
                              <li key={p.student_id} className="flex justify-between items-center p-3 bg-gray-50 rounded border">
                                  <div className="flex items-center">
                                    <span className="font-bold text-indigo-600 text-lg mr-3">#{idx+1}</span>
                                    <span className="font-medium">{p.student_name}</span>
                                  </div>
                                  <span className="bg-indigo-100 text-indigo-800 px-2 py-1 rounded text-sm font-bold">{p.total_points} pts</span>
                              </li>
                          ))}
                      </ul>
                  )}
              </div>

              <div className="bg-white rounded-xl shadow-md p-6">
                  <h3 className="text-lg font-bold text-gray-800 mb-4 border-b pb-2">Least Active Students</h3>
                  {mentorInsights.least_active.length === 0 ? <p className="text-gray-500">All your students are active!</p> : (
                      <ul className="space-y-3">
                          {mentorInsights.least_active.map(p => (
                              <li key={p.student_id} className="flex justify-between items-center p-3 bg-red-50 rounded border border-red-100">
                                  <span className="font-medium text-red-800">{p.student_name}</span>
                                  <span className="text-red-500 text-sm">0 pts</span>
                              </li>
                          ))}
                      </ul>
                  )}
              </div>
          </div>
      )}

      {activeTab === 'readiness' && (
        <PlacementReadinessView />
      )}
    </div>
  );
}
