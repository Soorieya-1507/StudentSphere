import React, { useState, useEffect } from 'react';
import api from '../api/axios';

export default function StudentProfileForm() {
  const [formData, setFormData] = useState({
    roll_number: '', linkedin_url: '', gender: '', accommodation: '',
    father_name: '', father_mobile: '', father_occupation: '',
    mother_name: '', mother_mobile: '', mother_occupation: '',
    family_income: '', year_of_joining: '', year_of_passing: '',
    tenth_percentage: '', twelfth_percentage: '', school_name: '',
    school_address: '', home_address: '', aadhaar_number: '',
    aadhaar_certificate_url: '', community_certificate_url: '',
    bank_passbook_url: '', tenth_marksheet_url: '', twelfth_marksheet_url: ''
  });

  const [files, setFiles] = useState({});

  useEffect(() => {
    api.get('/profiles/student/me')
      .then(res => { if (res.data) setFormData({...formData, ...res.data}); })
      .catch(console.error);
  }, []);

  const handleChange = (e) => setFormData({...formData, [e.target.name]: e.target.value});

  const handleFileChange = (e, fieldName) => {
    setFiles({...files, [fieldName]: e.target.files[0]});
  };

  const handleUpload = async (e, fieldName) => {
    e.preventDefault();
    if (!files[fieldName]) return;
    const data = new FormData();
    data.append('file', files[fieldName]);
    try {
      const res = await api.post('/uploads', data);
      setFormData({...formData, [fieldName]: res.data.url});
      alert('File uploaded!');
    } catch (err) { alert('Upload failed. Must be PNG/JPG.'); }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const payload = {...formData};
      if (!payload.aadhaar_number || payload.aadhaar_number.trim() === '') {
        delete payload.aadhaar_number;
      }
      await api.put('/profiles/student', payload);
      alert('Profile updated and submitted for approval!');
      window.location.reload(); 
    } catch (err) {
      const detail = err.response?.data?.detail;
      if (Array.isArray(detail)) {
        alert('Update failed: ' + detail.map(d => d.msg).join(', '));
      } else {
        alert('Update failed: ' + (detail || 'Check all fields and try again.'));
      }
    }
  };

  const renderUpload = (label, fieldName) => (
    <div className="flex items-center gap-2 border border-gray-200 p-3 rounded-lg bg-gray-50/80 hover:bg-gray-50 transition">
      <div className="flex-1">
        <label className="block text-xs font-bold text-gray-700">{label}</label>
        {formData[fieldName] ? (
          <a href={`http://localhost:8000${formData[fieldName]}`} target="_blank" rel="noreferrer" className="text-blue-600 text-sm hover:underline font-medium">View Uploaded</a>
        ) : <span className="text-gray-400 text-sm">Not uploaded</span>}
      </div>
      <input type="file" accept=".jpg,.jpeg,.png" onChange={e => handleFileChange(e, fieldName)} className="text-xs w-48 file:mr-4 file:py-1 file:px-3 file:rounded-full file:border-0 file:text-xs file:font-semibold file:bg-blue-50 file:text-blue-700 hover:file:bg-blue-100" />
      <button onClick={e => handleUpload(e, fieldName)} className="bg-blue-600 text-white px-3 py-1.5 rounded-full text-xs shadow hover:bg-blue-700 transition">Upload</button>
    </div>
  );

  return (
    <div className="bg-white/80 backdrop-blur-sm p-8 rounded-2xl shadow-xl max-w-4xl mx-auto mb-10 border border-gray-100">
      <h2 className="text-3xl font-extrabold mb-8 text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-cyan-600 text-center">Complete Your Profile</h2>
      
      <form onSubmit={handleSubmit} className="space-y-8">
        <section>
          <h3 className="text-xl font-bold border-b-2 border-blue-100 pb-2 mb-4 text-blue-800">Personal Details</h3>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
            <input name="roll_number" placeholder="Roll Number" value={formData.roll_number || ''} onChange={handleChange} className="border-gray-300 border p-3 rounded-lg w-full focus:ring-2 focus:ring-blue-500 outline-none" />
            <input name="linkedin_url" placeholder="LinkedIn URL" value={formData.linkedin_url || ''} onChange={handleChange} className="border-gray-300 border p-3 rounded-lg w-full focus:ring-2 focus:ring-blue-500 outline-none" />
            <select name="gender" value={formData.gender || ''} onChange={handleChange} className="border-gray-300 border p-3 rounded-lg w-full focus:ring-2 focus:ring-blue-500 outline-none">
              <option value="">-- Gender --</option><option value="Male">Male</option><option value="Female">Female</option>
            </select>
            <select name="accommodation" value={formData.accommodation || ''} onChange={handleChange} className="border-gray-300 border p-3 rounded-lg w-full focus:ring-2 focus:ring-blue-500 outline-none">
              <option value="">-- Accommodation --</option><option value="Hosteller">Hosteller</option><option value="Day Scholar">Day Scholar</option>
            </select>
            <div className="relative">
              <input
                name="aadhaar_number"
                placeholder="Aadhaar Number (12 digits, no spaces)"
                value={formData.aadhaar_number || ''}
                onChange={e => {
                  const val = e.target.value.replace(/\D/g, '').slice(0, 12);
                  setFormData({...formData, aadhaar_number: val});
                }}
                inputMode="numeric"
                maxLength={12}
                className="border-gray-300 border p-3 rounded-lg w-full focus:ring-2 focus:ring-blue-500 outline-none"
              />
              <span className={`absolute right-3 top-3 text-xs font-medium ${
                (formData.aadhaar_number || '').length === 12 ? 'text-green-600' : 'text-gray-400'
              }`}>{(formData.aadhaar_number || '').length}/12</span>
            </div>
          </div>
        </section>

        <section>
          <h3 className="text-xl font-bold border-b-2 border-blue-100 pb-2 mb-4 text-blue-800">Parent Details</h3>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-5">
            <input name="father_name" placeholder="Father Name" value={formData.father_name || ''} onChange={handleChange} className="border-gray-300 border p-3 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none" />
            <input name="father_mobile" placeholder="Father Mobile" value={formData.father_mobile || ''} onChange={handleChange} className="border-gray-300 border p-3 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none" />
            <input name="father_occupation" placeholder="Father Occupation" value={formData.father_occupation || ''} onChange={handleChange} className="border-gray-300 border p-3 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none" />
            
            <input name="mother_name" placeholder="Mother Name" value={formData.mother_name || ''} onChange={handleChange} className="border-gray-300 border p-3 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none" />
            <input name="mother_mobile" placeholder="Mother Mobile" value={formData.mother_mobile || ''} onChange={handleChange} className="border-gray-300 border p-3 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none" />
            <input name="mother_occupation" placeholder="Mother Occupation" value={formData.mother_occupation || ''} onChange={handleChange} className="border-gray-300 border p-3 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none" />
            
            <select name="family_income" value={formData.family_income || ''} onChange={handleChange} className="border-gray-300 border p-3 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none md:col-span-3">
              <option value="">-- Annual Family Income --</option>
              <option value="Below 2 Lakhs">Below 2 Lakhs</option>
              <option value="2-5 Lakhs">2-5 Lakhs</option>
              <option value="Above 5 Lakhs">Above 5 Lakhs</option>
            </select>
          </div>
        </section>

        <section>
          <h3 className="text-xl font-bold border-b-2 border-blue-100 pb-2 mb-4 text-blue-800">Academic Details</h3>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-5">
            <input type="number" name="year_of_joining" placeholder="Year of Joining" value={formData.year_of_joining || ''} onChange={handleChange} className="border-gray-300 border p-3 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none" />
            <input type="number" name="year_of_passing" placeholder="Year of Passing" value={formData.year_of_passing || ''} onChange={handleChange} className="border-gray-300 border p-3 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none" />
            <input name="tenth_percentage" placeholder="10th Percentage" value={formData.tenth_percentage || ''} onChange={handleChange} className="border-gray-300 border p-3 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none" />
            <input name="twelfth_percentage" placeholder="12th Percentage" value={formData.twelfth_percentage || ''} onChange={handleChange} className="border-gray-300 border p-3 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none" />
            <input name="school_name" placeholder="School Name" value={formData.school_name || ''} onChange={handleChange} className="border-gray-300 border p-3 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none md:col-span-2" />
            <textarea name="school_address" placeholder="School Address" value={formData.school_address || ''} onChange={handleChange} className="border-gray-300 border p-3 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none md:col-span-2"></textarea>
            <textarea name="home_address" placeholder="Home Address" value={formData.home_address || ''} onChange={handleChange} className="border-gray-300 border p-3 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none md:col-span-2"></textarea>
          </div>
        </section>

        <section>
          <h3 className="text-xl font-bold border-b-2 border-blue-100 pb-2 mb-4 text-blue-800">Document Uploads (PNG/JPG only)</h3>
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-5">
            {renderUpload('Aadhaar Certificate', 'aadhaar_certificate_url')}
            {renderUpload('Community Certificate', 'community_certificate_url')}
            {renderUpload('Bank Passbook', 'bank_passbook_url')}
            {renderUpload('10th Marksheet', 'tenth_marksheet_url')}
            {renderUpload('12th Marksheet', 'twelfth_marksheet_url')}
          </div>
        </section>

        <button type="submit" className="w-full bg-gradient-to-r from-blue-600 to-cyan-600 text-white py-4 rounded-xl shadow-lg hover:opacity-90 transition font-bold text-xl mt-4">
          Submit Profile for Approval
        </button>
      </form>
    </div>
  );
}
