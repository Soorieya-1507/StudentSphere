import React, { useState, useEffect } from 'react';
import api from '../api/axios';

export default function AchievementUpload({ onSuccess }) {
  const [categories, setCategories] = useState([]);
  const [formData, setFormData] = useState({
    title: '', category_id: '', description: '', organization_name: '', start_date: '', end_date: '',
    academic_year: 2024, semester: 1
  });
  const [file, setFile] = useState(null);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    api.get('/achievements/categories').then(res => setCategories(res.data)).catch(console.error);
  }, []);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    try {
      // Create achievement
      await api.post('/achievements/', formData);
      // We are mocking file upload for now, ideally we would upload the file to S3/Cloudinary and get a URL to pass to the achievement creation.
      alert('Achievement submitted for validation!');
      if(onSuccess) onSuccess();
    } catch (err) {
      setError(err.response?.data?.detail || 'Failed to submit achievement');
    } finally {
      setLoading(false);
    }
  };

  const handleChange = (e) => setFormData({...formData, [e.target.name]: e.target.value});

  return (
    <div className="bg-white p-6 rounded-lg shadow-md border border-gray-200">
      <h3 className="text-xl font-semibold mb-4 text-indigo-700">Upload New Achievement</h3>
      {error && <p className="text-red-500 mb-3">{error}</p>}
      <form onSubmit={handleSubmit} className="space-y-4">
        <div className="grid grid-cols-2 gap-4">
            <div>
            <label className="block text-sm font-medium">Category</label>
            <select name="category_id" required className="w-full border rounded p-2" onChange={handleChange}>
                <option value="">Select Category</option>
                {categories.map(c => <option key={c.id} value={c.id}>{c.name}</option>)}
            </select>
            </div>
            <div>
            <label className="block text-sm font-medium">Title</label>
            <input name="title" required className="w-full border rounded p-2" onChange={handleChange} />
            </div>
        </div>
        
        <div>
          <label className="block text-sm font-medium">Organization / Issuer</label>
          <input name="organization_name" required className="w-full border rounded p-2" onChange={handleChange} />
        </div>

        <div>
          <label className="block text-sm font-medium">Description</label>
          <textarea name="description" className="w-full border rounded p-2" rows="3" onChange={handleChange}></textarea>
        </div>

        <div className="grid grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium">Start Date</label>
              <input type="date" name="start_date" className="w-full border rounded p-2" onChange={handleChange} />
            </div>
            <div>
              <label className="block text-sm font-medium">End Date</label>
              <input type="date" name="end_date" className="w-full border rounded p-2" onChange={handleChange} />
            </div>
        </div>
        
        <div>
          <label className="block text-sm font-medium">Upload Certificate/Document (Max 5MB)</label>
          <input type="file" accept=".png,.jpg,.jpeg,.pdf" className="w-full border rounded p-2" onChange={e => setFile(e.target.files[0])} required />
          <p className="text-xs text-gray-500 mt-1">This will be verified by the AI Validation Engine.</p>
        </div>

        <button type="submit" disabled={loading} className="bg-indigo-600 text-white px-4 py-2 rounded hover:bg-indigo-700">
          {loading ? 'Submitting...' : 'Submit to Vault'}
        </button>
      </form>
    </div>
  );
}
