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
      
      // --- PERBAIKAN & AUDIT ---
      // Kalo 'main' gak ada di config.json, otomatis pake 'run'
      // Ini bikin 'future-proof' jadi gak crash kalo lupa nambahin 'main'
      const functionName = selectedTool.main || 'run';
      const runFunction = toolModule[functionName];
      // --- BATAS PERBAIKAN ---
      
      if (typeof runFunction === 'function') {
        await runFunction();
      } else {
        // Update error message biar lebih jelas
        logger.error(`Fungsi '${functionName}' tidak ditemukan di tool '${selectedTool.name}'.`);
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

