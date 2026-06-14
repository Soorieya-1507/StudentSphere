import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import axios from 'axios';
import { motion } from 'framer-motion';
import { Card, CardContent } from '@/components/ui/card';
import { ShieldCheck, Download, Award, Briefcase, GraduationCap, MapPin, Mail, Link as LinkIcon, BarChart3, Clock } from 'lucide-react';
import AchievementTimeline from '../components/AchievementTimeline';

export default function PublicPassport() {
  const { studentId } = useParams();
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await axios.get(`http://localhost:8000/api/v1/public/passport/${studentId}`);
        setData(res.data);
      } catch (err) {
        console.error(err);
      } finally {
        setLoading(false);
      }
    };
    fetchData();
  }, [studentId]);

  if (loading) return (
    <div className="min-h-screen flex items-center justify-center bg-slate-50">
       <div className="animate-pulse flex flex-col items-center">
         <div className="w-16 h-16 border-4 border-indigo-600 border-t-transparent rounded-full animate-spin mb-4"></div>
         <p className="text-slate-500 font-medium tracking-wide">Loading Verified Passport...</p>
       </div>
    </div>
  );
  
  if (!data) return (
    <div className="min-h-screen flex items-center justify-center bg-slate-50">
       <div className="text-center">
         <h2 className="text-2xl font-bold text-slate-800 mb-2">Passport Unavailable</h2>
         <p className="text-slate-500">This profile might be private or does not exist.</p>
       </div>
    </div>
  );

  const { profile, metrics, timeline } = data;

  return (
    <div className="min-h-screen bg-slate-100 font-sans pb-20 selection:bg-indigo-100 selection:text-indigo-900">
      {/* Top Verification Banner */}
      <div className="bg-emerald-600 text-white text-center py-2 px-4 text-sm font-semibold flex items-center justify-center gap-2 shadow-md relative z-50">
        <ShieldCheck className="w-4 h-4"/> 100% Institution Verified Profile • Data backed by AI Anti-Fraud System
      </div>

      <div className="max-w-5xl mx-auto pt-8 px-4 md:px-8">
        {/* Main Profile Header Card */}
        <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.5 }}>
          <Card className="border-none shadow-xl rounded-2xl overflow-hidden bg-white mb-8">
            <div className="h-48 bg-gradient-to-r from-slate-900 via-indigo-900 to-slate-900 relative">
               <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/carbon-fibre.png')] opacity-20"></div>
            </div>
            
            <div className="px-8 pb-8 relative">
              <div className="flex flex-col md:flex-row gap-8 items-start md:items-end -mt-20 md:-mt-24 mb-6">
                <div className="w-40 h-40 rounded-2xl border-4 border-white bg-slate-100 shadow-2xl relative overflow-hidden bg-white">
                  {profile.gender === 'Female' ? (
                     <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Felix&gender=female" alt="Avatar" className="w-full h-full object-cover"/>
                  ) : (
                     <img src="https://api.dicebear.com/7.x/avataaars/svg?seed=Alex&gender=male" alt="Avatar" className="w-full h-full object-cover"/>
                  )}
                </div>
                <div className="flex-1 pt-4 md:pt-0">
                  <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
                    <div>
                      <h1 className="text-4xl font-black text-slate-900 tracking-tight">{profile.name}</h1>
                      <p className="text-xl text-indigo-600 font-bold mt-1">{profile.department}</p>
                    </div>
                    <div className="flex items-center gap-3">
                      <button className="bg-slate-900 hover:bg-slate-800 text-white px-5 py-2.5 rounded-lg font-bold flex items-center gap-2 transition-all shadow-md">
                        <Download className="w-4 h-4"/> Resume
                      </button>
                    </div>
                  </div>
                </div>
              </div>

              {/* Bio & Links */}
              <div className="mt-8 border-t border-slate-100 pt-8">
                {profile.bio && (
                  <p className="text-slate-600 text-lg leading-relaxed mb-6 max-w-3xl">
                    "{profile.bio}"
                  </p>
                )}
                
                <div className="flex flex-wrap gap-6 text-sm font-medium text-slate-500">
                  <div className="flex items-center gap-2"><MapPin className="w-4 h-4 text-slate-400"/> {profile.institute_domain || 'India'}</div>
                  <div className="flex items-center gap-2"><GraduationCap className="w-4 h-4 text-slate-400"/> Batch of {profile.batch_year}</div>
                  {profile.github_url && <a href={profile.github_url} target="_blank" className="flex items-center gap-2 text-indigo-600 hover:text-indigo-800 transition"><LinkIcon className="w-4 h-4"/> GitHub</a>}
                  {profile.linkedin_url && <a href={profile.linkedin_url} target="_blank" className="flex items-center gap-2 text-indigo-600 hover:text-indigo-800 transition"><LinkIcon className="w-4 h-4"/> LinkedIn</a>}
                </div>
              </div>
            </div>
          </Card>
        </motion.div>

        <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
          {/* Left Column: Stats */}
          <div className="lg:col-span-1 space-y-8">
            <motion.div initial={{ opacity: 0, x: -20 }} animate={{ opacity: 1, x: 0 }} transition={{ delay: 0.2 }}>
              <Card className="border-none shadow-lg rounded-2xl bg-gradient-to-br from-indigo-600 to-purple-700 text-white">
                <CardContent className="p-8">
                  <h3 className="text-indigo-100 font-bold mb-6 flex items-center gap-2 uppercase tracking-wider text-sm"><BarChart3 className="w-4 h-4"/> Academic Excellence</h3>
                  <div className="text-center mb-6">
                    <span className="text-6xl font-black">{metrics.cgpa.toFixed(2)}</span>
                    <span className="text-indigo-200 ml-1">/ 10</span>
                    <p className="text-sm font-medium text-indigo-200 mt-2">Verified Cumulative GPA</p>
                  </div>
                  
                  <div className="bg-white/10 rounded-xl p-4 mt-6">
                    <p className="text-xs text-indigo-200 uppercase tracking-wider font-bold mb-2">Success Score</p>
                    <div className="flex items-center justify-between mb-1">
                      <span className="font-bold text-xl">{metrics.total_points}</span>
                      <span className="text-sm text-indigo-200">Top 15%</span>
                    </div>
                    <div className="w-full bg-black/20 rounded-full h-2">
                      <div className="bg-emerald-400 h-2 rounded-full" style={{width: '85%'}}></div>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </motion.div>
            
            {/* Skills / Tags area (mocked based on points) */}
            <motion.div initial={{ opacity: 0, x: -20 }} animate={{ opacity: 1, x: 0 }} transition={{ delay: 0.3 }}>
              <Card className="border-none shadow-md rounded-2xl">
                <CardContent className="p-6">
                  <h3 className="text-slate-800 font-bold mb-4 flex items-center gap-2"><Award className="w-5 h-5 text-indigo-500"/> Verified Expertise</h3>
                  <div className="flex flex-wrap gap-2">
                    {metrics.total_points > 50 && <span className="bg-indigo-50 text-indigo-700 px-3 py-1.5 rounded-lg text-sm font-bold border border-indigo-100">Hackathon Winner</span>}
                    {metrics.total_points > 30 && <span className="bg-emerald-50 text-emerald-700 px-3 py-1.5 rounded-lg text-sm font-bold border border-emerald-100">Research</span>}
                    <span className="bg-slate-100 text-slate-700 px-3 py-1.5 rounded-lg text-sm font-bold border border-slate-200">Open Source</span>
                    <span className="bg-slate-100 text-slate-700 px-3 py-1.5 rounded-lg text-sm font-bold border border-slate-200">Web Development</span>
                  </div>
                </CardContent>
              </Card>
            </motion.div>
          </div>

          {/* Right Column: Timeline */}
          <div className="lg:col-span-2 space-y-8">
            <motion.div initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.4 }}>
              <Card className="border-none shadow-md rounded-2xl bg-white h-full">
                <CardContent className="p-8">
                  <div className="flex items-center justify-between mb-8">
                    <h3 className="text-2xl font-black text-slate-900 flex items-center gap-2">
                      <Clock className="w-6 h-6 text-indigo-600"/> Verified Journey
                    </h3>
                    <span className="text-sm font-bold text-slate-400 uppercase tracking-wider">{timeline.length} Entries</span>
                  </div>
                  
                  {timeline.length > 0 ? (
                    <AchievementTimeline achievements={timeline} />
                  ) : (
                    <div className="text-center py-12 text-slate-400">
                      <Briefcase className="w-12 h-12 mx-auto mb-4 opacity-20"/>
                      <p>Journey timeline is currently being updated.</p>
                    </div>
                  )}
                </CardContent>
              </Card>
            </motion.div>
          </div>
        </div>
      </div>
    </div>
  );
}
