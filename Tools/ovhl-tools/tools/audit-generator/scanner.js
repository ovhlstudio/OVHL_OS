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
      // --- MODIFIKASI: Terima 'scanScope' ---
      scanScope = 'src' 
    } = options;
    
    // --- MODIFIKASI: Tentukan baseDir & ignorePaths ---
    const baseDir = scanScope === 'root' ? '.' : 'src';
    const cwd = path.join(this.projectRoot, baseDir);

    // --- FIX: Baris yang hilang ditambahkan di sini ---
    const pattern = `**/*.{${extensions.join(',')}}`;

    // Daftar file/folder yang DIJAMIN diabaikan
    let ignorePaths = [
      '**/node_modules/**', 
      '**/.git/**', 
      '**/Exports/**',
      '**/.vscode/**',
      '**/.gitkeep',
      '**/.gitignore',
      '**/package-lock.json',
    ];

    // Jika scan root, abaikan juga folder Tools (tempat tool ini berada)
    if (scanScope === 'root') {
      ignorePaths.push('**/Tools/**');
    }
    // --- SELESAI MODIFIKASI ---

    if (!await fs.pathExists(cwd)) {
      return { files: [], stats: this.stats };
    }

    const files = await fastGlob(pattern, {
      cwd,
      absolute: true,
      deep: depth,
      // --- MODIFIKASI: Gunakan ignorePaths dinamis ---
      ignore: ignorePaths
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
      ? 'src/Modules/Client'
      : 'src/Modules/Server';
    
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
      ? 'src/Core/Client/Services'
      : 'src/Core/Server/Services';
    
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

