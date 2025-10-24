// Kita butuh 'fileSystem' dari utils elu
// NAMA FUNGSI SUDAH DIPERBAIKI
import { readFile } from '../utils/fileSystem.js';
import path from 'path';

// Path ke folder cetakan kita
const TEMPLATE_DIR = path.resolve(process.cwd(), 'Tools', 'ovhl-tools', 'templates');

/**
 * Mengambil konten template dan mengganti placeholder-nya.
 * @param {string} templateName - Nama file template (misal: 'manifest.lua')
 * @param {object} replacements - Objek berisi placeholder (misal: { __PASCAL_NAME__: "MyModule" })
 * @returns {Promise<string>} Konten file yang sudah diproses
 */
export async function getTemplate(templateName, replacements = {}) {
    const filePath = path.join(TEMPLATE_DIR, `${templateName}.txt`);
    
    // 1. Baca cetakan mentah (pake tool elu)
    // SUDAH DIGANTI ke 'readFile'
    const rawContent = await readFile(filePath);
    if (!rawContent) {
        throw new Error(`Template '${templateName}' tidak ditemukan di ${filePath}`);
    }

    let processedContent = rawContent;

    // 2. Ganti semua placeholder
    for (const key in replacements) {
        // Bikin Regex global buat ganti semua kemunculan
        const regex = new RegExp(key, 'g');
        processedContent = processedContent.replace(regex, replacements[key]);
    }

    return processedContent;
}