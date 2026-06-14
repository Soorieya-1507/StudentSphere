import React, { useState, useEffect } from 'react';
import api from '../api/axios';
import { motion } from 'framer-motion';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Users, UserCheck, ShieldCheck, AlertCircle, FileText, Activity } from 'lucide-react';
import PlacementReadinessView from '../components/PlacementReadinessView';
import FacultyProfileForm from '../components/FacultyProfileForm';
import { toast } from 'react-toastify';

export default function FacultyDashboard({ role }) {
  const [metrics, setMetrics] = useState({ assigned_students: 0, pending_profiles: 0, approved_profiles: 0 });
  const [pendingStudents, setPendingStudents] = useState([]);
  const [approvalQueue, setApprovalQueue] = useState([]);
  const [mentorInsights, setMentorInsights] = useState({ top_performers: [], least_active: [] });
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
      toast.success(`Student profile ${status.toLowerCase()} successfully!`);
    } catch (err) {
      toast.error('Failed to update student profile status');
    }
  };

  const handleAchievementApproval = async (achievementId, status) => {
    let comments = prompt('Enter comments/feedback:');
    if (status === 'REJECTED' && !comments) {
        toast.warning('Comments are required for rejection');
        return;
    }
    if (!comments) comments = 'Approved automatically.';
    try {
      await api.post(`/approvals/${achievementId}/review`, { action: status, comments });
      fetchApprovalQueue();
      toast.success(`Achievement ${status.toLowerCase()} successfully!`);
    } catch (err) {
      toast.error('Action failed.');
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
        <div className="flex items-center gap-5">
          {facultyProfile?.profile_photo_url ? (
            <img 
              src={facultyProfile.profile_photo_url.startsWith('http') ? facultyProfile.profile_photo_url : `http://localhost:8000${facultyProfile.profile_photo_url}`} 
              alt="Faculty Profile" 
              className="w-16 h-16 rounded-full object-cover shadow-md border-2 border-white"
            />
          ) : (
            <div className="w-16 h-16 rounded-full bg-slate-100 flex items-center justify-center text-slate-500 font-bold text-2xl border-2 border-slate-200 shadow-sm">
              <UserCheck className="w-8 h-8"/>
            </div>
          )}
          <div>
            <h2 className="text-3xl font-bold text-slate-900 tracking-tight">{role === 'HOD' ? 'Department Head' : 'Faculty'} Workspace</h2>
            <p className="text-slate-500 mt-1 flex items-center gap-2">
              <span className="bg-indigo-100 text-indigo-700 px-2 py-0.5 rounded text-xs font-bold tracking-wide uppercase">{role}</span>
              Monitor student progress and approve achievements
            </p>
          </div>
        </div>
      </motion.div>

      <Tabs defaultValue="overview" className="w-full">
        <TabsList className="mb-6 grid w-full grid-cols-5 lg:w-[700px] bg-slate-100 p-1">
          <TabsTrigger value="overview">Overview</TabsTrigger>
          <TabsTrigger value="achievements">Approvals</TabsTrigger>
          <TabsTrigger value="insights">Insights</TabsTrigger>
          <TabsTrigger value="readiness">Predictive</TabsTrigger>
          <TabsTrigger value="profile">My Profile</TabsTrigger>
        </TabsList>

        <TabsContent value="overview">
          <motion.div variants={containerVariants} initial="hidden" animate="show" className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <motion.div variants={itemVariants}>
              <Card className="hover:shadow-md transition-all duration-300 border-none bg-white/60 backdrop-blur-xl shadow-sm">
                <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                  <CardTitle className="text-sm font-semibold text-slate-500">Mentee Roster</CardTitle>
                  <Users className="h-4 w-4 text-blue-600" />
                </CardHeader>
                <CardContent>
                  <div className="text-3xl font-bold text-slate-900">{metrics.assigned_students}</div>
                  <p className="text-xs text-slate-500 mt-1">Assigned Students</p>
                </CardContent>
              </Card>
            </motion.div>
            
            <motion.div variants={itemVariants}>
              <Card className="hover:shadow-md transition-all duration-300 border-none bg-amber-50 backdrop-blur-xl shadow-sm">
                <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                  <CardTitle className="text-sm font-semibold text-amber-700">Pending Profiles</CardTitle>
                  <AlertCircle className="h-4 w-4 text-amber-600" />
                </CardHeader>
                <CardContent>
                  <div className="text-3xl font-bold text-amber-900">{metrics.pending_profiles}</div>
                  <p className="text-xs text-amber-600 mt-1">Require Review</p>
                </CardContent>
              </Card>
            </motion.div>

            <motion.div variants={itemVariants}>
              <Card className="hover:shadow-md transition-all duration-300 border-none bg-emerald-50 backdrop-blur-xl shadow-sm">
                <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                  <CardTitle className="text-sm font-semibold text-emerald-700">Verified Profiles</CardTitle>
                  <ShieldCheck className="h-4 w-4 text-emerald-600" />
                </CardHeader>
                <CardContent>
                  <div className="text-3xl font-bold text-emerald-900">{metrics.approved_profiles}</div>
                  <p className="text-xs text-emerald-600 mt-1">Fully Onboarded</p>
                </CardContent>
              </Card>
            </motion.div>
          </motion.div>

          <Card className="border-none shadow-sm">
            <CardHeader>
              <CardTitle>Student Approval Queue</CardTitle>
              <CardDescription>Review and verify newly registered student profiles.</CardDescription>
            </CardHeader>
            <CardContent>
              <div className="overflow-x-auto">
                <table className="w-full text-left border-collapse">
                  <thead>
                    <tr className="border-b border-slate-100 text-slate-500 text-sm uppercase tracking-wider">
                      <th className="p-4 font-semibold">Student Name</th>
                      <th className="p-4 font-semibold">Email</th>
                      <th className="p-4 font-semibold">Enrollment No.</th>
                      <th className="p-4 font-semibold text-right">Actions</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-slate-50">
                    {pendingStudents.length === 0 ? (
                      <tr><td colSpan="4" className="p-8 text-center text-slate-500">Inbox Zero! No pending profiles.</td></tr>
                    ) : pendingStudents.map(student => (
                      <tr key={student.user_id} className="hover:bg-slate-50 transition-colors">
                        <td className="p-4 font-medium text-slate-900">{student.name}</td>
                        <td className="p-4 text-slate-500">{student.email}</td>
                        <td className="p-4 text-slate-500">{student.enrollment_number}</td>
                        <td className="p-4 text-right space-x-2">
                          <button onClick={() => handleProfileApproval(student.user_id, 'APPROVED')} className="bg-emerald-100 text-emerald-700 px-3 py-1.5 rounded-md hover:bg-emerald-200 transition text-sm font-semibold">Approve</button>
                          <button onClick={() => handleProfileApproval(student.user_id, 'REJECTED')} className="bg-rose-100 text-rose-700 px-3 py-1.5 rounded-md hover:bg-rose-200 transition text-sm font-semibold">Reject</button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="achievements">
          <Card className="border-none shadow-sm">
            <CardHeader className="flex flex-row justify-between items-center">
              <div>
                <CardTitle>Achievement Verification</CardTitle>
                <CardDescription>Review student certificates and assign academic points.</CardDescription>
              </div>
              <div className="bg-amber-100 text-amber-800 px-3 py-1 rounded-full text-xs font-bold">{approvalQueue.length} Pending</div>
            </CardHeader>
            <CardContent>
              <div className="overflow-x-auto">
                <table className="w-full text-left border-collapse">
                  <thead>
                    <tr className="border-b border-slate-100 text-slate-500 text-sm uppercase tracking-wider">
                      <th className="p-4 font-semibold">Achievement Details</th>
                      <th className="p-4 font-semibold">AI Validation Report</th>
                      <th className="p-4 font-semibold">Submission Date</th>
                      <th className="p-4 font-semibold text-right">Actions</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-slate-50">
                    {approvalQueue.length === 0 ? (
                      <tr><td colSpan="4" className="p-8 text-center text-slate-500">All caught up! No achievements pending review.</td></tr>
                    ) : approvalQueue.map(a => (
                      <tr key={a.id} className="hover:bg-slate-50 transition-colors">
                        <td className="p-4">
                            <p className="font-semibold text-slate-900 flex items-center gap-2"><FileText className="w-4 h-4 text-indigo-500"/>{a.title}</p>
                            <p className="text-sm text-slate-500 mt-1">{a.organization_name}</p>
                        </td>
                        <td className="p-4">
                            {a.duplicate_status === 'UNIQUE' ? (
                                <span className="bg-emerald-50 text-emerald-700 px-2.5 py-1 rounded-full text-xs font-semibold border border-emerald-200 flex items-center inline-flex">
                                  <ShieldCheck className="w-3 h-3 mr-1"/> Unique
                                </span>
                            ) : (
                                <span className="bg-rose-50 text-rose-700 px-2.5 py-1 rounded-full text-xs font-semibold border border-rose-200 flex items-center inline-flex">
                                  <AlertCircle className="w-3 h-3 mr-1"/> Suspected Duplicate ({a.duplicate_confidence}%)
                                </span>
                            )}
                        </td>
                        <td className="p-4 text-slate-500 text-sm">{new Date(a.created_at).toLocaleDateString()}</td>
                        <td className="p-4 text-right space-x-2">
                          <button onClick={() => handleAchievementApproval(a.id, 'APPROVED')} className="bg-indigo-600 text-white px-4 py-1.5 rounded-md hover:bg-indigo-700 transition text-sm font-semibold">Verify & Assign Points</button>
                          <button onClick={() => handleAchievementApproval(a.id, 'REJECTED')} className="bg-slate-100 text-slate-700 px-4 py-1.5 rounded-md hover:bg-slate-200 transition text-sm font-semibold">Reject</button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="insights">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <Card className="border-none shadow-sm">
              <CardHeader>
                <CardTitle>Top Performers</CardTitle>
                <CardDescription>Highest scoring students in your roster</CardDescription>
              </CardHeader>
              <CardContent>
                {mentorInsights.top_performers.length === 0 ? <p className="text-slate-500 text-center py-4">No data available.</p> : (
                  <div className="space-y-3">
                    {mentorInsights.top_performers.map((p, idx) => (
                      <div key={p.student_id} className="flex justify-between items-center p-3 hover:bg-slate-50 rounded-xl border border-slate-100 transition-colors">
                        <div className="flex items-center gap-3">
                          <div className="w-8 h-8 rounded-full bg-indigo-50 text-indigo-700 font-bold flex items-center justify-center text-sm">#{idx+1}</div>
                          <span className="font-semibold text-slate-800">{p.student_name}</span>
                        </div>
                        <span className="bg-indigo-100 text-indigo-800 px-3 py-1 rounded-full text-xs font-bold">{p.total_points} pts</span>
                      </div>
                    ))}
                  </div>
                )}
              </CardContent>
            </Card>

            <Card className="border-none shadow-sm bg-rose-50/30">
              <CardHeader>
                <CardTitle className="text-rose-900 flex items-center gap-2"><Activity className="w-5 h-5 text-rose-500"/> Intervention Required</CardTitle>
                <CardDescription className="text-rose-700/70">Least active students needing attention</CardDescription>
              </CardHeader>
              <CardContent>
                {mentorInsights.least_active.length === 0 ? <p className="text-slate-500 text-center py-4">All your students are active!</p> : (
                  <div className="space-y-3">
                    {mentorInsights.least_active.map(p => (
                      <div key={p.student_id} className="flex justify-between items-center p-3 bg-white rounded-xl border border-rose-100 shadow-sm">
                        <span className="font-semibold text-rose-800">{p.student_name}</span>
                        <span className="text-rose-500 text-sm font-bold bg-rose-100 px-2 py-0.5 rounded">0 pts</span>
                      </div>
                    ))}
                  </div>
                )}
              </CardContent>
            </Card>
          </div>
        </TabsContent>

        <TabsContent value="readiness">
          <Card className="border-none shadow-sm">
            <CardContent className="p-6">
              <PlacementReadinessView />
            </CardContent>
          </Card>
        </TabsContent>

        <TabsContent value="profile">
          <FacultyProfileForm />
        </TabsContent>
      </Tabs>
    </div>
  );
}
