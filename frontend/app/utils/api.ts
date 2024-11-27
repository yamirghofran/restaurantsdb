const API_BASE_URL = 'http://localhost:8000/api';

export async function fetchFromApi<T>(
  endpoint: string,
  options: RequestInit = {}
): Promise<T> {
  const url = `${API_BASE_URL}${endpoint}`;
  const response = await fetch(url, {
    ...options,
    headers: {
      'Content-Type': 'application/json',
      ...options.headers,
    },
  });

  if (!response.ok) {
    throw new Error(`API call failed: ${response.statusText}`);
  }

  return response.json();
}

export async function uploadMenuFile(file: File): Promise<void> {
  const formData = new FormData();
  formData.append('file', file);

  const response = await fetch(`${API_BASE_URL}/restaurants/process_menu/`, {
    method: 'POST',
    body: formData,
  });

  if (!response.ok) {
    throw new Error(`Menu upload failed: ${response.statusText}`);
  }
} 