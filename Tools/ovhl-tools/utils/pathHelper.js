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
