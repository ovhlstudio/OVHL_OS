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
