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

export async function uploadMenuFile(file: File): Promise<{taskId: string}> {
  const formData = new FormData();
  formData.append('file', file);

  const response = await fetch(`${API_BASE_URL}/restaurants/process_menu/`, {
    method: 'POST',
    body: formData,
  });

  if (!response.ok) {
    throw new Error(`Menu upload failed: ${response.statusText}`);
  }

  const data = await response.json();
  return { taskId: data.task_id };
}

export async function checkTaskStatus(taskId: string): Promise<{status: string, error?: string}> {
  const response = await fetch(`${API_BASE_URL}/tasks/${taskId}/`);
  if (!response.ok) {
    throw new Error('Failed to check task status');
  }
  return response.json();
}

export function debounce<T extends (...args: any[]) => any>(
  func: T,
  wait: number
): (...args: Parameters<T>) => void {
  let timeout: NodeJS.Timeout;
  return (...args: Parameters<T>) => {
    clearTimeout(timeout);
    timeout = setTimeout(() => func(...args), wait);
  };
} 