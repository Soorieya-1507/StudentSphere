import React, { useState, useEffect } from 'react';
import api from '../api/axios';

export default function FacultyProfileForm() {
  const [formData, setFormData] = useState({
    qualification: '', experience: '', research_papers_count: 0,
    research_areas: '', biography: '', profile_photo_url: ''
  });
  const [photo, setPhoto] = useState(null);

  useEffect(() => {
    api.get('/profiles/faculty/me')
      .then(res => { if (res.data) setFormData({...formData, ...res.data}); })
      .catch(console.error);
  }, []);

  const handleChange = (e) => setFormData({...formData, [e.target.name]: e.target.value});

  const handleUpload = async (e) => {
    e.preventDefault();
    if (!photo) return;
    const data = new FormData();
    data.append('file', photo);
    try {
      const res = await api.post('/uploads', data);
      setFormData({...formData, profile_photo_url: res.data.url});
      alert('Photo uploaded!');
    } catch (err) { alert('Upload failed'); }
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await api.put('/profiles/faculty', formData);
      alert('Profile updated successfully!');
    } catch (err) { alert('Update failed'); }
  };

  return (
    <div className="bg-white/80 backdrop-blur-sm p-8 rounded-xl shadow max-w-2xl mx-auto">
      <h2 className="text-2xl font-bold mb-6 text-gray-800">Edit Faculty Profile</h2>
      
      <div className="mb-6 pb-6 border-b border-gray-200">
        <h3 className="font-semibold mb-2">Profile Photo</h3>
        <div className="flex items-center gap-4">
          {formData.profile_photo_url && (
             <img src={formData.profile_photo_url.startsWith('http') ? formData.profile_photo_url : `http://localhost:8000${formData.profile_photo_url}`} alt="Profile" className="w-16 h-16 rounded-full object-cover shadow" />
          )}
          <input type="file" accept=".jpg,.jpeg,.png" onChange={e => setPhoto(e.target.files[0])} className="text-sm" />
          <button onClick={handleUpload} className="bg-blue-100 text-blue-700 px-3 py-1 rounded text-sm hover:bg-blue-200">Upload</button>
        </div>
      </div>

      <form onSubmit={handleSubmit} className="space-y-4">
        <div className="grid grid-cols-2 gap-4">
          <div>
            <label className="block text-sm text-gray-600 mb-1">Qualification</label>
            <input name="qualification" value={formData.qualification || ''} onChange={handleChange} className="w-full border p-2 rounded outline-none focus:ring-2 focus:ring-purple-500" />
          </div>
          <div>
            <label className="block text-sm text-gray-600 mb-1">Experience (Years)</label>
            <input type="number" name="experience" value={formData.experience || ''} onChange={handleChange} className="w-full border p-2 rounded outline-none focus:ring-2 focus:ring-purple-500" />
          </div>
        </div>
        
        <div className="grid grid-cols-2 gap-4">
          <div>
            <label className="block text-sm text-gray-600 mb-1">Research Papers</label>
            <input type="number" name="research_papers_count" value={formData.research_papers_count || 0} onChange={handleChange} className="w-full border p-2 rounded outline-none focus:ring-2 focus:ring-purple-500" />
          </div>
          <div>
            <label className="block text-sm text-gray-600 mb-1">Research Areas</label>
            <input name="research_areas" value={formData.research_areas || ''} onChange={handleChange} className="w-full border p-2 rounded outline-none focus:ring-2 focus:ring-purple-500" placeholder="e.g. AI, Data Science" />
          </div>
        </div>

        <div>
          <label className="block text-sm text-gray-600 mb-1">Biography</label>
          <textarea name="biography" rows="4" value={formData.biography || ''} onChange={handleChange} className="w-full border p-2 rounded outline-none focus:ring-2 focus:ring-purple-500"></textarea>
        </div>

        <button type="submit" className="w-full bg-purple-600 text-white py-3 rounded-lg shadow hover:bg-purple-700 transition font-bold text-lg mt-4">
          Save Profile
        </button>
      </form>
    </div>
  );
}
