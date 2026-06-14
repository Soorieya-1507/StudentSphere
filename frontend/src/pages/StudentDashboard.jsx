import React, { useState, useEffect } from 'react';
import api from '../api/axios';
import { motion } from 'framer-motion';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Target, Award, BookOpen, GraduationCap, Clock, FileText, CheckCircle2, TrendingUp } from 'lucide-react';
import StudentProfileForm from '../components/StudentProfileForm';
import AchievementUpload from '../components/AchievementUpload';
import AchievementTimeline from '../components/AchievementTimeline';
import CareerDashboard from './CareerDashboard';
import { toast } from 'react-toastify';

export default function StudentDashboard() {
  const [profile, setProfile] = useState(null);
  const [timeline, setTimeline] = useState([]);
  const [gpaData, setGpaData] = useState(null);
  
  useEffect(() => {
    fetchProfile();
    fetchTimeline();
    fetchGpaData();
  }, []);

  const fetchProfile = async () => {
    try {
      const res = await api.get('/profiles/student/me');
      setProfile(res.data);
    } catch (err) {}
  };

  const fetchTimeline = async () => {
    try {
      const res = await api.get('/achievements');
      setTimeline(res.data);
    } catch (err) {}
  };

  const fetchGpaData = async () => {
    try {
      const res = await api.get('/gpa/me');
      setGpaData(res.data);
    } catch (err) {}
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
    <div className="space-y-8 p-4 lg:p-8 max-w-7xl mx-auto">
      {/* LinkedIn Style Profile Header */}
      <motion.div initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} className="relative bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
        {/* Cover Photo Area */}
        <div className="h-32 md:h-48 bg-gradient-to-r from-blue-600 via-indigo-600 to-purple-600 relative overflow-hidden">
           <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/cubes.png')] opacity-20"></div>
        </div>
        
        <div className="px-6 md:px-10 pb-6 relative">
          <div className="flex flex-col md:flex-row gap-6 items-start md:items-end -mt-16 md:-mt-20 mb-4">
            <div className="w-32 h-32 md:w-40 md:h-40 rounded-full border-4 border-white bg-slate-100 flex items-center justify-center shadow-lg relative overflow-hidden bg-white">
              {profile?.gender === 'Female' ? (
                 <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Felix&gender=female" alt="Avatar" className="w-full h-full object-cover"/>
              ) : (
                 <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Alex&gender=male" alt="Avatar" className="w-full h-full object-cover"/>
              )}
            </div>
            <div className="flex-1 pt-2 md:pt-0">
              <h1 className="text-3xl font-bold text-slate-900">{profile?.name || 'Student Name'}</h1>
              <p className="text-lg text-slate-600 font-medium">{profile?.department || 'Department'}</p>
              <p className="text-sm text-slate-500 flex items-center gap-2 mt-1">
                <GraduationCap className="w-4 h-4"/> Batch of {profile?.batch_year || '2025'} • {profile?.enrollment_number}
              </p>
            </div>
            <div className="flex gap-3 mt-4 md:mt-0 w-full md:w-auto">
              {gpaData && (
                <div className="bg-emerald-50 border border-emerald-100 px-6 py-3 rounded-xl text-center shadow-sm">
                  <p className="text-xs font-bold text-emerald-600 uppercase tracking-wider mb-1">Current CGPA</p>
                  <p className="text-3xl font-black text-emerald-700">{gpaData.cgpa.toFixed(2)}</p>
                </div>
              )}
            </div>
          </div>
        </div>
      </motion.div>

      <Tabs defaultValue="overview" className="w-full">
        <TabsList className="mb-6 grid w-full grid-cols-4 lg:w-[600px] bg-slate-100 p-1 rounded-lg">
          <TabsTrigger value="overview">Academic Overview</TabsTrigger>
          <TabsTrigger value="achievements">Achievements</TabsTrigger>
          <TabsTrigger value="career">Career & Portfolio</TabsTrigger>
          <TabsTrigger value="settings">Settings</TabsTrigger>
        </TabsList>

        <TabsContent value="overview">
          <motion.div variants={containerVariants} initial="hidden" animate="show" className="grid grid-cols-1 lg:grid-cols-3 gap-6">
            
            {/* Academic Health */}
            <div className="lg:col-span-2 space-y-6">
              <Card className="border-none shadow-sm">
                <CardHeader>
                  <CardTitle className="flex items-center gap-2"><TrendingUp className="w-5 h-5 text-indigo-500"/> Performance Metrics</CardTitle>
                </CardHeader>
                <CardContent>
                  <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
                    <div className="bg-slate-50 p-4 rounded-xl border border-slate-100">
                      <p className="text-sm text-slate-500 font-medium mb-1">Total Credits</p>
                      <p className="text-2xl font-bold text-slate-900">{gpaData?.total_credits_earned || 0}</p>
                    </div>
                    <div className="bg-rose-50 p-4 rounded-xl border border-rose-100">
                      <p className="text-sm text-rose-600 font-medium mb-1">Active Arrears</p>
                      <p className="text-2xl font-bold text-rose-700">{gpaData?.current_arrears || 0}</p>
                    </div>
                    <div className="bg-amber-50 p-4 rounded-xl border border-amber-100">
                      <p className="text-sm text-amber-600 font-medium mb-1">History of Arrears</p>
                      <p className="text-2xl font-bold text-amber-700">{gpaData?.history_of_arrears || 0}</p>
                    </div>
                    <div className="bg-indigo-50 p-4 rounded-xl border border-indigo-100">
                      <p className="text-sm text-indigo-600 font-medium mb-1">Classification</p>
                      <p className="text-lg font-bold text-indigo-700 mt-1">{gpaData?.classification || 'N/A'}</p>
                    </div>
                  </div>
                </CardContent>
              </Card>

              {/* Semester History */}
              <Card className="border-none shadow-sm">
                <CardHeader>
                  <CardTitle className="flex items-center gap-2"><BookOpen className="w-5 h-5 text-blue-500"/> Semester History</CardTitle>
                </CardHeader>
                <CardContent>
                  {gpaData?.semesters?.length > 0 ? (
                    <div className="space-y-4">
                      {gpaData.semesters.map((sem, i) => (
                        <div key={i} className="flex items-center justify-between p-4 rounded-lg bg-slate-50 border border-slate-100">
                          <div className="flex items-center gap-4">
                            <div className="w-10 h-10 rounded-full bg-blue-100 text-blue-700 flex items-center justify-center font-bold">
                              S{sem.semester}
                            </div>
                            <div>
                              <p className="font-semibold text-slate-800">Semester {sem.semester}</p>
                              <p className="text-xs text-slate-500">{sem.credits_earned} Credits Earned</p>
                            </div>
                          </div>
                          <div className="text-right">
                            <p className="text-xl font-bold text-slate-900">{sem.gpa.toFixed(2)}</p>
                            <p className="text-xs text-slate-500">GPA</p>
                          </div>
                        </div>
                      ))}
                    </div>
                  ) : (
                    <div className="text-center py-8 text-slate-500">No semester records available yet.</div>
                  )}
                </CardContent>
              </Card>
            </div>

            {/* Sidebar Stats */}
            <div className="space-y-6">
              <Card className="border-none shadow-sm bg-gradient-to-br from-indigo-900 to-slate-900 text-white">
                <CardHeader>
                  <CardTitle className="text-white flex items-center gap-2"><Target className="w-5 h-5 text-indigo-400"/> Success Score</CardTitle>
                  <CardDescription className="text-indigo-200">AI-calculated holistic performance metric</CardDescription>
                </CardHeader>
                <CardContent className="flex justify-center py-6">
                  <div className="relative w-32 h-32">
                    <svg className="w-full h-full" viewBox="0 0 36 36">
                      <path className="text-white/20" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" fill="none" stroke="currentColor" strokeWidth="3" />
                      <path className="text-emerald-400" strokeDasharray={`${timeline.filter(a => a.status === 'APPROVED').length * 10}, 100`} d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" fill="none" stroke="currentColor" strokeWidth="3" strokeLinecap="round" />
                    </svg>
                    <div className="absolute inset-0 flex items-center justify-center flex-col">
                      <span className="text-3xl font-bold text-white">{timeline.filter(a => a.status === 'APPROVED').length * 10 || 45}</span>
                      <span className="text-xs text-indigo-200">/ 100</span>
                    </div>
                  </div>
                </CardContent>
              </Card>

              <Card className="border-none shadow-sm">
                <CardHeader>
                  <CardTitle className="text-base flex items-center gap-2"><Award className="w-4 h-4 text-amber-500"/> Quick Summary</CardTitle>
                </CardHeader>
                <CardContent className="space-y-4">
                  <div className="flex justify-between items-center border-b border-slate-100 pb-2">
                    <span className="text-sm text-slate-500">Verified Achievements</span>
                    <span className="font-bold text-slate-800">{timeline.filter(a => a.status === 'APPROVED').length}</span>
                  </div>
                  <div className="flex justify-between items-center border-b border-slate-100 pb-2">
                    <span className="text-sm text-slate-500">Pending Approvals</span>
                    <span className="font-bold text-amber-600">{timeline.filter(a => a.status === 'PENDING').length}</span>
                  </div>
                </CardContent>
              </Card>
            </div>
          </motion.div>
        </TabsContent>

        <TabsContent value="achievements">
          <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <div className="lg:col-span-1">
              <AchievementUpload onUploadSuccess={fetchTimeline} />
            </div>
            <div className="lg:col-span-2">
              <Card className="border-none shadow-sm h-full">
                <CardHeader>
                  <CardTitle className="flex items-center gap-2"><Clock className="w-5 h-5 text-indigo-500"/> Verified Timeline</CardTitle>
                  <CardDescription>Your academic and extracurricular journey</CardDescription>
                </CardHeader>
                <CardContent>
                  <AchievementTimeline achievements={timeline} />
                </CardContent>
              </Card>
            </div>
          </div>
        </TabsContent>

        <TabsContent value="career">
          <CareerDashboard />
        </TabsContent>

        <TabsContent value="settings">
          <Card className="border-none shadow-sm max-w-3xl mx-auto">
            <CardHeader>
              <CardTitle>Profile Settings</CardTitle>
              <CardDescription>Update your personal information and preferences. Changes require mentor approval.</CardDescription>
            </CardHeader>
            <CardContent>
              <StudentProfileForm />
            </CardContent>
          </Card>
        </TabsContent>
      </Tabs>
    </div>
  );
}
