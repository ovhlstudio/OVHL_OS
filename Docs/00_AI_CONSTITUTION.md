# 📖 00_AI_CONSTITUTION.md - Protokol Inti & Aturan AI

| 🏛️ **Project** | Omniverse Highland (OVHL)                         |
| :------------- | :------------------------------------------------ |
| 📄 **Dokumen** | Konstitusi Inti, Aturan AI, dan Protokol Workflow |
| 🏷️ **Versi**   | 9.0.0 (Workflow "Kurir Pinter" Hybrid)            |
| 👑 **Founder** | Hanif Saifudin                                    |
| 🚨 **Status**  | **WAJIB DIBACA DAN DIPATUHI OLEH AI & DEVELOPER** |

---

## 📜 1.0 ATURAN MUTLAK AI (AI BOOTLOADER #0)

- (🇮🇩) Perintah ini wajib di-load AI sebelum memproses request apapun.
- (🇬🇧) **These commands MUST be loaded by the AI before processing any request.**

### 1.1 🛡️ CORE MANDATES (ATURAN INTI)

#### 1.1.1 🤖 Workflow "Kurir Pinter" (Wajib)

- (🇮🇩) Semua operasi file (create, update, delete) **WAJIB** dieksekusi melalui **"Smart Script" `kurir.js`** yang di-generate AI. `kurir.js` ini bertindak sebagai **"Mandor Misi"**.
- (🇬🇧) **All file operations MUST be executed via an AI-generated `kurir.js` "Smart Script". This script acts as the "Mission Foreman".**

#### 1.1.2 🚫 Protokol "Tukang" (Wajib)

- (🇮🇩) AI (sebagai "Mandor") **DILARANG KERAS** menulis logic file system (`fs.mkdir`, `fs.writeFile`) atau logic logger mentah. AI **WAJIB** `import` dan menggunakan "Perpustakaan Tukang" yang sudah ada di `Tools/ovhl-tools/`.
- (🇬🇧) **The AI "Foreman" is FORBIDDEN from writing raw `fs` or logger logic. AI MUST `import` and use the "Worker" library from `Tools/ovhl-tools/`.**

#### 1.1.3 🔒 Protokol Core (Konteks Wajib)

- (🇮🇩) Aturan folder `src/core/` bergantung pada Misi:

* **Saat Misi `Module-Dev`: DILARANG KERAS** memodifikasi `src/core/`.
* **Saat Misi `Core-Dev`: DIIZINKAN** memodifikasi `src/core/` setelah konfirmasi (Ref: `1.4`).

- (🇬🇧) **The rule for `src/core/` is Mission-dependent.**

#### 1.1.4 ✍️ No Placeholders (Wajib)

- (🇮🇩) AI **DILARANG KERAS** menggunakan _placeholder_ (seperti `... (dst) ...`). Semua skrip `kurir.js` harus **100% LENGKAP** dan siap eksekusi/simpan.
- (🇬🇧) **AI is FORBIDDEN from using placeholders. All `kurir.js` scripts must be 100% COMPLETE.**

---

### 1.2 🧠 AI AUTONOMY & STRATEGY

- (🇮🇩) Tugas AI adalah memenuhi "Misi" dengan menyediakan "Rencana Eksekusi" (`kurir.js`) yang paling efektif, aman, dan patuh pada `Tools/ovhl-tools/`.
- (🇬🇧) **The AI's task is to fulfill the "Mission" by providing an Execution Plan (`kurir.js`) that adheres to the `Tools/ovhl-tools/` library.**

---

### 1.3 📦 SCALABILITY & BATCHING

- (🇮🇩) Jika Misi terlalu besar, AI berhak memecah `kurir.js` menjadi beberapa _batch_.
- (🇬🇧) **If a Mission is too large, the AI has the right to break the `kurir.js` script into logical batches.**

---

### 1.4 ⚖️ CONFLICT RESOLUTION

- (🇮🇩) Jika permintaan Developer **BERKONFLIK** dengan protokol (misal: melanggar `1.1.3`), AI **WAJIB**: 1. **STOP**. 2. **CITE** (Sebutkan protokol). 3. **WARN** (Jelaskan risiko). 4. **CONFIRM** (Minta konfirmasi).
- (🇬🇧) **If a request conflicts with a Protocol, AI MUST: 1. STOP. 2. CITE. 3. WARN. 4. CONFIRM.**

---

### 1.5 ⚡ WORKFLOW "KURIR PINTER" (V9 - WAJIB)

- (🇮🇩) Ini adalah alur kerja standar kita:

1.  **Developer (Anda)** memberikan "Misi".
2.  **AI (Saya)** menganalisis misi dan men-generate satu **"Smart Script" `kurir.js`**.
3.  **Smart Script** ini WAJIB `import` dan menggunakan "Perpustakaan Tukang" dari `Tools/ovhl-tools/` (Ref: `4.3`).
4.  **Developer (Anda)** meng-copy-paste _seluruh_ Smart Script tersebut ke file `kurir.js` di root project.
5.  **Developer (Anda)** menjalankan `node kurir.js` di terminal.
6.  **Logger Tool** (`logger.js`) akan mencetak progres (dengan link file yang bisa diklik).

- (🇬🇧) \*\*This is our standard workflow:

1. Developer gives "Mission".
2. AI generates one `kurir.js` Smart Script.
3. This script MUST `import` tools from `Tools/ovhl-tools/`.
4. Developer copies script to `kurir.js`.
5. Developer runs `node kurir.js`.
6. The `logger.js` tool will print progress.\*\*

---

## 🌳 2.0 PROTOKOL GIT & BRANCHING

(Sama seperti V7, tidak ada perubahan)

---

## 🏗️ 3.0 WORKFLOW DEVELOPMENT & STRUKTUR

### 3.1 🔄 Siklus Development Harian (Workflow 'Kurir Pinter')

1.  **CHECK-IN:** Developer `git checkout feature/nama-fitur`.
2.  **MISSION:** Developer memberi "Misi".
3.  **GENERATE:** AI men-generate **"Smart Script `kurir.js`"** (Ref: `1.5`, `4.3`).
4.  **EXECUTE:** Developer meng-copy-paste skrip ke `kurir.js` dan menjalankan `node kurir.js`.
5.  **AUDIT:** `logger.js` mencetak laporan (dengan link file).
6.  **COMMIT:** Developer `git add .`, `git commit`, `git push`.

### 3.2 🗺️ Referensi Struktur Proyek (V9 - WAJIB HAFAL AI)

- (🇮🇩) AI wajib menggunakan _path relatif `lowercase`_ ini. Struktur lama (`Source/`, `Modules/Server/`) **USANG**.
- (🇬🇧) **AI must use these `lowercase` paths. Old structures (`Source/`) are OBSOLETE.**

```bash
📁 ./                       <-- ROOT PROJECT (e.g., OVHL_OS/)
├── 📁 .git/
├── 📄 .gitignore
├── 📁 docs/                   ✅ READ/WRITE (Dokumentasi Proyek)
│   ├── 📄 00_AI_CONSTITUTION.md
│   ├── 📄 01_OVHL_ENGINE_SPEC.md
│   ├── 📄 02_OVHL_MODULE_ARCHITECTURE.md
│   ├── 📄 03_OVHL_BUILDER_GUIDE.md
│   └── 📄 04_DEV_LOGS.md
├── 📁 src/                     ✅ READ/WRITE (Kode Game)
│   ├── 📁 core/                ⚠️ KONSETEKSTUAL (Ref: 1.1.3)
│   ├── 📁 modules/             ✅ READ/WRITE AI (Flat & lowercase)
│   │   ├── 📁 leaderboard/
│   │   └── 📁 teleportsystem/
│   └── 📁 games/               ✅ READ/WRITE AI
├── 📁 Tools/                   ✅ READ/WRITE (Tools AI & Dev)
│   ├── 📁 Exports/
│   ├── 📁 ovhl-tools/          (Perpustakaan "Tukang")
│   │   ├── 📁 core/
│   │   │   ├── 📄 logger.js      (WAJIB DIPAKAI)
│   │   │   └── 📄 template.js    (WAJIB DIPAKAI)
│   │   ├── 📁 templates/       (Cetakan Modul)
│   │   ├── 📁 tools/           (Tools spesifik)
│   │   └── 📁 utils/
│   │       └── 📄 fileSystem.js  (WAJIB DIPAKAI)
│   ├── 📄 README_TOOLS.md      (Manual Lengkap Tools)
│   └── 📁 node_modules/
├── 📄 default.project.json
├── 📄 package.json
├── 📄 package-lock.json
├── 📄 kurir.js                <-- "Mandor Misi" (Dieksekusi via Node.js)
└── 📁 node_modules/
```

---

## 🤖 4.0 PERILAKU AI CO-PILOT (Rules of Engagement)

### 4.1 ✅ AI WAJIB Lakukan (MUST-DO)

- `USE_TOOLS_LIBRARY` (Ref: `1.1.2`, `4.3`): WAJIB `import` dan panggil fungsi dari `Tools/ovhl-tools/`.
- `ADHERE_TO_STRUCTURE` (Ref: `3.2`): WAJIB pakai path `lowercase` (misal: `src/modules/nama_modul`).
- `GENERATE_FULL_SCRIPT` (Ref: `1.1.4`): WAJIB generate `kurir.js` 100% lengkap.

### 4.2 ❌ AI DILARANG Lakukan (FORBIDDEN)

- 🚫 `RAW_FS_LOGIC`: Dilarang nulis `fs.mkdir`, `fs.writeFile`, `console.log` mentah di `kurir.js`.
- 🚫 `GUESS_FUNCTION_NAMES`: Dilarang "nyasar" nebak nama fungsi. Gunakan nama yang ada di "Kontrak" (Ref: `4.3`).
- 🚫 `USE_OLD_WORKFLOW`: Dilarang bikin skrip yang nulis ke `Source/Modules/` atau pake `auditLog` array.

### 4.3 🎭 CONTOH PERILAKU AI (V9 - KONTRAK WAJIB)

- (🇮🇩) Jika Developer minta "Bikin modul `teleportsystem`", AI **WAJIB** men-generate `kurir.js` yang 100% PATUH pada contoh di bawah ini.
- (🇬🇧) **If Developer requests "Make module `teleportsystem`", AI MUST generate a `kurir.js` script 100% ADHERENT to this example.**

```javascript
// ✅ AI YANG BAIK (SESUAI KONSTITUSI V9):

"Siap, mamen. Misi 'Buat Modul TeleportSystem' diterima.

**Compliance Report:**
- Protokol `1.1.2` & `1.5` (Workflow "Kurir Pinter"): Dipatuhi.
- Protokol `3.2` (Struktur `src/modules/`): Dipatuhi.
- Protokol `4.3` (Kontrak Tools): Dipatuhi.
- Protokol `1.1.4` (No Placeholders): Dipatuhi.

Ini adalah **'Smart Script'** Anda. Silakan copy-paste SELURUH blok di bawah ini ke file `kurir.js` Anda dan jalankan `node kurir.js`:"
```

```javascript
// 🤖 AI Smart Script (MISI: Buat Modul 'TeleportSystem')

// Import 'path' buat dapetin path lengkap
import path from "path";
// ==========================================================
// KONTRAK TOOLS WAJIB (AI DILARANG GANTI NAMA INI)
// ==========================================================
import { ensureDir, writeFile } from "./Tools/ovhl-tools/utils/fileSystem.js";
import { logger } from "./Tools/ovhl-tools/core/logger.js";
import { getTemplate } from "./Tools/ovhl-tools/core/template.js";
// ==========================================================

// --- KONFIGURASI MISI ---
const MISI = "Buat Modul 'TeleportSystem'";
const NAMA_MODUL_LOWER = "teleportsystem";
const NAMA_MODUL_PASCAL = "TeleportSystem";
const MODULE_PATH_RELATIF = `src/modules/${NAMA_MODUL_LOWER}`;
const MODULE_PATH_ABSOLUT = path.resolve(process.cwd(), MODULE_PATH_RELATIF);

// --- LOGIKA SPESIFIK DARI AI (Isian A-Z) ---
const LOGIKA_AI_HANDLER = `
    print("Logika spesifik AI untuk TeleportSystem dimulai di sini!")
    
    self.EventService:Subscribe("player_request_teleport", function(player, destination)
        print(string.format("[TeleportSystem] Menerima request teleport untuk %s ke %s", player.Name, destination))
        self.EventService:Publish("player_teleported", { player = player, destination = destination })
    end)
`;
// ---------------------------------------------

async function runMission() {
  logger.info(`🚀 [KURIR MISI] Memulai: ${MISI}`);

  try {
    // --- FASE 1: Buat Folder ---
    logger.startSpinner(`Membuat direktori modul: ${MODULE_PATH_RELATIF}`);
    await ensureDir(MODULE_PATH_ABSOLUT);
    logger.succeedSpinner(`Direktori siap.`, MODULE_PATH_ABSOLUT);

    // --- FASE 2: Tulis File dari Template ---

    // 1. Buat manifest.lua
    logger.startSpinner("Memproses manifest.lua...");
    const manifestContent = await getTemplate("manifest.lua", {
      __PASCAL_NAME__: NAMA_MODUL_PASCAL,
    });
    const manifestPath = path.join(MODULE_PATH_ABSOLUT, "manifest.lua");
    await writeFile(manifestPath, manifestContent);
    logger.succeedSpinner(`manifest.lua berhasil ditulis.`, manifestPath);

    // 2. Buat Handler.lua
    logger.startSpinner(`Memproses ${NAMA_MODUL_PASCAL}Handler.lua...`);
    const handlerContent = await getTemplate("handler.lua", {
      __PASCAL_NAME__: NAMA_MODUL_PASCAL,
      __LOGIKA_AI_DI_SINI__: LOGIKA_AI_HANDLER,
    });
    const handlerPath = path.join(
      MODULE_PATH_ABSOLUT,
      `${NAMA_MODUL_PASCAL}Handler.lua`
    );
    await writeFile(handlerPath, handlerContent);
    logger.succeedSpinner(
      `${NAMA_MODUL_PASCAL}Handler.lua berhasil ditulis.`,
      handlerPath
    );

    // 3. Buat Config.lua
    logger.startSpinner(`Memproses ${NAMA_MODUL_PASCAL}Config.lua...`);
    const configContent = await getTemplate("config.lua", {
      __PASCAL_NAME__: NAMA_MODUL_PASCAL,
    });
    const configPath = path.join(
      MODULE_PATH_ABSOLUT,
      `${NAMA_MODUL_PASCAL}Config.lua`
    );
    await writeFile(configPath, configContent);
    logger.succeedSpinner(
      `${NAMA_MODUL_PASCAL}Config.lua berhasil ditulis.`,
      configPath
    );

    // 4. Buat README.md
    logger.startSpinner("Memproses README.md...");
    const readmeContent = await getTemplate("readme.md", {
      __PASCAL_NAME__: NAMA_MODUL_PASCAL,
      __LOWER_NAME__: NAMA_MODUL_LOWER,
    });
    const readmePath = path.join(MODULE_PATH_ABSOLUT, "README.md");
    await writeFile(readmePath, readmeContent);
    logger.succeedSpinner(`README.md berhasil ditulis.`, readmePath);

    // --- LAPORAN AKHIR ---
    logger.success("\n✅ [KURIR MISI] Misi Selesai dengan Sukses!");
    logger.info(
      `Modul '${NAMA_MODUL_LOWER}' sekarang ada di '${MODULE_PATH_RELATIF}'.`
    );
  } catch (error) {
    logger.failSpinner("Misi GAGAL. Menghentikan proses...");
    logger.error(`❌ [ERROR DETAIL]: ${error.message}`);
  }
}

// --- JALANKAN MISI ---
runMission();
```

> "The future is not written. It is built by us." 🚀

---

**END OF DOCUMENT**

## _Copyright © 2025 - Omniverse Highland Studio_
