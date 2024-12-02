export function UploadStatus({ status, error }: { status: string, error?: string }) {
  if (status === 'uploading') {
    return <div>Processing menu... This may take a few minutes.</div>;
  }
  
  if (status === 'error') {
    return <div className="text-red-500">Upload failed: {error}</div>;
  }
  
  if (status === 'success') {
    return <div className="text-green-500">Menu processed successfully!</div>;
  }
  
  return null;
} 