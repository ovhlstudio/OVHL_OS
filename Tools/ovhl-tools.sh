#!/bin/bash

# ==========================================
# 🪄 OVHL TOOLS - MAGIC SETUP SCRIPT (v2)
# ==========================================
# Versi ini auto-detect tools & setup di Tools/ovhl-tools

set -e  # Exit on error

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${CYAN}"
echo "🪄 OVHL TOOLS - MAGIC SETUP (v2)"
echo "================================="
echo -e "${NC}"

# Get current directory (Harusnya di Tools/)
CURRENT_DIR="$(pwd)"
BASE_DIR="$CURRENT_DIR/ovhl-tools"

echo -e "${YELLOW}📍 Lokasi Setup: $BASE_DIR${NC}"
echo -e "${YELLOW}Pastikan skrip ini dijalankan dari dalam folder 'Tools/'${NC}"
echo ""

# Confirm
read -p "🤔 Lanjut setup ovhl-tools di lokasi ini? (y/n): " confirm
if [[ "$confirm" != "y" ]]; then
    echo -e "${RED}❌ Setup dibatalkan.${NC}"
    exit 0
fi

echo ""
echo -e "${CYAN}🚀 Memulai magic setup...${NC}"
echo ""

# ==========================================
# FASE 1: MEMBUAT STRUKTUR FOLDER
# ==========================================
echo -e "${GREEN}📁 Fase 1: Membuat struktur folder...${NC}"

mkdir -p "$BASE_DIR/bin"
mkdir -p "$BASE_DIR/core"
mkdir -p "$BASE_DIR/tools/audit-generator"
mkdir -p "$BASE_DIR/utils"
mkdir -p "$BASE_DIR/config"

echo "   ✅ Folder dibuat"

# ==========================================
# FASE 2: MEMBUAT PACKAGE.JSON
# ==========================================
echo -e "${GREEN}📦 Fase 2: Membuat package.json...${NC}"

cat > "$BASE_DIR/package.json" << 'EOF'
{
  "name": "ovhl-tools",
  "version": "1.0.0",
  "description": "OVHL Development Tools - Audit Generator & Context Tools",
  "type": "module",
  "main": "index.js",
  "bin": {
    "ovhl-tools": "./bin/cli.js",
    "ovhl": "./bin/cli.js"
  },
  "scripts": {
    "start": "node bin/cli.js"
  },
  "keywords": ["roblox", "rojo", "ovhl", "tools", "development"],
  "author": "Hanif Saifudin",
  "license": "MIT",
  "dependencies": {
    "inquirer": "^9.2.12",
    "chalk": "^5.3.0",
    "ora": "^8.0.1",
    "cli-table3": "^0.6.3",
    "boxen": "^7.1.1",
    "fast-glob": "^3.3.2",
    "fs-extra": "^11.2.0",
    "dayjs": "^1.11.10",
    "handlebars": "^4.7.8"
  }
}
EOF

echo "   ✅ package.json dibuat"

# ==========================================
# FASE 3: MEMBUAT FILE UTILITAS
# ==========================================
echo -e "${GREEN}🔧 Fase 3: Membuat file utilitas (Path diperbarui)...${NC}"

# utils/dateFormatter.js
cat > "$BASE_DIR/utils/dateFormatter.js" << 'EOF'
import dayjs from 'dayjs';

export function getTimestamp() {
  return dayjs().format('HHmmss');
}

export function getDateFolder() {
  return dayjs().format('YYYY-MM-DD');
}

export function getFullDateTime() {
  return dayjs().format('YYYY-MM-DD HH:mm:ss');
}

export function formatFileTimestamp() {
  return dayjs().format('YYYYMMDDHHmmss');
}
EOF

# utils/fileSystem.js
cat > "$BASE_DIR/utils/fileSystem.js" << 'EOF'
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
EOF

# utils/pathHelper.js
cat > "$BASE_DIR/utils/pathHelper.js" << 'EOF'
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
// __dirname sekarang ada di .../Tools/ovhl-tools/utils
const __dirname = path.dirname(__filename);

/**
 * Mendapat path ke root folder 'ovhl-tools'
 * Dari: .../Tools/ovhl-tools/utils
 * Ke:   .../Tools/ovhl-tools/
 */
export function getOvhlToolsRoot() {
  return path.resolve(__dirname, '..');
}

/**
 * Mendapat path ke folder 'Tools'
 * Dari: .../Tools/ovhl-tools/utils
 * Ke:   .../Tools/
 */
export function getToolsRoot() {
  return path.resolve(__dirname, '../..');
}

/**
 * Mendapat path ke root proyek (misal: OVHL_OS)
 * Dari: .../Tools/ovhl-tools/utils
 * Ke:   .../
 */
export function getProjectRoot() {
  return path.resolve(__dirname, '../../..');
}

/**
 * Mendapat path ke folder 'Exports'
 * Dari: .../Tools/ovhl-tools/utils
 * Ke:   .../Tools/Exports/
 */
export function getExportsDir() {
  // Path: .../Tools/Exports
  return path.join(getToolsRoot(), 'Exports');
}
EOF

echo "   ✅ File utilitas dibuat"

# ==========================================
# FASE 4: MEMBUAT FILE INTI (CORE)
# ==========================================
echo -e "${GREEN}⚙️   Fase 4: Membuat file inti...${NC}"

# core/logger.js
cat > "$BASE_DIR/core/logger.js" << 'EOF'
import chalk from 'chalk';
import ora from 'ora';

export class Logger {
  constructor() {
    this.spinner = null;
  }

  info(message) {
    console.log(chalk.cyan(`ℹ️   ${message}`));
  }

  success(message) {
    console.log(chalk.green(`✅ ${message}`));
  }

  warning(message) {
    console.log(chalk.yellow(`⚠️   ${message}`));
  }

  error(message) {
    console.log(chalk.red(`❌ ${message}`));
  }

  startSpinner(message) {
    this.spinner = ora(message).start();
  }

  succeedSpinner(message) {
    if (this.spinner) {
      this.spinner.succeed(message);
      this.spinner = null;
    }
  }

  failSpinner(message) {
    if (this.spinner) {
      this.spinner.fail(message);
      this.spinner = null;
    }
  }
}

export const logger = new Logger();
EOF

# core/exporter.js
cat > "$BASE_DIR/core/exporter.js" << 'EOF'
import fs from 'fs-extra';
import path from 'path';
import { getExportsDir } from '../utils/pathHelper.js';
import { getDateFolder, getTimestamp } from '../utils/dateFormatter.js';
import { logger } from './logger.js';

export async function createExport(options) {
  const {
    content,
    name,
    type = 'md',
    category = 'audit',
    metadata = {}
  } = options;

  try {
    // Create export path: Tools/Exports/YYYY-MM-DD/
    const dateFolder = getDateFolder();
    const timestamp = getTimestamp();
    const exportDir = path.join(getExportsDir(), dateFolder);
    
    await fs.ensureDir(exportDir);

    // Create filename: category-name-HHMMSS.md
    const filename = `${name}-${timestamp}.${type}`;
    const filePath = path.join(exportDir, filename);

    // Write file
    await fs.writeFile(filePath, content, 'utf-8');

    return {
      success: true,
      filePath,
      filename,
      metadata
    };
  } catch (error) {
    logger.error(`Export gagal: ${error.message}`);
    return {
      success: false,
      error: error.message
    };
  }
}
EOF

echo "   ✅ File inti dibuat"

# ==========================================
# FASE 5: MEMBUAT TOOL AUDIT GENERATOR
# ==========================================
echo -e "${GREEN}🔍 Fase 5: Membuat tool Audit Generator (Future-Proof)...${NC}"

# tools/audit-generator/config.json
cat > "$BASE_DIR/tools/audit-generator/config.json" << 'EOF'
{
  "name": "Generator Audit",
  "slug": "audit",
  "description": "Pindai proyek & buat laporan audit",
  "emoji": "📊",
  "main": "run"
}
EOF

# tools/audit-generator/scanner.js
cat > "$BASE_DIR/tools/audit-generator/scanner.js" << 'EOF'
import fastGlob from 'fast-glob';
import fs from 'fs-extra';
import path from 'path';

export class ProjectScanner {
  constructor(projectRoot) {
    this.projectRoot = projectRoot;
    this.stats = {
      totalFiles: 0,
      totalSize: 0,
      filesByType: {}
    };
  }

  async scanFiles(options = {}) {
    const { 
      depth = 10, 
      extensions = ['lua', 'json', 'md'],
      baseDir = 'Source'
    } = options;
    
    const pattern = `**/*.{${extensions.join(',')}}`;
    const cwd = path.join(this.projectRoot, baseDir);

    if (!await fs.pathExists(cwd)) {
      return { files: [], stats: this.stats };
    }

    const files = await fastGlob(pattern, {
      cwd,
      absolute: true,
      deep: depth,
      ignore: ['**/node_modules/**', '**/.git/**', '**/Exports/**']
    });

    this.stats.totalFiles = 0;
    this.stats.totalSize = 0;
    this.stats.filesByType = {};

    for (const file of files) {
      try {
        const stats = await fs.stat(file);
        this.stats.totalFiles++;
        this.stats.totalSize += stats.size;
        
        const ext = path.extname(file).slice(1);
        this.stats.filesByType[ext] = (this.stats.filesByType[ext] || 0) + 1;
      } catch (error) {
        // Skip files that can't be read
      }
    }

    return {
      files,
      stats: this.stats
    };
  }

  async scanModules(type = 'client') {
    const basePath = type === 'client' 
      ? 'Source/Modules/Client'
      : 'Source/Modules/Server';
    
    const modulesDir = path.join(this.projectRoot, basePath);

    if (!await fs.pathExists(modulesDir)) {
      return [];
    }

    const modules = [];
    const entries = await fs.readdir(modulesDir, { withFileTypes: true });

    for (const entry of entries) {
      if (!entry.isDirectory()) continue;

      const manifestFile = 'manifest.lua';
      const manifestPath = path.join(modulesDir, entry.name, manifestFile);
      
      if (await fs.pathExists(manifestPath)) {
        const manifest = await this.parseManifest(manifestPath);
        const moduleFiles = await this.getModuleFiles(
          path.join(modulesDir, entry.name)
        );

        modules.push({
          name: entry.name,
          type,
          path: path.join(modulesDir, entry.name),
          manifest,
          files: moduleFiles
        });
      }
    }

    return modules;
  }

  async getModuleFiles(modulePath) {
    try {
      const files = await fs.readdir(modulePath);
      return files.filter(f => f.endsWith('.lua'));
    } catch (error) {
      return [];
    }
  }

  async parseManifest(filePath) {
    try {
      const content = await fs.readFile(filePath, 'utf-8');
      
      const manifest = {};
      
      const nameMatch = content.match(/name\s*=\s*["']([^"']+)["']/);
      if (nameMatch) manifest.name = nameMatch[1];
      
      const versionMatch = content.match(/version\s*=\s*["']([^"']+)["']/);
      if (versionMatch) manifest.version = versionMatch[1];
      
      const loadOrderMatch = content.match(/loadOrder\s*=\s*(\d+)/);
      if (loadOrderMatch) manifest.loadOrder = parseInt(loadOrderMatch[1]);
      
      const autoInitMatch = content.match(/autoInit\s*=\s*(true|false)/);
      if (autoInitMatch) manifest.autoInit = autoInitMatch[1] === 'true';
      
      const dependsMatch = content.match(/depends\s*=\s*\{([^}]*)\}/s);
      if (dependsMatch) {
        manifest.depends = dependsMatch[1]
          .split(',')
          .map(d => d.trim().replace(/["']/g, ''))
          .filter(d => d && d !== '');
      } else {
        manifest.depends = [];
      }
      
      return manifest;
    } catch (error) {
      return { error: error.message };
    }
  }

  async scanServices(type = 'client') {
    const basePath = type === 'client'
      ? 'Source/Core/Client/Services'
      : 'Source/Core/Server/Services';
    
    const servicesDir = path.join(this.projectRoot, basePath);

    if (!await fs.pathExists(servicesDir)) {
      return [];
    }

    const services = [];
    const files = await fs.readdir(servicesDir);

    for (const file of files) {
      if (file.endsWith('.lua')) {
        const servicePath = path.join(servicesDir, file);
        const content = await fs.readFile(servicePath, 'utf-8');
        
        const functionCount = (content.match(/function\s+\w+:/g) || []).length;
        
        services.push({
          name: file.replace('.lua', ''),
          type,
          path: servicePath,
          functionCount
        });
      }
    }

    return services;
  }
}
EOF

# tools/audit-generator/tree-builder.js
cat > "$BASE_DIR/tools/audit-generator/tree-builder.js" << 'EOF'
import fs from 'fs-extra';
import path from 'path';

export class TreeBuilder {
  constructor() {
    this.icons = {
      folder: '📁',
      lua: '🔷',
      json: '📋',
      md: '📝',
      txt: '📄',
      sh: '⚡',
      js: '📜'
    };
  }

  async buildTree(rootPath, options = {}) {
    const { 
      depth = 10, 
      showFiles = true,
      ignore = ['node_modules', '.git', 'Exports']
    } = options;
    
    if (!await fs.pathExists(rootPath)) {
      return '(Path not found)';
    }

    const name = path.basename(rootPath);
    let output = `📁 ${name}\n`;
    
    output += await this._buildNode(rootPath, '', true, depth, showFiles, ignore);
    
    return output;
  }

  async _buildNode(nodePath, prefix, isLast, depth, showFiles, ignore) {
    if (depth <= 0) return '';

    let output = '';
    
    try {
      const entries = await fs.readdir(nodePath, { withFileTypes: true });
      
      const filtered = entries.filter(entry => {
        if (entry.name.startsWith('.')) return false;
        if (ignore.includes(entry.name)) return false;
        return true;
      });

      filtered.sort((a, b) => {
        if (a.isDirectory() && !b.isDirectory()) return -1;
        if (!a.isDirectory() && b.isDirectory()) return 1;
        return a.name.localeCompare(b.name);
      });

      for (let i = 0; i < filtered.length; i++) {
        const entry = filtered[i];
        const childIsLast = i === filtered.length - 1;
        const childPath = path.join(nodePath, entry.name);
        
        const connector = childIsLast ? '└── ' : '├── ';
        const newPrefix = prefix + (childIsLast ? '    ' : '│   ');
        
        if (entry.isDirectory()) {
          output += `${prefix}${connector}${this.icons.folder} ${entry.name}\n`;
          
          if (showFiles) {
            output += await this._buildNode(
              childPath,
              newPrefix,
              childIsLast,
              depth - 1,
              showFiles,
              ignore
            );
          }
        } else {
          const ext = path.extname(entry.name).slice(1);
          const icon = this.icons[ext] || '📄';
          output += `${prefix}${connector}${icon} ${entry.name}\n`;
        }
      }
    } catch (error) {
      // Skip directories we can't read
    }

    return output;
  }
}
EOF

# tools/audit-generator/analyzer.js
cat > "$BASE_DIR/tools/audit-generator/analyzer.js" << 'EOF'
export class ProjectAnalyzer {
  constructor() {
    this.thresholds = {
      excellent: { files: 50, modules: 10, score: 150 },
      good: { files: 20, modules: 5, score: 100 },
      fair: { files: 10, modules: 2, score: 50 }
    };
  }

  analyzeHealth(data) {
    const { stats, modules } = data;
    
    const totalModules = modules.client.length + modules.server.length;
    const score = (stats.totalFiles * 2) + (totalModules * 10);
    
    let health = 'PERLU PERBAIKAN';
    let emoji = '⚠️';
    let message = 'Struktur masih minimal';
    
    if (score >= this.thresholds.excellent.score) {
      health = 'LUAR BIASA';
      emoji = '🏆';
      message = 'Proyek terstruktur baik dan kaya fitur';
    } else if (score >= this.thresholds.good.score) {
      health = 'BAGUS';
      emoji = '✅';
      message = 'Fondasi solid, masih bisa dikembangkan';
    } else if (score >= this.thresholds.fair.score) {
      health = 'CUKUP';
      emoji = '⚠️';
      message = 'Struktur dasar sudah ada';
    }
    
    return {
      score,
      health,
      emoji,
      message
    };
  }

  generateRecommendations(data, mode) {
    const recommendations = [];
    const { stats, modules } = data;
    
    if (stats.totalFiles < 10) {
      recommendations.push('📝 Tambah file Lua untuk kembangkan fungsionalitas');
    }
    
    if (modules.client.length === 0) {
      recommendations.push('💤 Buat modul sisi klien untuk UI/UX');
    }
    
    if (modules.server.length === 0) {
      recommendations.push('🖥️ Tambah modul sisi server untuk logika game');
    }
    
    if (mode === 'quick') {
      recommendations.push('🔎 Jalankan Audit Mendalam untuk analisis komprehensif');
    }
    
    if (recommendations.length === 0) {
      recommendations.push('🎉 Tidak ada masalah besar! Pertahankan, bro!');
    }
    
    return recommendations;
  }
}
EOF

# tools/audit-generator/index.js
cat > "$BASE_DIR/tools/audit-generator/index.js" << 'EOF'
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
  logger.info(`Mode: ${mode.toUpperCase()}`);
  console.log('');

  const result = await startAudit({ mode, projectRoot });

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
async function startAudit(options) {
  const { mode = 'quick', projectRoot } = options;
  
  logger.startSpinner(`Memindai proyek (mode ${mode.toUpperCase()})...`);

  try {
    const scanner = new ProjectScanner(projectRoot);
    const treeBuilder = new TreeBuilder();
    const analyzer = new ProjectAnalyzer();
    
    const depth = mode === 'structure' ? 10 : (mode === 'deep' ? 10 : 3);
    const scanResults = await scanner.scanFiles({ depth });

    const clientModules = await scanner.scanModules('client');
    const serverModules = await scanner.scanModules('server');

    let clientServices = [];
    let serverServices = [];
    if (mode === 'deep') {
      clientServices = await scanner.scanServices('client');
      serverServices = await scanner.scanServices('server');
    }

    const sourcePath = path.join(projectRoot, 'Source');
    const tree = await treeBuilder.buildTree(sourcePath, { depth });

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
EOF

echo "   ✅ Tool Audit Generator dibuat"

# ==========================================
# FASE 6: MEMBUAT INTERFACE CLI (DINAMIS)
# ==========================================
echo -e "${GREEN}🎮 Fase 6: Membuat interface CLI (Dinamis/Future-Proof)...${NC}"

# bin/cli.js
cat > "$BASE_DIR/bin/cli.js" << 'EOF'
#!/usr/bin/env node

import inquirer from 'inquirer';
import chalk from 'chalk';
import boxen from 'boxen';
import fs from 'fs-extra';
import path from 'path';
import { fileURLToPath } from 'url';
import { logger } from '../core/logger.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

/**
 * Memuat semua tool yang tersedia dari folder 'tools'
 */
async function loadTools() {
  const toolsDir = path.resolve(__dirname, '../tools');
  const tools = [];

  try {
    const toolFolders = await fs.readdir(toolsDir, { withFileTypes: true });

    for (const dir of toolFolders) {
      if (dir.isDirectory()) {
        const configPath = path.join(toolsDir, dir.name, 'config.json');
        if (await fs.pathExists(configPath)) {
          const config = await fs.readJson(configPath);
          tools.push({
            ...config,
            folder: dir.name,
          });
        }
      }
    }
  } catch (error) {
    logger.error(`Gagal memuat tools: ${error.message}`);
  }
  return tools;
}

/**
 * Fungsi utama CLI
 */
async function main() {
  console.clear();
  
  console.log(
    boxen(chalk.cyan.bold('🚀 OVHL TOOLS v2.0 (Dinamis)'), {
      padding: 1,
      margin: 1,
      borderStyle: 'round',
      borderColor: 'cyan'
    })
  );

  const availableTools = await loadTools();
  
  if (availableTools.length === 0) {
    logger.warning('Tidak ada tool yang ditemukan di folder /tools.');
    logger.info('Pastikan tiap tool punya folder dan config.json');
    process.exit(0);
  }

  const choices = availableTools.map(tool => ({
    name: `${tool.emoji || '🔧'}  ${tool.name} ${chalk.grey(`(${tool.description})`)}`,
    value: tool.slug,
  }));
  
  choices.push(new inquirer.Separator());
  choices.push({ name: '❌  Keluar', value: 'exit' });

  const { toolSlug } = await inquirer.prompt([
    {
      type: 'list',
      name: 'toolSlug',
      message: 'Pilih tool yang mau dipakai:',
      choices,
      pageSize: 10
    }
  ]);

  if (toolSlug === 'exit') {
    logger.info('Sampai jumpa! 👋');
    process.exit(0);
  }

  // Cari tool yang dipilih
  const selectedTool = availableTools.find(t => t.slug === toolSlug);

  if (selectedTool) {
    try {
      // Impor modul tool secara dinamis
      const toolModule = await import(`../tools/${selectedTool.folder}/index.js`);
      
      // Panggil fungsi 'main' dari tool (misal: 'run')
      const runFunction = toolModule[selectedTool.main];
      
      if (typeof runFunction === 'function') {
        await runFunction();
      } else {
        logger.error(`Fungsi '${selectedTool.main}' tidak ditemukan di tool '${selectedTool.name}'.`);
      }

    } catch (error) {
      logger.error(`Gagal menjalankan tool '${selectedTool.name}': ${error.message}`);
      console.error(error);
    }

    // Tanya lagi
    console.log('');
    const { again } = await inquirer.prompt([
      {
        type: 'confirm',
        name: 'again',
        message: 'Mau jalankan tool lain?',
        default: false
      }
    ]);

    if (again) {
      await main();
    } else {
      logger.info('Sampai jumpa! 👋');
      process.exit(0);
    }

  } else {
    logger.error('Tool tidak valid.');
  }
}

main().catch(error => {
  logger.error(`Error fatal: ${error.message}`);
  process.exit(1);
});
EOF

chmod +x "$BASE_DIR/bin/cli.js"

echo "   ✅ Interface CLI dinamis dibuat"

# ==========================================
# FASE 7: MEMBUAT INDEX.JS
# ==========================================
echo -e "${GREEN}📦 Fase 7: Membuat index.js...${NC}"

cat > "$BASE_DIR/index.js" << 'EOF'
// File ini (index.js) sekarang tidak terlalu dipakai oleh CLI,
// tapi bagus untuk jika package ini mau di-import oleh package Node lain.

export { createExport } from './core/exporter.js';
export { logger } from './core/logger.js';
export { getProjectRoot, getToolsRoot, getExportsDir, getOvhlToolsRoot } from './utils/pathHelper.js';
EOF

echo "   ✅ index.js dibuat"

# ==========================================
# FASE 8: MEMBUAT README
# ==========================================
echo -e "${GREEN}📖 Fase 8: Membuat README (Versi Future-Proof)...${NC}"

cat > "$BASE_DIR/README.md" << 'EOF'
# 🚀 OVHL Tools (v2 - Dinamis)

Modular development tools untuk proyek OVHL. CLI ini otomatis mendeteksi tools baru.

## 📦 Instalasi (Cukup 1x)

1.  Pastikan skrip `magic-setup.sh` ada di dalam folder `Tools/`.
2.  Masuk ke folder `Tools/`:
    ```bash
    cd /path/to/Tools
    ```
3.  Jalankan skrip setup:
    ```bash
    bash magic-setup.sh
    ```
4.  Masuk ke folder tool yang baru dibuat, install, dan link:
    ```bash
    cd ovhl-tools
    npm install
    npm link
    ```

## 🎮 Penggunaan

Setelah di-link, Anda bisa jalankan dari folder manapun (termasuk root `OVHL_OS/`):

```bash
# Panggil menu utama
ovhl-tools

# atau
ovhl
```

## 🔧 Menambah Tool Baru (Future-Proof!)

Ini bagian terbaiknya. Untuk menambah tool baru:

1.  Buat folder baru di dalam `Tools/ovhl-tools/tools/`. 
    Contoh: `Tools/ovhl-tools/tools/context-generator`

2.  Buat file `config.json` di dalam folder tool baru itu:
    ```json
    {
      "name": "Generator Konteks",
      "slug": "konteks",
      "description": "Buat konteks file untuk AI",
      "emoji": "🤖",
      "main": "run"
    }
    ```

3.  Buat file `index.js` di dalam folder tool baru itu dan *export* fungsi yang namanya sama dengan `main` di config:
    ```javascript
    import { logger } from '../../core/logger.js';

    // Nama fungsi ini ('run') harus sama dengan "main" di config.json
    export async function run() {
      logger.info('Tool Generator Konteks jalan!');
      // ...tambahkan logikamu di sini...
    }
    ```

4.  **Selesai.**
    Jalankan `ovhl-tools` lagi. Tool baru Anda akan **otomatis muncul di menu**.

## 📁 Output

Semua ekspor dari tool (seperti laporan audit) akan disimpan di:
`Tools/Exports/YYYY-MM-DD/`

## 🗂️ Struktur Proyek (Baru)
```
OVHL_OS/
├── Source/
├── Tools/
│   ├── Exports/
│   ├── ovhl-tools/  <-- INI FOLDER TOOL UTAMA
│   │   ├── bin/
│   │   │   └── cli.js         # <-- CLI Dinamis (Auto-detect)
│   │   ├── core/
│   │   ├── node_modules/
│   │   ├── tools/
│   │   │   ├── audit-generator/
│   │   │   │   ├── config.json
│   │   │   │   └── index.js
│   │   │   └── (tool-baru-Anda)/
│   │   │       ├── config.json
│   │   │       └── index.js
│   │   ├── utils/
│   │   │   └── pathHelper.js  # <-- Path sudah di-update
│   │   ├── .gitignore
│   │   ├── index.js
│   │   ├── package.json
│   │   └── README.md
│   └── magic-setup.sh         # <-- File skrip ini
└── default.project.json
```

## 📝 License
MIT © Hanif Saifudin
EOF

echo "   ✅ README.md dibuat"

# ==========================================
# FASE 9: MEMBUAT .GITIGNORE
# ==========================================
echo -e "${GREEN}🚫 Fase 9: Membuat .gitignore...${NC}"

cat > "$BASE_DIR/.gitignore" << 'EOF'
node_modules/
*.log
.DS_Store
EOF

echo "   ✅ .gitignore dibuat"

# ==========================================
# RINGKASAN AKHIR
# ==========================================
echo ""
echo -e "${CYAN}============================================${NC}"
echo -e "${GREEN}✨ MAGIC SETUP (v2) SELESAI! ✨${NC}"
echo -e "${CYAN}============================================${NC}"
echo ""
echo -e "${YELLOW}📋 APA YANG DIBUAT:${NC}"
echo "   ✅ Struktur folder baru di 'Tools/ovhl-tools/'"
echo "   ✅ Interface CLI dinamis (Auto-detect tools baru)"
echo "   ✅ Tool Audit Generator (logika prompt dipindah)"
echo "   ✅ Path helper diperbarui untuk struktur baru"
echo "   ✅ README.md dengan instruksi 'Future-Proof'"
echo ""
echo -e "${CYAN}🎯 LANGKAH BERIKUTNYA:${NC}"
echo ""
echo -e "${GREEN}1. Install & Link (WAJIB 1x):${NC}"
echo -e "   (Pastikan Anda masih di folder ${CYAN}Tools/${NC})"
echo "   cd ovhl-tools"
echo "   npm install"
echo "   npm link"
echo ""
echo -e "${GREEN}2. Jalankan dari MANAPUN (Root folder, dll):${NC}"
echo "   ovhl-tools"
echo ""
echo -e "${YELLOW}📂 Hasil ekspor akan disimpan di:${NC}"
echo "   Tools/Exports/YYYY-MM-DD/"
echo ""
echo -e "${CYAN}============================================${NC}"
echo -e "${GREEN}🎉 Siap dipakai! Selamat bekerja! 🚀${NC}"
echo -e "${CYAN}============================================${NC}"
echo ""

