import React, { useState, useEffect } from 'react';
import { Bar, Doughnut, Line } from 'react-chartjs-2';
import {
  Chart as ChartJS, CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend, ArcElement, PointElement, LineElement
} from 'chart.js';
import api from '../api/axios';

ChartJS.register(CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend, ArcElement, PointElement, LineElement);

export default function IntelligenceDashboard() {
  const [iisData, setIisData] = useState(null);
  const [recommendations, setRecommendations] = useState([]);
  const [accreditationData, setAccreditationData] = useState(null);
  const [aiInsight, setAiInsight] = useState('');
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchIntelligenceData();
  }, []);

  const fetchIntelligenceData = async () => {
    try {
      setLoading(true);
      const [iisRes, accRes] = await Promise.all([
        api.get('/intelligence/iis'),
        api.get('/reports/accreditation/NAAC')
      ]);
      setIisData(iisRes.data);
      setAccreditationData(accRes.data);
      
      // Mocking recommendations for admin view based on IIS
      const recs = [];
      if (iisRes.data.academic_factor < 70) recs.push("Focus on Academic improvements across lower performing departments.");
      if (iisRes.data.placement_factor < 60) recs.push("Prioritize Placement Drives and Internship Mappings.");
      setRecommendations(recs);
    } catch (err) {
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const generateAIInsight = async () => {
    try {
      setAiInsight("Generating AI insight via Llama3.2...");
      const res = await api.post('/reports/generate-ai-insight?report_type=NAAC');
      setAiInsight(res.data.insight);
    } catch (err) {
      setAiInsight("Failed to connect to AI engine.");
    }
  };

  const handleDownloadPDF = async () => {
    try {
      const response = await api.get('/reports/export/pdf', { responseType: 'blob' });
      const url = window.URL.createObjectURL(new Blob([response.data]));
      const link = document.createElement('a');
      link.href = url;
      link.setAttribute('download', 'executive_report.pdf');
      document.body.appendChild(link);
      link.click();
    } catch (err) { console.error("PDF Download failed"); }
  };

  if (loading) return <div className="p-6 text-center text-gray-500">Loading Intelligence Engine...</div>;

  const iisChartData = {
    labels: ['Academic Factor (DHI)', 'Placement Factor (PRI)'],
    datasets: [{
      data: [iisData?.academic_factor || 0, iisData?.placement_factor || 0],
      backgroundColor: ['#4F46E5', '#10B981'],
      borderWidth: 0,
    }]
  };

  return (
    <div className="space-y-6">
      {/* Master IIS Score */}
      <div className="bg-gradient-to-r from-indigo-600 to-purple-600 rounded-2xl p-8 text-white shadow-xl flex items-center justify-between">
        <div>
          <h2 className="text-3xl font-bold mb-2">Institution Intelligence Score (IIS)</h2>
          <p className="text-indigo-100 text-lg">Master Metric for SIH Innovation Layer</p>
        </div>
        <div className="text-right">
          <div className="text-6xl font-extrabold">{iisData?.score || 0}</div>
          <div className="text-xl mt-2 font-medium bg-white/20 inline-block px-4 py-1 rounded-full uppercase tracking-wider">
            {iisData?.category || 'Emerging'}
          </div>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {/* Chart View */}
        <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100">
          <h3 className="text-xl font-semibold mb-4 text-gray-800">IIS Breakdown</h3>
          <div className="h-64 flex justify-center">
            <Doughnut data={iisChartData} options={{ maintainAspectRatio: false }} />
          </div>
        </div>

        {/* Smart Recommendations */}
        <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100">
          <h3 className="text-xl font-semibold mb-4 text-gray-800">Strategic Recommendations</h3>
          {recommendations.length > 0 ? (
            <ul className="space-y-3">
              {recommendations.map((rec, i) => (
                <li key={i} className="flex items-start text-gray-700 bg-amber-50 p-3 rounded-lg border border-amber-100">
                  <span className="text-amber-500 mr-2">⚡</span>
                  {rec}
                </li>
              ))}
            </ul>
          ) : (
            <p className="text-gray-500">No immediate critical recommendations. Metrics are healthy.</p>
          )}
        </div>
      </div>

      {/* Accreditation Data Hub & AI Reports */}
      <div className="bg-white p-6 rounded-xl shadow-sm border border-gray-100">
        <div className="flex justify-between items-center mb-6">
          <h3 className="text-2xl font-bold text-gray-800">Executive Report Center & AI Hub</h3>
          <div className="space-x-3">
            <button onClick={handleDownloadPDF} className="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded-lg font-medium transition-colors">
              Download PDF Report
            </button>
            <button onClick={generateAIInsight} className="bg-gradient-to-r from-pink-500 to-rose-500 hover:from-pink-600 hover:to-rose-600 text-white px-4 py-2 rounded-lg font-medium transition-colors shadow-md">
              Generate AI Insight (Ollama)
            </button>
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
          <div className="bg-gray-50 p-4 rounded-lg border border-gray-200">
            <p className="text-sm text-gray-500">Student Strength</p>
            <p className="text-2xl font-semibold text-gray-900">{accreditationData?.student_strength || 0}</p>
          </div>
          <div className="bg-gray-50 p-4 rounded-lg border border-gray-200">
            <p className="text-sm text-gray-500">Faculty Strength</p>
            <p className="text-2xl font-semibold text-gray-900">{accreditationData?.faculty_strength || 0}</p>
          </div>
          <div className="bg-gray-50 p-4 rounded-lg border border-gray-200">
            <p className="text-sm text-gray-500">Total Publications/Internships</p>
            <p className="text-2xl font-semibold text-gray-900">
              {accreditationData?.publications || 0} / {accreditationData?.internships || 0}
            </p>
          </div>
        </div>

        {aiInsight && (
          <div className="mt-6 p-5 bg-gradient-to-br from-indigo-50 to-purple-50 rounded-xl border border-indigo-100">
            <h4 className="text-indigo-800 font-bold mb-2 flex items-center">
              <span className="mr-2">🤖</span> Llama 3.2 Strategic Insight
            </h4>
            <p className="text-gray-700 leading-relaxed whitespace-pre-wrap">{aiInsight}</p>
          </div>
        )}
      </div>
    </div>
  );
}
