import React from 'react';
import { QRCodeSVG } from 'qrcode.react';

export default function QRCodeDisplay({ publicId }) {
  if (!publicId) return null;

  const publicUrl = `${window.location.origin}/passport/${publicId}`;

  return (
    <div className="flex flex-col items-center bg-white p-6 rounded-lg shadow-md border border-gray-200">
      <h3 className="text-xl font-semibold mb-4 text-indigo-700">Student Achievement Passport</h3>
      <p className="text-sm text-gray-500 mb-4 text-center">Scan this QR code to view verified achievements publicly. Sensitive info is hidden.</p>
      
      <div className="bg-white p-4 border rounded-lg shadow-sm">
        <QRCodeSVG value={publicUrl} size={200} />
      </div>
      
      <div className="mt-4 w-full">
        <label className="block text-xs font-medium text-gray-500 mb-1">Public Shareable Link</label>
        <div className="flex">
          <input 
            type="text" 
            readOnly 
            value={publicUrl} 
            className="w-full bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-l-lg p-2"
          />
          <button 
            onClick={() => navigator.clipboard.writeText(publicUrl)}
            className="bg-indigo-600 text-white px-4 rounded-r-lg hover:bg-indigo-700 text-sm"
          >
            Copy
          </button>
        </div>
      </div>
    </div>
  );
}
