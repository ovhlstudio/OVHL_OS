// 🤖 AI SMART SCRIPT (Untuk di-paste ke kurir.js) - VERSI 3.2
// MISI: Sinkronisasi '03_OVHL_BUILDER_GUIDE.md' (Fix Aturan Core)
// Waktu: 24 Oktober 2025

import fs from 'fs/promises';
import path from 'path';

// --- KONFIGURASI MISI ---

const BUILDER_GUIDE_FILE = 'Docs/03_OVHL_BUILDER_GUIDE.md';

// --- UTILITY FUNCTION (SMART PATCHER) ---

/**
 * @typedef {Object} Replacement
 * @property {RegExp} search - Regex untuk dicari
 * @property {string} replace - String pengganti
 */

/**
 * @typedef {Object} PatchResult
 * @property {string} file
 * @property {boolean} success
 * @property {string} message
 * @property {boolean} patched
 */

/**
 * Fungsi Patcher Cerdas dengan Audit
 * @param {string} filePath - Path ke file
 * @param {Replacement[]} replacements - Array objek search-replace
 * @returns {Promise<PatchResult>}
 */
async function smartPatchFile(filePath, replacements) {
    const fullPath = path.resolve(filePath);
    const report = { file: filePath, success: false, message: '', patched: false };

    try {
        // --- PHASE 1: PRE-CHECK ---
        report.message = `[PRE-CHECK] Mengecek file: ${fullPath}...`;
        await fs.access(fullPath, fs.constants.F_OK | fs.constants.R_OK | fs.constants.W_OK);
        report.message = '[PRE-CHECK] OK. File ditemukan dan bisa ditulis.';

        // --- PHASE 2: EXECUTION ---
        report.message = '[EXEC] Membaca file...';
        let content = await fs.readFile(fullPath, 'utf8');
        const originalContent = content;
        let patchCount = 0;

        report.message = '[EXEC] Melakukan patch...';
        for (const { search, replace } of replacements) {
            if (search.test(content)) {
                content = content.replace(search, replace);
                patchCount++;
            }
        }

        if (patchCount === 0) {
            report.success = true;
            report.message = '[EXEC] Selesai. Tidak ada patch yang diaplikasikan (mungkin sudah up-to-date).';
            return report;
        }
        
        report.patched = true;
        report.message = `[EXEC] Ditemukan ${patchCount} patch. Menulis file...`;
        await fs.writeFile(fullPath, content, 'utf8');
        report.message = `[EXEC] OK. File berhasil di-patch.`;

        // --- PHASE 3: POST-AUDIT ---
        report.message = '[POST-AUDIT] Memverifikasi patch...';
        const newContent = await fs.readFile(fullPath, 'utf8');
        
        if (newContent === originalContent) {
            throw new Error('Audit gagal! Konten file tidak berubah setelah ditulis.');
        }
        if (newContent.length === 0) {
            throw new Error('Audit gagal! File menjadi kosong setelah ditulis.');
        }

        let verificationFailed = false;
        for (const { search, replace } of replacements) {
            if (search.test(newContent)) {
                verificationFailed = true;
                report.message = `[POST-AUDIT] GAGAL: Pola "${search.source}" masih ditemukan setelah patch. Seharusnya sudah hilang.`;
                break;
            }
        }

        if (verificationFailed) {
            throw new Error(report.message);
        }

        report.success = true;
        report.message = `[POST-AUDIT] OK. ${patchCount} patch berhasil diverifikasi.`;

    } catch (err) {
        report.success = false;
        report.message = `❌ GAGAL: ${err.message.includes('ENOENT') ? 'File tidak ditemukan di path yang diharapkan.' : err.message}`;
        console.error(`Error pada file ${filePath}:`, err.code === 'ENOENT' ? err.message : err);
    }
    
    return report;
}

// --- FUNGSI EKSEKUSI UTAMA ---

async function runMission() {
    console.log("🚀 [KURIR MISI] Memulai Misi: 'Sinkronisasi '03_OVHL_BUILDER_GUIDE.md'' - v3.2");
    console.log("----------------------------------------------------------------------");

    const replacements = [
        // 1. Fix Aturan Core (No. 2)
        {
            // Regex spesifik nyari aturan lama
            search: /❌ Nyentuh sistem OVHL Core \(Ref: `00_CONST 1.1.3`\)/g,
            replace: `❌ Ngoding di dalam \`Source/Core/\` (Itu tugas Core-Dev, Ref: \`00_CONST 1.1.3\`)`
        }
    ];

    console.log(`\n📄 Memproses: ${BUILDER_GUIDE_FILE}...`);
    const report = await smartPatchFile(BUILDER_GUIDE_FILE, replacements);
    console.log(`   Status: ${report.message}`);

    // --- LAPORAN AKHIR MISI ---
    console.log("\n----------------------------------------------------------------------");
    console.log("📊 [KURIR MISI] Laporan Akhir Misi:");
    
    console.log(`   - ${report.file}: ${report.success ? '✅ SUKSES' : '❌ GAGAL'} (${report.message})`);

    if (!report.success) {
        console.log("\n⚠️ [KURIR MISI] Misi GAGAL. Cek log error di atas.");
    } else {
        console.log(`\n   Total patch diaplikasikan: ${report.patched ? replacements.length : 0} (dari ${replacements.length} target)`);
        console.log("\n✅ [KURIR MISI] Misi Selesai dengan Sukses. File '03_OVHL_BUILDER_GUIDE.md' sudah sinkron.");
        console.log("\n🔥 SEMUA DOKUMEN SUDAH SINKRON. Kita siap lanjut, mamen!");
    }
    console.log("----------------------------------------------------------------------");
}

// --- JALANKAN MISI ---
runMission().catch(err => {
    console.error("\n❌❌❌ [KURIR MISI] BENCANA! Terjadi error tak terduga:", err);
    console.log("Misi dibatalkan.");
});