import fs from 'fs-extra';
import path from 'path';

export async function ensureDir(dirPath) {
  await fs.ensureDir(dirPath);
}

export async function fileExists(filePath) {
  return await fs.pathExists(filePath);
}

export async function readFile(filePath) {
  return await fs.readFile(filePath, 'utf-8');
}

export async function writeFile(filePath, content) {
  await fs.writeFile(filePath, content, 'utf-8');
}

export async function getFileSize(filePath) {
  const stats = await fs.stat(filePath);
  return stats.size;
}

export function formatBytes(bytes) {
  if (bytes === 0) return '0 Bytes';
  const k = 1024;
  const sizes = ['Bytes', 'KB', 'MB', 'GB'];
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  return Math.round(bytes / Math.pow(k, i) * 100) / 100 + ' ' + sizes[i];
}
