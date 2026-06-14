import React, { useState } from 'react';
import axios from 'axios';
import { motion } from 'framer-motion';
import { useNavigate } from 'react-router-dom';
import { Card, CardContent, CardHeader, CardTitle, CardDescription } from '@/components/ui/card';
import { Search, Briefcase, TrendingUp, CheckCircle, ExternalLink } from 'lucide-react';
import { toast } from 'react-toastify';

export default function RecruiterPortal() {
  const [students, setStudents] = useState([]);
  const [skill, setSkill] = useState('');
  const [minCgpa, setMinCgpa] = useState('');
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  const handleSearch = async (e) => {
    e.preventDefault();
    setLoading(true);
    try {
      let url = 'http://localhost:8000/api/v1/recruiter/search?';
      if (skill) url += `skill=${skill}&`;
      if (minCgpa) url += `min_cgpa=${minCgpa}`;
      
      const res = await axios.get(url);
      setStudents(res.data);
      if (res.data.length > 0) {
        toast.success(`Found ${res.data.length} verified candidates.`);
      } else {
        toast.info("No candidates match your criteria.");
      }
    } catch (err) {
      toast.error('Search failed. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-slate-50 font-sans selection:bg-indigo-100 selection:text-indigo-900 pb-12">
      {/* Premium Hero Section */}
      <div className="bg-slate-900 text-white py-16 px-6 relative overflow-hidden mb-12">
        <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/cubes.png')] opacity-10"></div>
        <div className="absolute -top-40 -right-40 w-96 h-96 bg-indigo-500 rounded-full mix-blend-multiply filter blur-3xl opacity-30 animate-blob"></div>
        <div className="absolute -bottom-40 -left-40 w-96 h-96 bg-purple-500 rounded-full mix-blend-multiply filter blur-3xl opacity-30 animate-blob animation-delay-2000"></div>
        
        <div className="max-w-7xl mx-auto relative z-10 flex flex-col md:flex-row justify-between items-center gap-8">
          <div className="max-w-2xl">
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-white/10 border border-white/20 text-indigo-300 text-xs font-bold uppercase tracking-wider mb-6">
              <Briefcase className="w-4 h-4"/> Verified Industry Partner
            </div>
            <h1 className="text-4xl md:text-5xl font-extrabold tracking-tight mb-4">Discover Top Talent Instantly.</h1>
            <p className="text-lg text-slate-300 leading-relaxed">
              Access AI-verified student portfolios. Search by technical skills, academic performance, and readiness scores. Zero fraudulent claims, 100% institution-backed data.
            </p>
          </div>
        </div>
      </div>

      <div className="max-w-7xl mx-auto px-6">
        <Card className="shadow-lg border-none -mt-20 relative z-20 bg-white/90 backdrop-blur-xl mb-12">
          <CardHeader>
            <CardTitle className="text-xl">Talent Intelligence Search</CardTitle>
            <CardDescription>Filter candidates by strict criteria. PII is automatically hidden for privacy.</CardDescription>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleSearch} className="flex flex-col md:flex-row gap-4">
              <div className="relative flex-1">
                <Search className="absolute left-3 top-3 h-5 w-5 text-slate-400" />
                <input
                  type="text"
                  placeholder="Required Skills (e.g. React, Python, Data Science)"
                  className="w-full pl-10 pr-4 py-3 bg-slate-50 border border-slate-200 rounded-lg focus:ring-2 focus:ring-indigo-500 outline-none transition-all text-slate-800"
                  value={skill}
                  onChange={(e) => setSkill(e.target.value)}
                />
              </div>
              <div className="w-full md:w-64">
                <input
                  type="number"
                  placeholder="Min CGPA (e.g. 8.0)"
                  step="0.1"
                  className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-lg focus:ring-2 focus:ring-indigo-500 outline-none transition-all text-slate-800"
                  value={minCgpa}
                  onChange={(e) => setMinCgpa(e.target.value)}
                />
              </div>
              <button 
                type="submit" 
                disabled={loading}
                className="bg-indigo-600 hover:bg-indigo-700 text-white px-8 py-3 rounded-lg font-bold transition-all shadow-md flex items-center justify-center disabled:opacity-70"
              >
                {loading ? 'Searching...' : 'Find Candidates'}
              </button>
            </form>
          </CardContent>
        </Card>

        {/* Results Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {students.map((stu, i) => (
            <motion.div 
              initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: i * 0.1 }}
              key={i}
            >
              <Card className="h-full border-none shadow-md hover:shadow-xl transition-all duration-300 group overflow-hidden bg-white">
                <CardContent className="p-0">
                  <div className="p-6">
                    <div className="flex justify-between items-start mb-4">
                      <div>
                        <h3 className="text-xl font-bold text-slate-900 group-hover:text-indigo-600 transition-colors">{stu.name}</h3>
                        <p className="text-sm text-slate-500 mt-1 flex items-center gap-1"><CheckCircle className="w-4 h-4 text-emerald-500"/> Verified Profile</p>
                      </div>
                      <div className="bg-emerald-50 text-emerald-700 px-3 py-1 rounded-lg font-black text-lg border border-emerald-100">
                        {stu.cgpa.toFixed(2)}
                      </div>
                    </div>
                    
                    <div className="mt-6 mb-8">
                      <p className="text-xs font-bold text-slate-400 uppercase tracking-wider mb-2">Top Match Indicators</p>
                      <div className="flex items-center gap-2 text-sm text-slate-700 bg-slate-50 p-3 rounded-lg border border-slate-100">
                         <TrendingUp className="w-4 h-4 text-indigo-500"/> Strong Academic Trend
                      </div>
                    </div>
                  </div>
                  
                  <div className="px-6 py-4 bg-slate-50 border-t border-slate-100 group-hover:bg-indigo-50 transition-colors">
                    <button 
                      onClick={() => navigate(stu.public_url)}
                      className="w-full flex items-center justify-between text-indigo-700 font-bold"
                    >
                      View Digital Passport <ExternalLink className="w-4 h-4"/>
                    </button>
                  </div>
                </CardContent>
              </Card>
            </motion.div>
          ))}
          {students.length === 0 && !loading && (
            <div className="col-span-full text-center py-20 px-4">
              <div className="inline-flex items-center justify-center w-16 h-16 rounded-full bg-slate-100 mb-4">
                <Search className="w-8 h-8 text-slate-400" />
              </div>
              <h3 className="text-xl font-bold text-slate-700 mb-2">Ready to Discover Talent</h3>
              <p className="text-slate-500 max-w-md mx-auto">Enter your required skills and minimum CGPA above to search the institution's verified student database.</p>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
