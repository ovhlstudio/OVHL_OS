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
