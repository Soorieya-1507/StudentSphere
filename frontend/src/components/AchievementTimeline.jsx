import React from 'react';

export default function AchievementTimeline({ achievements }) {
  const approvedAchievements = achievements.filter(a => a.status === 'APPROVED');
  
  if (approvedAchievements.length === 0) {
    return <p className="text-gray-500 italic">No approved achievements to show on the timeline yet.</p>;
  }

  return (
    <div className="relative border-l border-indigo-200 ml-3">
      {approvedAchievements.map((ach, index) => (
        <div key={ach.id} className="mb-6 ml-6">
          <span className="absolute flex items-center justify-center w-6 h-6 bg-indigo-100 rounded-full -left-3 ring-8 ring-white">
            <svg className="w-3 h-3 text-indigo-600" fill="currentColor" viewBox="0 0 20 20">
              <path fillRule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clipRule="evenodd"></path>
            </svg>
          </span>
          <h3 className="flex items-center mb-1 text-lg font-semibold text-gray-900">{ach.title} <span className="bg-indigo-100 text-indigo-800 text-sm font-medium mr-2 px-2.5 py-0.5 rounded ml-3">+{ach.points_awarded} pts</span></h3>
          <time className="block mb-2 text-sm font-normal leading-none text-gray-400">
            {ach.organization_name} • Semester {ach.semester || 'N/A'} • {new Date(ach.created_at).toLocaleDateString()}
          </time>
          <p className="text-base font-normal text-gray-500">{ach.description}</p>
        </div>
      ))}
    </div>
  );
}
