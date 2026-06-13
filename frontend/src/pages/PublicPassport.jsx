import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import api from '../api/axios';
import AchievementTimeline from '../components/AchievementTimeline';

export default function PublicPassport() {
  const { publicId } = useParams();
  const [profile, setProfile] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchProfile = async () => {
      try {
        const res = await api.get(`/public/${publicId}`);
        setProfile(res.data);
      } catch (err) {
        setError('Profile not found or access denied.');
      } finally {
        setLoading(false);
      }
    };
    fetchProfile();
  }, [publicId]);

  if (loading) return <div className="min-h-screen flex items-center justify-center bg-gray-50">Loading profile...</div>;
  if (error) return <div className="min-h-screen flex items-center justify-center bg-gray-50 text-red-600 font-bold text-xl">{error}</div>;

  return (
    <div className="min-h-screen bg-gray-50 py-12 px-4 sm:px-6 lg:px-8 font-sans">
      <div className="max-w-4xl mx-auto space-y-8">
        
        {/* Header */}
        <div className="bg-gradient-to-r from-indigo-600 to-purple-600 rounded-2xl shadow-xl overflow-hidden text-white">
          <div className="p-8 sm:p-12 text-center">
            <h1 className="text-4xl font-extrabold tracking-tight mb-2 text-white">
              Student Achievement Passport
            </h1>
            <p className="text-indigo-100 text-lg">Verified Digital Credentials</p>
          </div>
          <div className="bg-white text-gray-900 p-8 rounded-t-3xl -mt-6">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
                <div>
                    <h2 className="text-2xl font-bold text-gray-900">{profile.name}'s Profile</h2>
                    <p className="text-gray-500 mt-1">{profile.department}</p>
                    <p className="text-gray-500">Batch of {profile.academic_year}</p>
                </div>
                <div className="flex flex-col md:items-end justify-center">
                    <div className="bg-indigo-50 border border-indigo-100 rounded-xl p-4 text-center min-w-[150px]">
                        <p className="text-sm font-medium text-indigo-600 uppercase tracking-wide">Total Score</p>
                        <p className="text-4xl font-black text-indigo-900">{profile.total_score}</p>
                    </div>
                </div>
            </div>
          </div>
        </div>

        {/* Timeline */}
        <div className="bg-white rounded-2xl shadow-xl p-8 sm:p-12 border border-gray-100">
            <h3 className="text-2xl font-bold text-gray-900 mb-8 border-b pb-4">Verified Achievements</h3>
            {profile.achievements.length === 0 ? (
                <p className="text-gray-500 text-center py-8">No verified achievements yet.</p>
            ) : (
                <AchievementTimeline achievements={profile.achievements} />
            )}
        </div>

        {/* Footer */}
        <div className="text-center text-gray-400 text-sm">
            <p>Verified by StudentSphere Institutional Verification System.</p>
        </div>

      </div>
    </div>
  );
}
