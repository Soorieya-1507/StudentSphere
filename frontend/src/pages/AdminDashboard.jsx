import React, { useState, useEffect } from 'react';
import api from '../api/axios';
import { motion } from 'framer-motion';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Building2, Users, UserCheck, GraduationCap, Award, AlertTriangle, TrendingUp, Briefcase } from 'lucide-react';
import IntelligenceDashboard from '../components/IntelligenceDashboard';
import { toast } from 'react-toastify';

export default function AdminDashboard({ instituteId, departments, fetchDepartments }) {
  const [metrics, setMetrics] = useState({ total_students: 0, total_faculty: 0, total_departments: 0 });
  const [rankings, setRankings] = useState([]);
  const [newDeptName, setNewDeptName] = useState('');
  
  // Registration States
  const [registerType, setRegisterType] = useState('STUDENT');
  const [registerData, setRegisterData] = useState({ department_id: '', email: '', mobile_number: '', password: '', institute_id: instituteId });

  useEffect(() => {
    fetchMetrics();
    fetchRankings();
  }, []);

  const fetchMetrics = async () => {
    try {
      const res = await api.get('/dashboards/admin');
      setMetrics(res.data);
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
      toast.success('Department created successfully!');
    } catch (err) {
      toast.error('Failed to create department');
    }
  };

  const handleRegisterUser = async (e) => {
    e.preventDefault();
    try {
      const endpoint = registerType === 'STUDENT' ? '/auth/register/student' : '/auth/register/faculty';
      await api.post(endpoint, registerData);
      toast.success(`${registerType} registered successfully!`);
      setRegisterData({ department_id: '', email: '', mobile_number: '', password: '', institute_id: instituteId });
    } catch (err) {
      if (err.response?.data?.detail && Array.isArray(err.response.data.detail)) {
         toast.error(err.response.data.detail[0].msg);
      } else {
         toast.error(err.response?.data?.detail || 'Registration failed');
      }
    }
  };

  const containerVariants = {
    hidden: { opacity: 0 },
    show: { opacity: 1, transition: { staggerChildren: 0.1 } }
  };
  const itemVariants = {
    hidden: { opacity: 0, y: 20 },
    show: { opacity: 1, y: 0, transition: { type: 'spring', stiffness: 300 } }
  };

  return (
    <div className="space-y-8 p-6 max-w-7xl mx-auto">
      <motion.div initial={{ opacity: 0, x: -20 }} animate={{ opacity: 1, x: 0 }} className="flex justify-between items-center border-b border-slate-200 pb-5">
        <div>
          <h2 className="text-3xl font-bold text-slate-900 tracking-tight">Executive Analytics</h2>
          <p className="text-slate-500 mt-1">Institutional Intelligence and Performance Dashboard</p>
        </div>
      </motion.div>

      <Tabs defaultValue="overview" className="w-full">
        <TabsList className="mb-6 grid w-full grid-cols-4 lg:w-[600px] bg-slate-100 p-1">
          <TabsTrigger value="overview">Overview</TabsTrigger>
          <TabsTrigger value="intelligence">Intelligence</TabsTrigger>
          <TabsTrigger value="departments">Departments</TabsTrigger>
          <TabsTrigger value="users">Onboarding</TabsTrigger>
        </TabsList>

        <TabsContent value="overview">
          <motion.div variants={containerVariants} initial="hidden" animate="show" className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
            <motion.div variants={itemVariants}>
              <Card className="hover:shadow-lg transition-all duration-300 border-none bg-white/60 backdrop-blur-xl shadow-sm">
                <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                  <CardTitle className="text-sm font-semibold text-slate-500">Total Students</CardTitle>
                  <Users className="h-4 w-4 text-blue-600" />
                </CardHeader>
                <CardContent>
                  <div className="text-3xl font-bold text-slate-900">{metrics.total_students}</div>
                  <p className="text-xs text-emerald-500 mt-1 flex items-center font-medium"><TrendingUp className="h-3 w-3 mr-1"/> Active Enrolled</p>
                </CardContent>
              </Card>
            </motion.div>
            
            <motion.div variants={itemVariants}>
              <Card className="hover:shadow-lg transition-all duration-300 border-none bg-white/60 backdrop-blur-xl shadow-sm">
                <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                  <CardTitle className="text-sm font-semibold text-slate-500">Total Faculty</CardTitle>
                  <UserCheck className="h-4 w-4 text-purple-600" />
                </CardHeader>
                <CardContent>
                  <div className="text-3xl font-bold text-slate-900">{metrics.total_faculty}</div>
                  <p className="text-xs text-emerald-500 mt-1 flex items-center font-medium"><TrendingUp className="h-3 w-3 mr-1"/> Verified Staff</p>
                </CardContent>
              </Card>
            </motion.div>

            <motion.div variants={itemVariants}>
              <Card className="hover:shadow-lg transition-all duration-300 border-none bg-white/60 backdrop-blur-xl shadow-sm">
                <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                  <CardTitle className="text-sm font-semibold text-slate-500">Departments</CardTitle>
                  <Building2 className="h-4 w-4 text-indigo-600" />
                </CardHeader>
                <CardContent>
                  <div className="text-3xl font-bold text-slate-900">{metrics.total_departments}</div>
                  <p className="text-xs text-slate-500 mt-1">Operational Branches</p>
                </CardContent>
              </Card>
            </motion.div>

            <motion.div variants={itemVariants}>
              <Card className="hover:shadow-lg transition-all duration-300 border-none bg-gradient-to-br from-slate-900 to-slate-800 shadow-xl">
                <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                  <CardTitle className="text-sm font-medium text-slate-300">Platform Health</CardTitle>
                  <AlertTriangle className="h-4 w-4 text-amber-400" />
                </CardHeader>
                <CardContent>
                  <div className="text-3xl font-bold text-white">100%</div>
                  <p className="text-xs text-emerald-400 mt-1">Systems Operational</p>
                </CardContent>
              </Card>
            </motion.div>
          </motion.div>

          <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
            <Card className="border-none shadow-sm">
              <CardHeader>
                <CardTitle>Department Leaderboard</CardTitle>
                <CardDescription>Performance rankings based on student achievements and placement readiness.</CardDescription>
              </CardHeader>
              <CardContent>
                <div className="space-y-4">
                  {rankings.length === 0 ? (
                    <p className="text-slate-500 text-sm text-center py-4">Ranking data generating...</p>
                  ) : (
                    rankings.map((r, i) => (
                      <div key={i} className="flex items-center justify-between p-4 bg-slate-50 rounded-xl border border-slate-100">
                        <div className="flex items-center gap-4">
                          <div className={`w-8 h-8 rounded-full flex items-center justify-center font-bold text-sm ${i === 0 ? 'bg-amber-100 text-amber-700' : 'bg-slate-200 text-slate-600'}`}>
                            #{i + 1}
                          </div>
                          <div>
                            <p className="font-semibold text-slate-900">{r.department_id.split('-')[0]}...</p>
                            <p className="text-xs text-slate-500">{r.total_projects} Projects • {r.total_internships} Internships</p>
                          </div>
                        </div>
                        <div className="text-right">
                          <p className="font-bold text-indigo-600">{r.department_score}</p>
                          <p className="text-xs text-slate-400">Score</p>
                        </div>
                      </div>
                    ))
                  )}
                </div>
              </CardContent>
            </Card>

            <Card className="border-none shadow-sm bg-gradient-to-br from-indigo-50 to-blue-50">
              <CardHeader>
                <CardTitle className="text-indigo-900">Institution Intelligence Score</CardTitle>
                <CardDescription className="text-indigo-700/70">Overall placement readiness & academic health.</CardDescription>
              </CardHeader>
              <CardContent className="flex flex-col items-center justify-center py-12">
                <motion.div 
                  initial={{ scale: 0 }} animate={{ scale: 1 }} transition={{ type: "spring", delay: 0.2 }}
                  className="w-48 h-48 rounded-full border-8 border-indigo-200 flex flex-col items-center justify-center bg-white shadow-xl"
                >
                  <span className="text-5xl font-black text-indigo-600">A+</span>
                  <span className="text-sm font-semibold text-slate-500 mt-2">NAAC Grade Est.</span>
                </motion.div>
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        <TabsContent value="intelligence">
          <Card className="border-none shadow-sm">
            <CardContent className="p-6">
              <IntelligenceDashboard />
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="departments">
          <Card className="border-none shadow-sm">
            <CardHeader>
              <CardTitle>Department Management</CardTitle>
              <CardDescription>Add and manage operational departments for your institution.</CardDescription>
            </CardHeader>
            <CardContent>
              <form onSubmit={handleAddDepartment} className="flex gap-4 mb-8 max-w-xl">
                <input 
                  type="text" placeholder="e.g. Artificial Intelligence & Data Science" 
                  className="flex-1 px-4 py-2 bg-slate-50 border border-slate-200 rounded-lg focus:ring-2 focus:ring-blue-500/20 focus:border-blue-600 outline-none transition-all"
                  value={newDeptName} onChange={e => setNewDeptName(e.target.value)} required
                />
                <button type="submit" className="bg-slate-900 hover:bg-slate-800 text-white px-6 py-2 rounded-lg font-medium transition-all shadow-md">Create Department</button>
              </form>
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                {departments.map(dept => (
                  <div key={dept.id} className="p-4 bg-white border border-slate-200 rounded-xl shadow-sm flex items-center gap-3">
                    <div className="bg-indigo-100 text-indigo-600 p-2 rounded-lg"><Building2 className="w-5 h-5"/></div>
                    <span className="font-semibold text-slate-800">{dept.name}</span>
                  </div>
                ))}
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="users">
          <Card className="border-none shadow-sm max-w-2xl mx-auto">
            <CardHeader className="text-center">
              <CardTitle>User Onboarding</CardTitle>
              <CardDescription>Register new students and faculty to your institution's workspace.</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="flex justify-center gap-4 mb-8 bg-slate-100 p-1 rounded-lg">
                <button onClick={() => setRegisterType('STUDENT')} className={`flex-1 py-2 rounded-md font-semibold transition-all ${registerType === 'STUDENT' ? 'bg-white text-blue-700 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}>Student</button>
                <button onClick={() => setRegisterType('FACULTY')} className={`flex-1 py-2 rounded-md font-semibold transition-all ${registerType === 'FACULTY' ? 'bg-white text-purple-700 shadow-sm' : 'text-slate-500 hover:text-slate-700'}`}>Faculty / HOD</button>
              </div>
              <form onSubmit={handleRegisterUser} className="space-y-5">
                <div>
                  <label className="block text-sm font-medium text-slate-700 mb-1">Department Assignment</label>
                  <select required className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-lg focus:ring-2 focus:ring-blue-500/20 focus:border-blue-600 outline-none transition-all text-slate-800"
                    value={registerData.department_id} onChange={e => setRegisterData({...registerData, department_id: e.target.value})}>
                    <option value="">Select Department...</option>
                    {departments.map(d => <option key={d.id} value={d.id}>{d.name}</option>)}
                  </select>
                </div>
                <div>
                  <label className="block text-sm font-medium text-slate-700 mb-1">Institutional Email</label>
                  <input type="email" required className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-lg focus:ring-2 focus:ring-blue-500/20 focus:border-blue-600 outline-none transition-all text-slate-800"
                    placeholder="name@institution.edu"
                    value={registerData.email} onChange={e => setRegisterData({...registerData, email: e.target.value})} />
                </div>
                <div>
                  <label className="block text-sm font-medium text-slate-700 mb-1">Mobile Number</label>
                  <input type="text" required className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-lg focus:ring-2 focus:ring-blue-500/20 focus:border-blue-600 outline-none transition-all text-slate-800"
                    placeholder="10-digit number"
                    value={registerData.mobile_number} onChange={e => setRegisterData({...registerData, mobile_number: e.target.value})} />
                </div>
                <div>
                  <label className="block text-sm font-medium text-slate-700 mb-1">Initial Workspace Password</label>
                  <input type="password" required className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-lg focus:ring-2 focus:ring-blue-500/20 focus:border-blue-600 outline-none transition-all text-slate-800"
                    placeholder="Min 6 chars, A-z, 0-9, symbol"
                    value={registerData.password} onChange={e => setRegisterData({...registerData, password: e.target.value})} />
                </div>
                <button type="submit" className={`w-full text-white font-semibold py-3 rounded-lg shadow-md transition-all mt-4 ${registerType === 'STUDENT' ? 'bg-blue-600 hover:bg-blue-700' : 'bg-purple-600 hover:bg-purple-700'}`}>
                  Create {registerType === 'STUDENT' ? 'Student' : 'Faculty'} Account
                </button>
              </form>
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
