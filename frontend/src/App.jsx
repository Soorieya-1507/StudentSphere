import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import Login from './pages/Login';
import AdminRegister from './pages/AdminRegister';
import FacultyRegister from './pages/FacultyRegister';
import StudentRegister from './pages/StudentRegister';
import Dashboard from './pages/Dashboard';
import PublicPassport from './pages/PublicPassport';
import CareerDashboard from './pages/CareerDashboard';
import PortfolioPage from './pages/PortfolioPage';
import RecruiterPortal from './pages/RecruiterPortal';
import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

function App() {
  return (
    <Router>
      <div className="min-h-screen bg-gray-50 text-gray-900 font-sans">
        <Routes>
          <Route path="/" element={<Navigate to="/login" replace />} />
          <Route path="/login" element={<Login />} />
          <Route path="/register/admin" element={<AdminRegister />} />
          <Route path="/register/faculty" element={<FacultyRegister />} />
          <Route path="/register/student" element={<StudentRegister />} />
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path="/passport/:publicId" element={<PublicPassport />} />
          <Route path="/career" element={<CareerDashboard />} />
          <Route path="/portfolio/:studentId" element={<PortfolioPage />} />
          <Route path="/recruiter" element={<RecruiterPortal />} />
        </Routes>
        <ToastContainer 
        position="top-right" 
        autoClose={10000} 
        hideProgressBar={false}
        newestOnTop={true}
        closeOnClick
        rtl={false}
        pauseOnFocusLoss
        draggable
        pauseOnHover
        theme="light"
        toastClassName="rounded-xl shadow-lg border border-slate-100"
      />
      </div>
    </Router>
  );
}

export default App;
