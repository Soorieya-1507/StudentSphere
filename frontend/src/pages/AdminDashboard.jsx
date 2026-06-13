import React, { useState, useEffect } from 'react';
import api from '../api/axios';
import IntelligenceDashboard from '../components/IntelligenceDashboard';

export default function AdminDashboard({ instituteId, departments, fetchDepartments }) {
  const [metrics, setMetrics] = useState({ total_students: 0, total_faculty: 0, total_departments: 0 });
  const [rankings, setRankings] = useState([]);
  const [newDeptName, setNewDeptName] = useState('');
  const [activeTab, setActiveTab] = useState('overview');
  
  // For mentor assignment
  const [facultyList, setFacultyList] = useState([]);
  const [mentorData, setMentorData] = useState({ faculty_id: '', department_id: '', batch_year: new Date().getFullYear() });

  // For User Registration
  const [registerType, setRegisterType] = useState('STUDENT');
  const [registerData, setRegisterData] = useState({ department_id: '', email: '', mobile_number: '', password: '', institute_id: instituteId });

  useEffect(() => {
    fetchMetrics();
    fetchFacultyList();
    fetchRankings();
  }, []);

  const fetchMetrics = async () => {
    try {
      const res = await api.get('/dashboards/admin');
      setMetrics(res.data);
    } catch (err) { console.error(err); }
  };

  const fetchFacultyList = async () => {
    try {
      const res = await api.get('/mentors/faculty');
      setFacultyList(res.data);
    } catch (err) { console.error(err); }
  };

  const fetchRankings = async () => {
    try {
      const res = await api.get('/analytics/department-rankings');
      setRankings(res.data);
    } catch (err) {}
  };

  const handleAddDepartment = async (e) => {
    e.preventDefault();
    if (!newDeptName.trim() || !instituteId) return;
    try {
      await api.post(`/departments?institute_id=${instituteId}`, { name: newDeptName });
      setNewDeptName('');
      fetchDepartments(instituteId);
      fetchMetrics();
    } catch (err) {}
  };

  const handleAssignMentor = async (e) => {
    e.preventDefault();
    try {
      await api.post('/mentors/assign', mentorData);
      alert('Mentor assigned successfully!');
    } catch (err) {
      alert('Failed to assign mentor');
    }
  };

  const handleRegisterUser = async (e) => {
    e.preventDefault();
    try {
      const endpoint = registerType === 'STUDENT' ? '/auth/register/student' : '/auth/register/faculty';
      await api.post(endpoint, registerData);
      alert(`${registerType} registered successfully!`);
      setRegisterData({ department_id: '', email: '', mobile_number: '', password: '', institute_id: instituteId });
    } catch (err) {
      if (err.response?.data?.detail && Array.isArray(err.response.data.detail)) {
         alert(err.response.data.detail[0].msg);
      } else {
         alert(err.response?.data?.detail || 'Registration failed');
      }
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center border-b pb-4">
        <h2 className="text-2xl font-bold text-gray-800">Admin Dashboard</h2>
          <nav className="-mb-px flex space-x-8" aria-label="Tabs">
            <button onClick={() => setActiveTab('overview')} className={`${activeTab === 'overview' ? 'border-blue-500 text-blue-600' : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'} whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm`}>Overview</button>
            <button onClick={() => setActiveTab('intelligence')} className={`${activeTab === 'intelligence' ? 'border-purple-500 text-purple-600' : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'} whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm flex items-center`}><span className="mr-2">🧠</span> Institutional Intelligence</button>
            <button onClick={() => setActiveTab('departments')} className={`${activeTab === 'departments' ? 'border-blue-500 text-blue-600' : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'} whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm`}>Departments</button>
            <button onClick={() => setActiveTab('users')} className={`${activeTab === 'users' ? 'border-blue-500 text-blue-600' : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'} whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm`}>Users & Mentors</button>
          </nav>
      </div>

      {activeTab === 'overview' && (
      <>
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div className="bg-gradient-to-br from-blue-500 to-blue-700 rounded-xl shadow-lg p-6 text-white transform transition hover:-translate-y-1">
          <h3 className="text-blue-100 font-medium">Total Students</h3>
          <p className="text-4xl font-bold mt-2">{metrics.total_students}</p>
        </div>
        <div className="bg-gradient-to-br from-purple-500 to-purple-700 rounded-xl shadow-lg p-6 text-white transform transition hover:-translate-y-1">
          <h3 className="text-purple-100 font-medium">Total Faculty</h3>
          <p className="text-4xl font-bold mt-2">{metrics.total_faculty}</p>
        </div>
        <div className="bg-gradient-to-br from-green-500 to-green-700 rounded-xl shadow-lg p-6 text-white transform transition hover:-translate-y-1">
          <h3 className="text-green-100 font-medium">Total Departments</h3>
          <p className="text-4xl font-bold mt-2">{metrics.total_departments}</p>
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        <div className="bg-white/80 backdrop-blur-sm rounded-xl shadow p-6">
          <h3 className="text-xl font-bold text-gray-800 mb-4">Manage Departments</h3>
          <form onSubmit={handleAddDepartment} className="flex gap-4 mb-6">
            <input 
              type="text" placeholder="New Department Name" 
              className="flex-1 border-gray-300 border p-2 rounded focus:ring-2 focus:ring-blue-500 outline-none"
              value={newDeptName} onChange={e => setNewDeptName(e.target.value)} required
            />
            <button type="submit" className="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded shadow transition">Add</button>
          </form>
          <div className="max-h-48 overflow-y-auto">
            {departments.length === 0 ? <p className="text-gray-500">No departments added.</p> : (
              <ul className="space-y-2">
                {departments.map(dept => (
                  <li key={dept.id} className="p-3 bg-gray-50 rounded border border-gray-100 text-gray-700">{dept.name}</li>
                ))}
              </ul>
            )}
          </div>
        </div>

        <div className="bg-white/80 backdrop-blur-sm rounded-xl shadow p-6">
          <h3 className="text-xl font-bold text-gray-800 mb-4">Assign Mentor</h3>
          <form onSubmit={handleAssignMentor} className="space-y-4">
            <div>
              <label className="block text-sm text-gray-600 mb-1">Select Faculty</label>
              <select required className="w-full border-gray-300 border p-2 rounded focus:ring-2 focus:ring-purple-500 outline-none"
                value={mentorData.faculty_id} onChange={e => setMentorData({...mentorData, faculty_id: e.target.value})}>
                <option value="">-- Choose Faculty --</option>
                {facultyList.map(f => <option key={f.id} value={f.id}>{f.email}</option>)}
              </select>
            </div>
            <div>
              <label className="block text-sm text-gray-600 mb-1">Select Department</label>
              <select required className="w-full border-gray-300 border p-2 rounded focus:ring-2 focus:ring-purple-500 outline-none"
                value={mentorData.department_id} onChange={e => setMentorData({...mentorData, department_id: e.target.value})}>
                <option value="">-- Choose Department --</option>
                {departments.map(d => <option key={d.id} value={d.id}>{d.name}</option>)}
              </select>
            </div>
            <div>
              <label className="block text-sm text-gray-600 mb-1">Batch Year</label>
              <input type="number" required className="w-full border-gray-300 border p-2 rounded focus:ring-2 focus:ring-purple-500 outline-none"
                value={mentorData.batch_year} onChange={e => setMentorData({...mentorData, batch_year: parseInt(e.target.value)})} />
            </div>
            <button type="submit" className="w-full bg-purple-600 hover:bg-purple-700 text-white p-2 rounded shadow transition">
              Assign Mentor
            </button>
          </form>
        </div>
      </div>
      </>
      )}

      {activeTab === 'rankings' && (
        <div className="bg-white rounded-xl shadow p-6">
            <h3 className="text-xl font-bold text-gray-800 mb-6">Department Leaderboard</h3>
            <div className="overflow-x-auto">
              <table className="w-full text-left border-collapse">
                <thead>
                  <tr className="bg-blue-50 text-blue-800 text-sm uppercase tracking-wider">
                    <th className="p-4 font-bold">Rank</th>
                    <th className="p-4 font-bold">Department ID</th>
                    <th className="p-4 font-bold text-center">Projects</th>
                    <th className="p-4 font-bold text-center">Internships</th>
                    <th className="p-4 font-bold text-center">Hackathons</th>
                    <th className="p-4 font-bold text-right">Total Score</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-100">
                  {rankings.length === 0 ? (
                    <tr><td colSpan="6" className="p-4 text-center text-gray-500">Ranking data will be generated at end of semester.</td></tr>
                  ) : rankings.map((r, idx) => (
                    <tr key={r.id} className="hover:bg-gray-50 transition">
                      <td className="p-4 font-bold text-xl text-blue-600">#{idx + 1}</td>
                      <td className="p-4 font-medium">{r.department_id}</td>
                      <td className="p-4 text-center">{r.total_projects}</td>
                      <td className="p-4 text-center">{r.total_internships}</td>
                      <td className="p-4 text-center">{r.total_hackathons}</td>
                      <td className="p-4 text-right font-bold text-lg text-indigo-700">{r.department_score} pts</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
        </div>
      )}
      {activeTab === 'users' && (
        <div className="bg-white/80 backdrop-blur-sm rounded-xl shadow p-6 max-w-2xl mx-auto">
          <h3 className="text-xl font-bold text-gray-800 mb-6 text-center">Register New User</h3>
          <div className="flex justify-center gap-4 mb-6">
            <button onClick={() => setRegisterType('STUDENT')} className={`px-4 py-2 rounded font-medium transition ${registerType === 'STUDENT' ? 'bg-orange-600 text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'}`}>Student</button>
            <button onClick={() => setRegisterType('FACULTY')} className={`px-4 py-2 rounded font-medium transition ${registerType === 'FACULTY' ? 'bg-green-600 text-white' : 'bg-gray-100 text-gray-600 hover:bg-gray-200'}`}>Faculty / HOD</button>
          </div>
          <form onSubmit={handleRegisterUser} className="space-y-4">
            <div>
              <label className="block text-sm font-medium mb-1">Select Department</label>
              <select required className="w-full border-gray-300 border p-2 rounded focus:ring-2 focus:ring-blue-500 outline-none"
                value={registerData.department_id} onChange={e => setRegisterData({...registerData, department_id: e.target.value})}>
                <option value="">-- Choose Department --</option>
                {departments.map(d => <option key={d.id} value={d.id}>{d.name}</option>)}
              </select>
            </div>
            <div>
              <label className="block text-sm font-medium mb-1">Email</label>
              <input type="email" required className="w-full border-gray-300 border p-2 rounded focus:ring-2 focus:ring-blue-500 outline-none"
                value={registerData.email} onChange={e => setRegisterData({...registerData, email: e.target.value})} />
            </div>
            <div>
              <label className="block text-sm font-medium mb-1">Mobile Number</label>
              <input type="text" required className="w-full border-gray-300 border p-2 rounded focus:ring-2 focus:ring-blue-500 outline-none"
                value={registerData.mobile_number} onChange={e => setRegisterData({...registerData, mobile_number: e.target.value})} />
            </div>
            <div>
              <label className="block text-sm font-medium mb-1">Temporary Password</label>
              <input type="password" required className="w-full border-gray-300 border p-2 rounded focus:ring-2 focus:ring-blue-500 outline-none"
                value={registerData.password} onChange={e => setRegisterData({...registerData, password: e.target.value})} />
              <p className="text-xs text-gray-500 mt-1">Min 6 chars, uppercase, lowercase, number, special char</p>
            </div>
            <button type="submit" className={`w-full text-white p-2 rounded shadow transition ${registerType === 'STUDENT' ? 'bg-orange-600 hover:bg-orange-700' : 'bg-green-600 hover:bg-green-700'}`}>
              Register {registerType === 'STUDENT' ? 'Student' : 'Faculty'}
            </button>
          </form>
        </div>
      )}
      {activeTab === 'intelligence' && (
        <IntelligenceDashboard />
      )}
    </div>
  );
}
