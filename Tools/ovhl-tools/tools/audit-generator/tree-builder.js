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
