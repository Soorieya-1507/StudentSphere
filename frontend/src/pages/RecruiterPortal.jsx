import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { toast } from 'react-toastify';
import { useNavigate } from 'react-router-dom';

const RecruiterPortal = () => {
  const [students, setStudents] = useState([]);
  const [skill, setSkill] = useState('');
  const [minCgpa, setMinCgpa] = useState('');
  const navigate = useNavigate();

  const handleSearch = async (e) => {
    e.preventDefault();
    try {
      let url = 'http://localhost:8000/api/v1/recruiter/search?';
      if (skill) url += `skill=${skill}&`;
      if (minCgpa) url += `min_cgpa=${minCgpa}`;
      
      const res = await axios.get(url);
      setStudents(res.data);
      toast.success(`Found ${res.data.length} candidates matching your criteria.`);
    } catch (err) {
      toast.error('Failed to search candidates');
    }
  };

  return (
    <div className="p-8 max-w-7xl mx-auto">
      <div className="flex justify-between items-center mb-8">
        <h1 className="text-3xl font-bold text-gray-800">Recruiter Portal</h1>
        <div className="bg-indigo-100 text-indigo-800 px-4 py-2 rounded-full font-semibold">
          Verified Industry Partner
        </div>
      </div>

      <div className="bg-white p-6 rounded-lg shadow-sm border border-gray-100 mb-8">
        <h2 className="text-xl font-semibold mb-4 text-gray-700">Find Top Talent</h2>
        <form onSubmit={handleSearch} className="flex gap-4">
          <input
            type="text"
            placeholder="Required Skills (e.g., React, Python)"
            className="flex-1 p-3 border border-gray-300 rounded-md focus:ring-2 focus:ring-indigo-500"
            value={skill}
            onChange={(e) => setSkill(e.target.value)}
          />
          <input
            type="number"
            placeholder="Minimum CGPA"
            step="0.1"
            className="w-48 p-3 border border-gray-300 rounded-md focus:ring-2 focus:ring-indigo-500"
            value={minCgpa}
            onChange={(e) => setMinCgpa(e.target.value)}
          />
          <button type="submit" className="bg-indigo-600 text-white px-6 py-3 rounded-md font-semibold hover:bg-indigo-700 transition">
            Search
          </button>
        </form>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {students.map((stu, i) => (
          <div key={i} className="bg-white p-6 rounded-lg shadow-sm border border-gray-100 flex flex-col justify-between">
            <div>
              <div className="flex justify-between items-start mb-4">
                <h3 className="text-xl font-bold text-gray-800">{stu.name}</h3>
                <span className="bg-green-100 text-green-800 text-xs px-2 py-1 rounded font-bold">
                  CGPA {stu.cgpa.toFixed(2)}
                </span>
              </div>
              <p className="text-gray-500 text-sm mb-6">Verified Student Profile</p>
            </div>
            <button 
              onClick={() => navigate(stu.public_url)}
              className="w-full bg-gray-900 text-white py-2 rounded font-medium hover:bg-gray-800 transition"
            >
              View Full Portfolio
            </button>
          </div>
        ))}
        {students.length === 0 && (
          <div className="col-span-full text-center py-12 text-gray-500">
            No candidates searched yet or no results found.
          </div>
        )}
      </div>
    </div>
  );
};

export default RecruiterPortal;
