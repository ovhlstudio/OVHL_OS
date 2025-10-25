# 🛠️ README_TOOLS.md - Panduan Lengkap Toolchain OVHL

| 🏛️ **Project** | Omniverse Highland (OVHL)                             |
| :------------- | :---------------------------------------------------- |
| 📄 **Dokumen** | Panduan Penggunaan Toolchain Developer                |
| 🏷️ **Versi**   | 1.0.0 (Post-V9 Workflow Lock)                         |
| 👑 **Founder** | Hanif Saifudin                                        |
| 🚨 **Status**  | **WAJIB DIPATUHI UNTUK OPERASI DI FOLDER \`Tools/\`** |

---

## 1.0 Filosofi Workflow "Kurir Pinter"

Toolchain OVHL dioperasikan menggunakan model **Mandor & Tukang** (Ref: \`00_AI_CONSTITUTION.md 1.1.2\`).

1.  **Mandor (`kurir.js`):** Skrip _entry point_ yang di-generate AI. Tugasnya hanya memanggil fungsi (\`Tukang\`) sesuai urutan logis.
2.  **Tukang (`Tools/ovhl-tools/`):** Fungsi-fungsi inti (`logger`, `fileSystem`, `template`) yang melakukan tugas teknis (menulis file, membuat folder, logging). Tugas AI adalah mengintegrasikan fungsionalitas "Tukang" ini.

> 💡 **Aturan Kunci:** Jangan pernah memanggil fungsi di luar \`Tools/ovhl-tools/\` untuk operasi file.

---

## 2.0 Komponen Perpustakaan Inti

Folder \`Tools/ovhl-tools/\` berisi semua "Tukang" yang wajib diimpor oleh \`kurir.js\`.

| File/Folder       | Path Import Contoh      | Fungsi Utama                                                 | Keterangan                                                                                                          |
| :---------------- | :---------------------- | :----------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------ |
| \`logger.js\`     | \`core/logger.js\`      | \`logger.info\`, \`logger.success\`, \`logger.startSpinner\` | Menangani semua output konsol dan laporan status (dengan link yang bisa di-klik).                                   |
| \`fileSystem.js\` | \`utils/fileSystem.js\` | \`ensureDir\`, \`writeFile\`, \`readFile\`                   | Menangani semua operasi I/O (Input/Output) file.                                                                    |
| \`template.js\`   | \`core/template.js\`    | \`getTemplate(name, replace)\`                               | Digunakan oleh AI untuk mengambil "cetakan" modul (dari folder \`templates/\`) dan mengisi _placeholder_ logikanya. |
| \`templates/\`    | N/A                     | Cetakan Boilerplate                                          | Kumpulan file \`.lua.txt\` yang berisi kerangka Modul (Handler, Manifest, Config, README).                          |

---

## 3.0 Daftar Tools Developer (CLI)

Ini adalah daftar _tools_ yang sudah terimplementasi dan dapat digunakan untuk tugas _development_ spesifik.

### 3.1 🛠️ Tool: Module Scaffolder (Tool ke-3)

Tool ini dioperasikan sepenuhnya melalui skrip \`kurir.js\` dan digunakan untuk membuat Modul baru (Ref: \`00_AI_CONSTITUTION.md 4.3\`).

| Properti           | Detail                                                    |
| :----------------- | :-------------------------------------------------------- |
| **Lokasi Output**  | \`src/modules/[nama\_modul\_lowercase]/\`                 |
| **Tujuan**         | Membuat struktur Modul yang patuh 100% pada Konstitusi.   |
| **Fungsi Diimpor** | \`ensureDir\`, \`writeFile\`, \`getTemplate\`, \`logger\` |

**Contoh Penggunaan Wajib (AI Generated \`kurir.js\`):**

```javascript
// Menggunakan ensureDir untuk folder, getTemplate untuk isi, dan logger untuk feedback.
import path from 'path';
import { ensureDir, writeFile } from './Tools/ovhl-tools/utils/fileSystem.js';
import { logger } from './Tools/ovhl-tools/core/logger.js';
import { getTemplate } from './Tools/ovhl-tools/core/template.js';

// ... (logic konfigurasi misi) ...

await ensureDir(MODULE_PATH_ABSOLUT);
logger.succeedSpinner(`Direktori siap.`, MODULE_PATH_ABSOLUT);

const handlerContent = await getTemplate('handler.lua', { ... });
await writeFile(handlerPath, handlerContent);
logger.succeedSpinner(`Handler berhasil ditulis.`, handlerPath);

// ... (lanjutkan untuk config, manifest, readme) ...
```

### 3.2 🛠️ Tool: Audit Generator

Digunakan untuk memindai seluruh proyek (termasuk kode Lua) dan membuat laporan kesehatan.

| Properti             | Detail                                                                   |
| :------------------- | :----------------------------------------------------------------------- |
| **Lokasi File Inti** | \`Tools/ovhl-tools/tools/audit-generator/index.js\`                      |
| **Tujuan**           | Analisis kode, struktur, dan dependensi, serta membuat laporan Markdown. |
| **Output**           | File Markdown di \`Tools/Exports/\`                                      |
| **Cara Eksekusi**    | Interaktif melalui \`bin/cli.js\` (Seperti contoh di terminal)           |

### 3.3 🛠️ Tool: Dependency Checker

Digunakan untuk memvalidasi \`manifest.lua\` antar Modul dan Core Services untuk menghindari _dependency hell_.

| Properti             | Detail                                                     |
| :------------------- | :--------------------------------------------------------- |
| **Lokasi File Inti** | \`Tools/ovhl-tools/tools/dependency-checker/index.js\`     |
| **Tujuan**           | Memastikan semua \`depends\` di \`manifest.lua\` tersedia. |
| **Cara Eksekusi**    | Interaktif atau via _pre-commit hook_.                     |

---

## 4.0 PROTOKOL PENAMBAHAN TOOLS BARU

Jika Developer atau AI ingin menambahkan _tool_ baru (Misi Tipe Tools):

1.  **Buat Folder:** Buat folder baru di \`Tools/ovhl-tools/tools/\[nama_tool_lowercase]/\`.
2.  **Tulis Logic:** Tulis logic Node.js Anda di dalam folder tersebut (misal: \`index.js\`).
3.  **Wajib \`import\` Tools:** Logic tool baru **WAJIB** menggunakan \`fileSystem.js\` dan \`logger.js\` dari perpustakaan (Ref: \`00_AI_CONSTITUTION.md 1.1.2\`).
4.  **Dokumentasi:** Update file \`README_TOOLS.md\` ini dengan entri baru (Ref: \`4.1\`).
5.  **Eksekusi:** Tools baru diintegrasikan melalui \`bin/cli.js\` atau dipanggil langsung melalui skrip \`kurir.js\`.

### 4.1 📝 Contoh Entri Dokumentasi Baru (Wajib Diikuti)

```markdown
### 🛠️ Tool: Nama Tool Baru Anda

Digunakan untuk...

| Properti             | Detail                                   |
| :------------------- | :--------------------------------------- |
| **Lokasi File Inti** | \`Tools/ovhl-tools/tools/[nama\_tool]/\` |
| **Tujuan**           | [Deskripsi]                              |
| **Cara Eksekusi**    | [Jelaskan cara panggilnya]               |
```

---
