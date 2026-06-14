import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion, AnimatePresence } from 'framer-motion';
import { toast } from 'react-toastify';
import api from '../api/axios';

export default function Login() {
  const navigate = useNavigate();
  const [role, setRole] = useState('STUDENT');
  const [formData, setFormData] = useState({ email: '', password: '' });
  const [loading, setLoading] = useState(false);

  const roles = [
    { id: 'STUDENT', label: 'Student' },
    { id: 'FACULTY', label: 'Faculty' },
    { id: 'ADMIN', label: 'Workspace Admin' },
  ];

  const handleLogin = async (e) => {
    e.preventDefault();
    setLoading(true);
    try {
      const res = await api.post('/auth/login', formData);
      localStorage.setItem('token', res.data.access_token);
      localStorage.setItem('role', res.data.role);
      
      const payloadBase64 = res.data.access_token.split('.')[1];
      const decodedJson = atob(payloadBase64);
      const decoded = JSON.parse(decodedJson);
      localStorage.setItem('user_id', decoded.id);

      toast.success(`Welcome back, ${res.data.role.toLowerCase()}!`);
      
      // Navigate to respective dashboard
      if (res.data.role === 'ADMIN') navigate('/admin');
      else if (res.data.role === 'FACULTY' || res.data.role === 'HOD' || res.data.role === 'MENTOR') navigate('/faculty');
      else navigate('/student');
      
    } catch (err) {
      toast.error(err.response?.data?.detail || 'Invalid credentials');
    } finally {
      setLoading(false);
    }
  };

  const handleRegisterRedirect = () => {
    if (role === 'ADMIN') navigate('/register/admin');
    else if (role === 'FACULTY') navigate('/register/faculty');
    else navigate('/register/student');
  };

  const pageVariants = {
    initial: { opacity: 0, y: 20 },
    in: { opacity: 1, y: 0, transition: { duration: 0.6, ease: 'easeOut' } },
    out: { opacity: 0, y: -20, transition: { duration: 0.4 } }
  };

  return (
    <div className="min-h-screen bg-slate-50 flex overflow-hidden relative selection:bg-blue-100 selection:text-blue-900">
      {/* Animated Background Elements */}
      <motion.div 
        animate={{ rotate: 360 }} 
        transition={{ duration: 150, repeat: Infinity, ease: "linear" }}
        className="absolute -top-[40%] -right-[10%] w-[80%] h-[80%] rounded-full bg-gradient-to-br from-blue-100/40 to-purple-100/40 blur-3xl -z-10"
      />
      <motion.div 
        animate={{ rotate: -360 }} 
        transition={{ duration: 120, repeat: Infinity, ease: "linear" }}
        className="absolute -bottom-[30%] -left-[10%] w-[60%] h-[60%] rounded-full bg-gradient-to-tr from-emerald-50/40 to-cyan-100/40 blur-3xl -z-10"
      />

      <div className="flex-1 flex flex-col justify-center items-center p-6 lg:p-12 z-10">
        <motion.div 
          initial="initial" animate="in" exit="out" variants={pageVariants}
          className="w-full max-w-md bg-white/70 backdrop-blur-xl rounded-2xl shadow-2xl shadow-blue-900/5 border border-white/50 p-8 sm:p-10"
        >
          {/* Logo & Header */}
          <div className="text-center mb-8">
            <motion.div 
              initial={{ scale: 0.8, opacity: 0 }} 
              animate={{ scale: 1, opacity: 1 }} 
              transition={{ delay: 0.2 }}
              className="inline-flex items-center justify-center w-14 h-14 rounded-xl bg-gradient-to-br from-blue-600 to-indigo-700 shadow-lg mb-4"
            >
              <svg className="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 14l9-5-9-5-9 5 9 5z"></path><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 14l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14z"></path></svg>
            </motion.div>
            <h1 className="text-2xl font-bold text-slate-900 tracking-tight">StudentSphere Workspace</h1>
            <p className="text-sm text-slate-500 mt-2">Sign in to your institution's intelligence platform</p>
          </div>

          {/* Role Tabs */}
          <div className="flex p-1 bg-slate-100 rounded-lg mb-8 relative">
            {roles.map((r) => (
              <button
                key={r.id}
                onClick={() => setRole(r.id)}
                className={`flex-1 py-2 text-sm font-semibold rounded-md transition-all z-10 ${
                  role === r.id ? 'text-blue-700' : 'text-slate-500 hover:text-slate-700'
                }`}
              >
                {r.label}
              </button>
            ))}
            {/* Sliding Indicator */}
            <motion.div
              className="absolute top-1 bottom-1 bg-white rounded-md shadow-sm border border-slate-200"
              layoutId="roleTab"
              initial={false}
              animate={{
                width: `${100 / roles.length}%`,
                x: `${roles.findIndex(r => r.id === role) * 100}%`
              }}
              transition={{ type: "spring", stiffness: 300, damping: 30 }}
            />
          </div>

          {/* Login Form */}
          <form onSubmit={handleLogin} className="space-y-5">
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-1">Workspace Email</label>
              <input 
                type="email" 
                required 
                className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-lg focus:ring-2 focus:ring-blue-500/20 focus:border-blue-600 outline-none transition-all placeholder:text-slate-400 text-slate-900"
                placeholder={role === 'STUDENT' ? 'student@institution.edu' : role === 'FACULTY' ? 'faculty@institution.edu' : 'admin@institution.edu'}
                value={formData.email}
                onChange={(e) => setFormData({...formData, email: e.target.value})}
              />
            </div>
            <div>
              <div className="flex justify-between items-center mb-1">
                <label className="block text-sm font-medium text-slate-700">Password</label>
                <a href="#" className="text-xs font-semibold text-blue-600 hover:text-blue-700 transition">Forgot password?</a>
              </div>
              <input 
                type="password" 
                required 
                className="w-full px-4 py-3 bg-slate-50 border border-slate-200 rounded-lg focus:ring-2 focus:ring-blue-500/20 focus:border-blue-600 outline-none transition-all placeholder:text-slate-400 text-slate-900"
                placeholder="••••••••"
                value={formData.password}
                onChange={(e) => setFormData({...formData, password: e.target.value})}
              />
            </div>

            <div className="flex items-center">
              <input type="checkbox" id="remember" className="w-4 h-4 text-blue-600 border-slate-300 rounded focus:ring-blue-500" />
              <label htmlFor="remember" className="ml-2 block text-sm text-slate-600">Remember me for 30 days</label>
            </div>

            <motion.button 
              whileHover={{ scale: 1.01 }}
              whileTap={{ scale: 0.99 }}
              type="submit" 
              disabled={loading}
              className="w-full bg-slate-900 hover:bg-slate-800 text-white font-semibold py-3 rounded-lg shadow-md transition-all flex items-center justify-center disabled:opacity-70 disabled:cursor-not-allowed"
            >
              {loading ? (
                <svg className="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle><path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>
              ) : 'Sign In to Workspace'}
            </motion.button>
          </form>

          <p className="mt-8 text-center text-sm text-slate-500">
            Is your institution new to StudentSphere?{' '}
            <button onClick={handleRegisterRedirect} className="font-semibold text-blue-600 hover:text-blue-800 transition">
              Create an account
            </button>
          </p>
        </motion.div>
      </div>
      
      {/* Visual Side Panel for Desktop */}
      <div className="hidden lg:flex flex-1 bg-slate-900 relative items-center justify-center overflow-hidden">
        <div className="absolute inset-0 bg-gradient-to-br from-blue-900 to-slate-900 opacity-90 mix-blend-multiply" />
        <div className="absolute inset-0 bg-[url('https://www.transparenttextures.com/patterns/cubes.png')] opacity-10" />
        
        <div className="relative z-10 max-w-lg px-12">
          <motion.div initial={{ opacity: 0, x: 20 }} animate={{ opacity: 1, x: 0 }} transition={{ delay: 0.3, duration: 0.8 }}>
            <h2 className="text-4xl font-bold text-white mb-6 leading-tight">
              Institutional Intelligence,<br/><span className="text-blue-400">Perfected.</span>
            </h2>
            <p className="text-slate-300 text-lg leading-relaxed mb-8">
              Track student lifecycles from admission to placement. Measure academic growth, verify achievements automatically, and predict success with AI-driven analytics.
            </p>
            
            <div className="grid grid-cols-2 gap-6">
              <div className="bg-white/10 backdrop-blur-md rounded-xl p-5 border border-white/10">
                <div className="text-blue-400 font-bold text-2xl mb-1">98%</div>
                <div className="text-slate-300 text-sm">Placement Readiness Accuracy</div>
              </div>
              <div className="bg-white/10 backdrop-blur-md rounded-xl p-5 border border-white/10">
                <div className="text-emerald-400 font-bold text-2xl mb-1">Zero</div>
                <div className="text-slate-300 text-sm">Fraudulent Certificates</div>
              </div>
            </div>
          </motion.div>
        </div>
      </div>
    </div>
  );
}
