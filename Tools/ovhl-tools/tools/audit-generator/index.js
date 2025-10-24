import inquirer from 'inquirer';
import chalk from 'chalk';
import { ProjectScanner } from './scanner.js';
import { TreeBuilder } from './tree-builder.js';
import { ProjectAnalyzer } from './analyzer.js';
import { createExport } from '../../core/exporter.js';
import { logger } from '../../core/logger.js';
import { getFullDateTime } from '../../utils/dateFormatter.js';
import { formatBytes } from '../../utils/fileSystem.js';
import { getProjectRoot } from '../../utils/pathHelper.js';
import path from 'path';

/**
 * Fungsi utama yang dijalankan oleh CLI
 * Fungsi ini akan menampilkan sub-menu audit
 */
export async function run() {
  // --- TAMBAHAN MULAI ---
  // Pertanyaan pertama untuk scope scan
  const { scanScope } = await inquirer.prompt([
    {
      type: 'list',
      name: 'scanScope',
      message: 'Pilih scope pemindaian:',
      choices: [
        { name: '📁  Hanya folder "Source" (Cepat, default)', value: 'source' },
        { name: '🌍  Seluruh root proyek (Lengkap, lebih lama)', value: 'root' },
      ],
    },
  ]);
  // --- TAMBAHAN SELESAI ---

  const { mode } = await inquirer.prompt([
    {
      type: 'list',
      name: 'mode',
      message: 'Pilih mode audit:',
      choices: [
        { name: '⚡  Audit Kilat (Cepat, info dasar)', value: 'quick' },
        { name: '🔬  Audit Mendalam (Analisis komplit & modul)', value: 'deep' },
        { name: '🌳  Hanya Struktur (Tampilan pohon folder)', value: 'structure' }
      ]
    }
  ]);

  const projectRoot = getProjectRoot();
  
  console.log('');
  logger.info(`Root Proyek: ${projectRoot}`);
  // --- TAMBAHAN BARIS INI ---
  logger.info(`Scope Scan: ${scanScope.toUpperCase()}`);
  logger.info(`Mode Audit: ${mode.toUpperCase()}`);
  console.log('');

  // --- MODIFIKASI: Kirim scanScope ke startAudit ---
  const result = await startAudit({ mode, projectRoot, scanScope });

  if (result.success) {
    console.log('');
    logger.success('Audit selesai!');
    console.log('');
    
    console.log(chalk.cyan('📊 RINGKASAN AUDIT:'));
    console.log(`   📄  Total File Dipindai: ${result.data.stats.totalFiles}`);
    console.log(`   💤  Modul Client: ${result.data.modules.client.length}`);
    console.log(`   🖥️   Modul Server: ${result.data.modules.server.length}`);
    
    if (mode !== 'structure') {
      console.log(`   ${result.health.emoji}  Kesehatan Proyek: ${result.health.health} (Skor: ${result.health.score})`);
    }
    
    console.log('');
    console.log(chalk.green(`💾  Hasil audit diekspor ke: ${result.exportPath}`));
    console.log('');
  } else {
    logger.error(`Audit gagal: ${result.error}`);
  }
}

/**
 * Logika inti untuk memulai proses audit
 */
// --- MODIFIKASI: Terima 'scanScope' dari options ---
async function startAudit(options) {
  const { mode = 'quick', projectRoot, scanScope = 'source' } = options;
  
  logger.startSpinner(`Memindai proyek (Scope: ${scanScope.toUpperCase()}, Mode: ${mode.toUpperCase()})...`);

  try {
    const scanner = new ProjectScanner(projectRoot);
    const treeBuilder = new TreeBuilder();
    const analyzer = new ProjectAnalyzer();
    
    const depth = mode === 'structure' ? 10 : (mode === 'deep' ? 10 : 3);
    
    // --- MODIFIKASI: Kirim scanScope ke scanner ---
    const scanResults = await scanner.scanFiles({ depth, scanScope });

    const clientModules = await scanner.scanModules('client');
    const serverModules = await scanner.scanModules('server');

    let clientServices = [];
    let serverServices = [];
    if (mode === 'deep') {
      clientServices = await scanner.scanServices('client');
      serverServices = await scanner.scanServices('server');
    }

    // --- MODIFIKASI: Tentukan path & ignore untuk tree builder ---
    const scanPath = scanScope === 'root' ? projectRoot : path.join(projectRoot, 'Source');
    const treeIgnore = scanScope === 'root'
      ? ['node_modules', '.git', 'Exports', 'Tools', '.vscode']
      : ['node_modules', '.git', 'Exports']; // 'Tools' diabaikan kalo scan root

    const tree = await treeBuilder.buildTree(scanPath, { depth, ignore: treeIgnore });
    // --- SELESAI MODIFIKASI TREE ---

    const data = {
      mode: mode.toUpperCase(),
      timestamp: getFullDateTime(),
      projectName: path.basename(projectRoot),
      stats: scanResults.stats,
      modules: {
        client: clientModules,
        server: serverModules,
        total: clientModules.length + serverModules.length
      },
      services: {
        client: clientServices,
        server: serverServices,
        total: clientServices.length + serverServices.length
      },
      tree
    };

    const health = analyzer.analyzeHealth(data);
    const recommendations = analyzer.generateRecommendations(data, mode);

    logger.succeedSpinner('Pemindaian selesai!');

    const content = generateMarkdown(data, health, recommendations, mode);

    const result = await createExport({
      content,
      name: `audit-${mode}`,
      category: 'audit',
      metadata: {
        filesScanned: scanResults.stats.totalFiles,
        modulesFound: data.modules.total
      }
    });

    return {
      success: true,
      data,
      health,
      exportPath: result.filePath
    };

  } catch (error) {
    logger.failSpinner('Pemindaian gagal!');
    logger.error(error.message);
    return {
      success: false,
      error: error.message
    };
  }
}

/**
 * Membuat konten Markdown dari data audit
 */
function generateMarkdown(data, health, recommendations, mode) {
  const { stats, modules, services, tree, timestamp, projectName } = data;

  let md = `# 📊 LAPORAN AUDIT PROYEK OVHL\n\n`;
  md += `**Dibuat pada**: ${timestamp}\n`;
  md += `**Proyek**: ${projectName}\n`;
  md += `**Mode**: ${data.mode}\n`;
  md += `**Tool Audit**: OVHL Tools v1.0\n\n`;

  if (mode !== 'structure') {
    md += `## 📈 STATISTIK PROYEK\n\n`;
    md += `| Metrik | Nilai |\n`;
    md += `|--------|-------|\n`;
    md += `| 🔷 File Lua | ${stats.filesByType.lua || 0} |\n`;
    md += `| 📋 File JSON | ${stats.filesByType.json || 0} |\n`;
    md += `| 📝 File MD | ${stats.filesByType.md || 0} |\n`;
    md += `| 📄 Total File | ${stats.totalFiles} |\n`;
    md += `| 💾 Total Ukuran | ${formatBytes(stats.totalSize)} |\n`;
    md += `| 💤 Modul Client | ${modules.client.length} |\n`;
    md += `| 🖥️ Modul Server | ${modules.server.length} |\n`;
    
    if (mode === 'deep' && services.total > 0) {
      md += `| 🛠️ Layanan Client | ${services.client.length} |\n`;
      md += `| 🛠️ Layanan Server | ${services.server.length} |\n`;
    }
    md += `\n`;

    if (mode === 'deep' && modules.total > 0) {
      md += `## 📋 INVENTARIS MODUL\n\n`;
      
      if (modules.client.length > 0) {
        md += `### 💤 Modul Client\n\n`;
        for (const module of modules.client) {
          md += `- **${module.name}**\n`;
          if (module.manifest.loadOrder !== undefined) {
            md += `   - Urutan Muat: ${module.manifest.loadOrder}`;
          }
          if (module.manifest.autoInit !== undefined) {
            md += ` | Mulai Otomatis: ${module.manifest.autoInit}`;
          }
          md += `\n`;
        }
        md += `\n`;
      }

      if (modules.server.length > 0) {
        md += `### 🖥️ Modul Server\n\n`;
        for (const module of modules.server) {
          md += `- **${module.name}**\n`;
          if (module.manifest.depends && module.manifest.depends.length > 0) {
            md += `   - Dependensi: ${module.manifest.depends.join(', ')}\n`;
          }
        }
        md += `\n`;
      }

      if (services.total > 0) {
        md += `### 🛠️ GAMBARAN LAYANAN\n\n`;
        if (services.client.length > 0) {
          md += `**Layanan Client**: ${services.client.map(s => s.name).join(', ')}\n\n`;
        }
        if (services.server.length > 0) {
          md += `**Layanan Server**: ${services.server.map(s => s.name).join(', ')}\n\n`;
        }
      }
    }
  }

  md += `## 🗂️ STRUKTUR PROYEK\n\n`;
  md += `\`\`\`\n`;
  md += tree;
  md += `\`\`\`\n\n`;

  if (mode !== 'structure') {
    md += `## 💡 PENILAIAN KESEHATAN\n\n`;
    md += `${health.emoji} **${health.health}** - ${health.message}\n\n`;
    md += `**Skor Kesehatan**: ${health.score}\n\n`;

    md += `### 🔧 REKOMENDASI\n\n`;
    for (const rec of recommendations) {
      md += `- ${rec}\n`;
    }
    md += `\n`;
  }

  md += `---\n`;
  md += `*Dibuat oleh OVHL Tools - Siap untuk Analisis AI*\n`;

  return md;
}

