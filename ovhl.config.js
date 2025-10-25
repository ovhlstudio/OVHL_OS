/**
 * ======================================================
 * Konfigurasi OVHL-TOOLS v4.0.5
 * ======================================================
 * Digenerate: 2025-10-25T06:35:43.234Z
 * Auto-detected: Ya
 */
export default {
  base: 'src',

  paths: {
    serverModules: 'serverstorage/Modules',
    clientModules: 'replicated/Modules',
    sharedModules: 'replicated/Shared',
    templates: 'Tools/Templates',
    exports: 'Tools/Exports',
  },

  tools: {
    audit: {
      ignore: ['**/node_modules/**', '**/.git/**', '**/bin/**'],
      maxFileSize: 1048576, // 1MB
    },
    create: {
      defaultPlaceholders: {
        __AUTHOR__: 'OVHL Developer',
      },
    },
    'find-todos': {
      keywords: ['TODO:', 'FIXME:', 'NOTE:', 'HACK:']
    }
  },

  integrations: {
    git: {
      enabled: true,
      autoCommit: false,
    },
    cloud: {
      enabled: false,
      provider: 'notion',
      apiKey: process.env.CLOUD_API_KEY || '',
    },
    ai: {
      enabled: true,
      provider: 'openai',
      apiKey: process.env.AI_API_KEY || '',
    }
  },
};