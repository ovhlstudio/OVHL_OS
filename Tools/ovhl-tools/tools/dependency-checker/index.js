import fs from 'fs-extra';
import path from 'path';
import chalk from 'chalk';
import { getProjectRoot } from '../../utils/pathHelper.js';
import { logger } from '../../core/logger.js';

/**
 * Fungsi utama yang dijalankan oleh CLI
 */
export async function run() {
  logger.startSpinner('Menganalisis dependensi modul...');
  
  const projectRoot = getProjectRoot();

  try {
    const clientModules = await findModules('client', projectRoot);
    const serverModules = await findModules('server', projectRoot);
    const allModules = [...clientModules, ...serverModules];

    // --- TES ANTI-CRASH (VERSI PERBAIKAN) ---
    // Kalo Source/Modules kosong, dia gak bakal error, cuma ngasih warning
    if (allModules.length === 0) {
      // GANTI 'logger.warning' DENGAN 'logger.warnSpinner'
      logger.warnSpinner('Tidak ada modul yang ditemukan. Proses analisis dibatalkan.');
      return; // Spinner udah dimatiin, aman buat return
    }
    // --- BATAS PERBAIKAN ---

    const report = checkDependencies(allModules);
    logger.succeedSpinner('Analisis dependensi selesai!');
    
    printReport(report);

  } catch (error) {
    logger.failSpinner('Analisis gagal!');
    logger.error(error.message);
  }
}

/**
 * Mencetak laporan ke konsol dengan warna
 */
function printReport(report) {
  let hasIssues = false;
  
  console.log(chalk.cyan.underline('\n--- HASIL PENGECEKAN DEPENDENSI ---'));

  // 1. Laporan Dependensi Hilang
  if (report.missing.length > 0) {
    hasIssues = true;
    console.log(chalk.red.bold('\n❌ DEPENDENSI HILANG:'));
    report.missing.forEach(item => {
      console.log(`   - Modul ${chalk.yellow(item.module)} butuh ${chalk.red(item.needs)} (TIDAK DITEMUKAN)`);
    });
  }

  // 2. Laporan Dependensi Putar (Circular)
  if (report.circular.length > 0) {
    hasIssues = true;
    console.log(chalk.magenta.bold('\n⛔ DEPENDENSI PUTAR (CIRCULAR):'));
    report.circular.forEach(item => {
      console.log(`   - ${chalk.yellow(item.path.join(chalk.magenta(' -> ')))}`);
    });
  }

  // 3. Laporan Dependensi AMAN
  console.log(chalk.green.bold('\n✅ DEPENDENSI AMAN:'));
  if (report.ok.length === 0) {
    console.log('   - Tidak ada dependensi yang aman.');
  } else {
    report.ok.forEach(item => {
      console.log(`   - ${chalk.yellow(item.module)} -> ${chalk.green(item.needs)} (OK)`);
    });
  }

  // Kesimpulan
  if (hasIssues) {
    console.log(chalk.red.bold('\n--- ⚠️  DITEMUKAN MASALAH DEPENDENSI ---'));
  } else {
    console.log(chalk.green.bold('\n--- 🎉  SEMUA DEPENDENSI AMAN & VALID ---'));
  }
  console.log('');
}

/**
 * Logika inti untuk mengecek dependensi
 */
function checkDependencies(allModules) {
  const report = { missing: [], circular: [], ok: [] };
  const moduleNames = new Set(allModules.map(m => m.name));
  const moduleMap = new Map(allModules.map(m => [m.name, m.manifest]));

  // 1. Cek Dependensi Hilang & OK
  for (const module of allModules) {
    const dependencies = module.manifest.depends || [];
    if (dependencies.length === 0) continue;

    for (const depName of dependencies) {
      if (!moduleNames.has(depName)) {
        report.missing.push({ module: module.name, needs: depName });
      } else {
        report.ok.push({ module: module.name, needs: depName });
      }
    }
  }

  // 2. Cek Dependensi Putar (Circular)
  const graph = new Map(allModules.map(m => [m.name, m.manifest.depends || []]));
  const visited = new Set(); // Melacak node yang sudah selesai dicek
  const inPath = new Set(); // Melacak node di jalur rekursi saat ini

  function findCycle(node) {
    visited.add(node);
    inPath.add(node);

    const neighbors = graph.get(node) || [];
    for (const neighbor of neighbors) {
      if (!moduleNames.has(neighbor)) continue; // Skip (udah ditangani 'missing')

      if (!visited.has(neighbor)) {
        const cycle = findCycle(neighbor);
        if (cycle) {
          // Temukan awal siklus dan kembalikan
          const start = cycle.indexOf(neighbor);
          report.circular.push({ path: [...cycle.slice(start), neighbor] });
          // Jangan deteksi siklus yang sama berulang kali
          return null; 
        }
      } else if (inPath.has(neighbor)) {
        // Siklus ditemukan!
        return [neighbor];
      }
    }
    
    inPath.delete(node);
    return null;
  }
  
  // Deteksi siklus untuk setiap node di graf
  for (const moduleName of moduleNames) {
      if (!visited.has(moduleName)) {
          findCycle(moduleName);
      }
  }
  
  // Bersihkan duplikat laporan siklus (jika ada)
  const uniqueCircular = Array.from(new Set(report.circular.map(c => c.path.sort().join(','))))
     .map(pathStr => ({ path: pathStr.split(',') }));
  report.circular = uniqueCircular;


  return report;
}


// --- FUNGSI SCANNER INTERNAL (Anti-Crash) ---
// Kita 'curi' fungsi scanner dari tool audit, tapi disederhanakan
// Ini penting biar tool ini mandiri (modular)

async function findModules(type, projectRoot) {
  const basePath = type === 'client' 
    ? 'Source/Modules/Client'
    : 'Source/Modules/Server';
  
  const modulesDir = path.join(projectRoot, basePath);

  // --- INI DIA ANTI-CRASH NYA ---
  if (!await fs.pathExists(modulesDir)) {
    return []; // Kalo folder Source/Modules/Client gak ada, balikin array kosong, gak crash
  }

  const modules = [];
  const entries = await fs.readdir(modulesDir, { withFileTypes: true });

  for (const entry of entries) {
    if (!entry.isDirectory()) continue;

    const manifestFile = 'manifest.lua';
    const manifestPath = path.join(modulesDir, entry.name, manifestFile);
    
    if (await fs.pathExists(manifestPath)) {
      const manifest = await parseManifest(manifestPath);
      modules.push({
        name: entry.name,
        manifest,
      });
    }
  }
  return modules;
}

async function parseManifest(filePath) {
  try {
    const content = await fs.readFile(filePath, 'utf-8');
    const manifest = {};
    
    // Regex simpel buat nyari 'depends'
    const dependsMatch = content.match(/depends\s*=\s*\{([^}]*)\}/s);
    if (dependsMatch) {
      
      // --- PERBAIKAN PARSER ---
      const innerBlock = dependsMatch[1];
      
      // 1. Hapus komen multi-baris (--[[ ... ]])
      const noMultiLineComments = innerBlock.replace(/--\[\[.*?\]\]/gs, '');
      
      // 2. Hapus komen satu-baris (--)
      const noComments = noMultiLineComments.replace(/--.*$/gm, '');

      // 3. Baru split, map, dan filter
      manifest.depends = noComments
        .split(',') // Split berdasarkan koma
        .map(d => d.trim().replace(/["']/g, '')) // Hapus spasi & kutip
        .filter(d => d && d !== ''); // Hapus string kosong (hasil dari koma trakhir, dll)
      // --- BATAS PERBAIKAN ---

    } else {
      manifest.depends = [];
    }
    
    return manifest;
  } catch (error) {
    logger.warning(`Gagal baca manifest: ${filePath}. Error: ${error.message}`);
    return { depends: [] }; // Anti-crash
  }
}

