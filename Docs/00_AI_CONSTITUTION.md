# 📖 00_AI_CONSTITUTION.MD - Protokol Inti & Aturan AI

| 🏛️ **Project** | Omniverse Highland (OVHL)                         |
| :------------- | :------------------------------------------------ |
| 📄 **Dokumen** | Konstitusi Inti, Aturan AI, dan Protokol Workflow |
| 🏷️ **Versi**   | **10.2.0 (Revisi V10 + Protokol Git V10)**        |
| 👑 **Founder** | Hanif Saifudin                                    |
| 🗓️ **Update**  | 25 Oktober 2025                                   |
| 🚨 **Status**  | **WAJIB DIBACA DAN DIPATUHI OLEH AI & DEVELOPER** |

---

## 📜 1.0 ATURAN MUTLAK AI (AI BOOTLOADER #0)

- (🇮🇩) Perintah ini wajib di-load AI sebelum memproses request apapun.
- (🇬🇧) **These commands MUST be loaded by the AI before processing any request.**

### 1.1 🛡️ CORE MANDATES (ATURAN INTI)

#### 1.1.1 🤖 Workflow "Smart Library" V10 (Wajib)

- (🇮🇩) Semua operasi file (create, update, delete) **WAJIB** dieksekusi melalui **"Smart Script" `kurir.js`** atau **"Dumb Script" `kurir.sh`** yang di-generate AI.
- (🇬🇧) **All file operations MUST be executed via an AI-generated `kurir.js` (Smart Script) or `kurir.sh` (Dumb Script).**

#### 1.1.2 🚫 Protokol "Tukang" (Wajib)

- (🇮🇩) AI (sebagai "Mandor") **DILARANG KERAS** menulis logic file system mentah (`fs.mkdir`, `fs.writeFile`) atau logic logger mentah (`console.log`).
- (🇬🇧) **The AI "Foreman" is FORBIDDEN from writing raw `fs` or `console.log` logic.**

#### 1.1.3 🔒 Protokol Core (Konteks Wajib)

- (🇮🇩) Aturan folder `src/core/` (di `replicated` atau `serverstorage`) bergantung pada Misi:
  - **Saat Misi `Module-Dev`: DILARANG KERAS** memodifikasi `src/core/`.
  - **Saat Misi `Core-Dev`: DIIZINKAN** memodifikasi `src/core/` setelah konfirmasi (Ref: `1.3`).
- (🇬🇧) **The rule for `src/core/` is Mission-dependent.**

#### 1.1.4 ✍️ No Placeholders (Wajib)

- (🇮🇩) AI **DILARANG KERAS** menggunakan _placeholder_ (seperti `... (dst) ...`). Semua skrip `kurir.js` atau `kurir.sh` harus **100% LENGKAP** dan siap eksekusi/simpan.
- (🇬🇧) **AI is FORBIDDEN from using placeholders. All scripts must be 100% COMPLETE.**

#### 1.1.5 📦 Protokol "Segel Ganda" V11 (Wajib Baru)

- (🇮🇩) AI **WAJIB** membungkus _setiap_ blok kode yang di-generate dengan metadata "Segel Ganda" V11 (Header & Footer). Ini untuk memastikan integritas _tracking_ manual.
- (🇬🇧) **AI MUST wrap _every_ generated code block with the "Dual Seal" V11 metadata (Header & Footer) to ensure manual tracking integrity.**

---

### 1.2 🧠 AI AUTONOMY & STRATEGY

- (🇮🇩) Tugas AI adalah memenuhi "Misi" dengan menyediakan "Rencana Eksekusi" (`kurir.js` atau `kurir.sh`) yang paling efektif, aman, dan patuh pada package `ovhl-tools`.
- (🇬🇧) **The AI's task is to fulfill the "Mission" by providing an Execution Plan that adheres to the `ovhl-tools` package.**

---

### 1.3 ⚖️ CONFLICT RESOLUTION

- (🇮🇩) Jika permintaan Developer **BERKONFLIK** dengan protokol (misal: melanggar `1.1.3`), AI **WAJIB**: 1. **STOP**. 2. **CITE** (Sebutkan protokol). 3. **WARN** (Jelaskan risiko). 4. **CONFIRM** (Minta konfirmasi).
- (🇬🇧) **If a request conflicts with a Protocol, AI MUST: 1. STOP. 2. CITE. 3. WARN. 4. CONFIRM.**

---

### 1.4 ⚡ WORKFLOW V10 (WAJIB)

- (🇮🇩) Ini adalah alur kerja standar kita. AI akan memilih Primer atau Fallback.

#### 1.4.1 Primer: Workflow "Smart Library" (`kurir.js`)

1.  **Developer (Anda)** memberikan "Misi".
2.  **AI (Saya)** menganalisis misi dan men-generate satu **"Smart Script" `kurir.js`**.
3.  **Smart Script** ini WAJIB `import` dan menggunakan "Perpustakaan Tukang" dari package NPM **`ovhl-tools`** (Ref: `4.3.1`).
4.  **Developer (Anda)** meng-copy-paste skrip tersebut ke `kurir.js`.
5.  **Developer (Anda)** menjalankan `node kurir.js` di terminal.
6.  **Logger Tool** (dari `ovhl-tools`) akan mencetak progres.

#### 1.4.2 Fallback: Workflow "Dumb CLI" (`kurir.sh`)

1.  Jika `kurir.js` bermasalah atau Misi sangat sederhana, AI akan generate **"Dumb Script" `kurir.sh`**.
2.  Script ini **DILARANG** berisi logika. Isinya HANYA daftar panggilan CLI ke `ovhl-tools` (misal: `npx ovhl-tools create module ...`).
3.  **Developer (Anda)** meng-copy-paste skrip tersebut ke `kurir.sh`.
4.  **Developer (Anda)** menjalankan `bash kurir.sh` di terminal.
5.  **Logger Tool** (yang ada _di dalam_ CLI `ovhl-tools`) akan mencetak progres.

---

## 🌳 2.0 PROTOKOL GIT & BRANCHING (V10)

### 2.1 🛡️ Branch Check (Wajib AI)

- (🇮🇩) Di awal setiap sesi kerja baru atau sebelum memberikan Misi, AI **WAJIB** bertanya kepada Developer: `"Bro, lu lagi di branch apa sekarang?"`.
- (🇬🇧) **At the start of each new session, AI MUST ask the Developer: `"Bro, what branch are you on right now?"`**

### 2.2 🔒 Branch Proteksi (Wajib Developer)

- (🇮🇩) Branch `main` dan `dev` **DILARANG KERAS** di-push atau di-merge langsung. Semua pekerjaan **WAJIB** dilakukan di _feature branch_ baru.
- (🇬🇧) **`main` and `dev` branches are PROTECTED. All work MUST be done in a new feature branch.**

```bash
# WORKFLOW GIT YANG BENAR:
# 1. Selalu mulai dari 'dev' yang terbaru
git checkout dev
git pull origin dev

# 2. Buat branch baru untuk fitur/bugfix lu
git checkout -b feature/nama-fitur-keren

# 3. Kerjain Misi (ngoding bareng AI, eksekusi kurir.js)
# ... (kerja, kerja, kerja) ...

# 4. Commit pekerjaan lu
git add .
git commit -m "feat: Nambahin modul inventory"

# 5. Push branch baru lu ke remote
git push origin feature/nama-fitur-keren

# 6. Buat Pull Request (PR) di GitHub dari 'feature/...' ke 'dev'
```

### 2.3 ✍️ Bantuan Commit (Tugas AI)

- (🇮🇩) Jika diminta, AI **WAJIB** membantu Developer membuat deskripsi commit yang rapi dan informatif (mengikuti standar _Conventional Commits_ jika memungkinkan).
- (🇬🇧) **If requested, AI MUST help the Developer write clean and informative commit descriptions.**

---

## 🏗️ 3.0 WORKFLOW DEVELOPMENT & STRUKTUR

### 3.1 🔄 Siklus Development Harian (Workflow V10)

1.  **CHECK-IN:** AI konfirmasi branch (`git branch`). Developer pastikan ada di `feature/...` (Ref: `2.1`, `2.2`).
2.  **MISSION:** Developer memberi "Misi".
3.  **GENERATE:** AI men-generate **"Smart Script `kurir.js`"** ATAU **"Dumb Script `kurir.sh`"** (Ref: `1.4`).
4.  **EXECUTE:** Developer meng-copy-paste skrip dan menjalankan (`node kurir.js` / `bash kurir.sh`).
5.  **AUDIT:** `logger` (dari `ovhl-tools`) mencetak laporan.
6.  **COMMIT:** Developer `git add .` dan minta bantuan AI untuk pesan `git commit` (Ref: `2.3`).

### 3.2 🗺️ Referensi Struktur Proyek (V10 - WAJIB HAFAL AI)

- (🇮🇩) AI wajib menggunakan _path relatif `lowercase` (`src/`)_ ini sesuai standar "Rojo Hybrid Fix" yang terbukti work. Struktur `Source/PascalCase` **USANG**.
- (🇬🇧) **AI must use these `lowercase` (`src/`) paths following the proven "Rojo Hybrid Fix" standard. `Source/PascalCase` structures are OBSOLETE.**

```text
📁 ./                       <-- ROOT PROJECT (OVHL_OS/)
├── 📁 .git/
├── 📄 .gitignore
├── 📁 docs/                   ✅ READ/WRITE (Dokumentasi Proyek)
│   ├── 📄 00_AI_CONSTITUTION.md
│   ├── 📄 01_OVHL_ENGINE_SPEC.md
│   ├── 📄 02_OVHL_MODULE_ARCHITECTURE.md
│   ├── 📄 03_OVHL_BUILDER_GUIDE.md
│   └── 📄 04_DEV_LOGS.md
├── 📁 src/                    ✅ READ/WRITE (Kode Game)
│   ├── 📁 client/              (Entrypoint Client)
│   │   └── 📄 Main.client.lua
│   ├── 📁 replicated/
│   │   ├── 📁 Core/            (Core Client & Shared)
│   │   │   ├── 📁 Kernel/
│   │   │   ├── 📁 Services/
│   │   │   └── ...
│   │   ├── 📁 Modules/         (Modul Client & Shared)
│   │   │   └── 📁 pingpong/
│   │   └── 📁 Shared/
│   │       └── 📁 Utils/
│   ├── 📁 server/              (Entrypoint Server)
│   │   └── 📄 Main.server.lua
│   └── 📁 serverstorage/
│       ├── 📁 Core/            (Core Server)
│       │   ├── 📁 Kernel/
│       │   ├── 📁 Services/
│       │   └── ...
│       └── 📁 Modules/         (Modul Server)
│           └── 📁 pingpong/
├── 📁 Tools/                   (Tools non-NPM)
│   └── 📄 .gitkeep
├── 📄 default.project.json     (Rojo Config V10 "Hybrid Fix")
├── 📄 package.json
├── 📄 package-lock.json
├── 📄 kurir.js                 <-- "Mandor Misi" Primer (Smart Script)
├── 📄 kurir.sh                 <-- "Mandor Misi" Fallback (Dumb Script)
└── 📁 node_modules/
    └── 📁 ovhl-tools/          (WAJIB DI-IMPORT DARI SINI)
```

---

## 🤖 4.0 PERILAKU AI CO-PILOT (Rules of Engagement)

### 4.1 ✅ AI WAJIB Lakukan (MUST-DO)

- `CHECK_BRANCH` (Ref: `2.1`): WAJIB tanya branch Developer di awal sesi.
- `USE_TOOLS_LIBRARY` (Ref: `1.1.2`, `1.4`): WAJIB `import` dari `ovhl-tools` (untuk `.js`) atau panggil CLI `npx ovhl-tools` (untuk `.sh`).
- `ADHERE_TO_STRUCTURE` (Ref: `3.2`): WAJIB pakai path `lowercase` (misal: `src/replicated/Modules/nama_modul`).
- `GENERATE_FULL_SCRIPT` (Ref: `1.1.4`): WAJIB generate skrip 100% lengkap.
- `USE_DUAL_SEAL` (Ref: `1.1.5`): WAJIB pakai metadata "Segel Ganda" V11.

### 4.2 ❌ AI DILARANG Lakukan (FORBIDDEN)

- 🚫 `RAW_FS_LOGIC`: Dilarang nulis `fs.mkdir`, `fs.writeFile`, `console.log` mentah di `kurir.js`.
- 🚫 `RAW_LOGIC_SH`: Dilarang nulis logika `echo`, `mkdir`, `touch` mentah di `kurir.sh`.
- 🚫 `USE_OLD_PATHS`: Dilarang pake path `Source/PascalCase/` atau `Tools/ovhl-tools/`.
- 🚫 `DIRECT_MERGE`: Dilarang menyarankan `git merge dev` atau `git push origin dev` (Ref: `2.2`).

---

### 4.3 🎭 CONTOH PERILAKU AI (V10 - KONTRAK WAJIB)

- (🇮🇩) Ini adalah _template_ resmi untuk Protokol "Segel Ganda". Jika Developer minta "Bikin modul `teleportsystem`", AI **WAJIB** men-generate salah satu dari dua format di bawah ini.

#### 4.3.1 Contoh Primer (`kurir.js` - Smart Library)

```javascript
// ------------------------------------------------
// 📄 FILE: kurir.js
// 📍 PATH: ./kurir.js
// 🏛️ STUDIO: (N/A - File tool)
// 👨‍💻 AUTHOR: Omniverse Highland Studio
// 🎯 MISI: Buat Modul 'TeleportSystem' (via Smart Library).
// ------------------------------------------------

// Import 'path' bawaan Node.js
import path from "path";

// ==========================================================
// KONTRAK TOOLS WAJIB (IMPORT DARI NPM `ovhl-tools`)
// ==========================================================
// Asumsi 'ovhl-tools' mengekspor fungsi-fungsi ini:
import { logger, getTemplate, ensureDir, writeFile } from "ovhl-tools";
// ==========================================================

// --- KONFIGURASI MISI ---
const MISI = "Buat Modul 'TeleportSystem'";
const NAMA_MODUL_LOWER = "teleportsystem";
const NAMA_MODUL_PASCAL = "TeleportSystem";

// Path BARU (lowercase) sesuai Konstitusi V10 (Ref: 3.2)
const MODULE_PATH_RELATIF = `src/replicated/Modules/${NAMA_MODUL_LOWER}`;
const MODULE_PATH_ABSOLUT = path.resolve(process.cwd(), MODULE_PATH_RELATIF);

// --- LOGIKA SPESIFIK DARI AI (Isian A-Z) ---
const LOGIKA_AI_HANDLER_CLIENT = `
    print("Logika spesifik AI untuk TeleportSystem (CLIENT) dimulai di sini!")
    
    self.EventService:Subscribe("player_teleported", function(data)
        print(string.format("[TeleportSystem] Player %s tiba di %s", data.player.Name, data.destination))
    end)
`;
// ---------------------------------------------

async function runMission() {
  logger.info(`🚀 [KURIR MISI] Memulai: ${MISI}`);

  try {
    // --- FASE 1: Buat Folder ---
    logger.startSpinner(`Membuat direktori modul: ${MODULE_PATH_RELATIF}`);
    // Panggil 'ensureDir' DARI `ovhl-tools`
    await ensureDir(MODULE_PATH_ABSOLUT);
    logger.succeedSpinner(`Direktori siap.`, MODULE_PATH_ABSOLUT);

    // --- FASE 2: Tulis File dari Template ---

    // 1. Buat manifest.lua
    logger.startSpinner("Memproses manifest.lua...");
    // Panggil 'getTemplate' DARI `ovhl-tools`
    const manifestContent = await getTemplate("manifest.lua", {
      __PASCAL_NAME__: NAMA_MODUL_PASCAL,
      __LOWER_NAME__: NAMA_MODUL_LOWER,
      // ... (variabel template lain)
    });
    const manifestPath = path.join(MODULE_PATH_ABSOLUT, "manifest.lua");
    // Panggil 'writeFile' DARI `ovhl-tools`
    await writeFile(manifestPath, manifestContent);
    logger.succeedSpinner(`manifest.lua berhasil ditulis.`, manifestPath);

    // 2. Buat Handler.client.lua
    logger.startSpinner(`Memproses ${NAMA_MODUL_PASCAL}.client.lua...`);
    const handlerContent = await getTemplate("handler.client.lua", {
      __PASCAL_NAME__: NAMA_MODUL_PASCAL,
      __LOGIKA_AI_DI_SINI__: LOGIKA_AI_HANDLER_CLIENT,
    });
    const handlerPath = path.join(
      MODULE_PATH_ABSOLUT,
      `${NAMA_MODUL_PASCAL}.client.lua`
    );
    await writeFile(handlerPath, handlerContent);
    logger.succeedSpinner(
      `${NAMA_MODUL_PASCAL}.client.lua berhasil ditulis.`,
      handlerPath
    );

    // ... (Tulis file lain: Config, server handler, dll.)

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

// ------------------------------------------------
// 🏁 End of: ./kurir.js
// ------------------------------------------------
```

#### 4.3.2 Contoh Fallback (`kurir.sh` - Dumb CLI)

```bash
#!/bin/bash
# ------------------------------------------------
# 📄 FILE: kurir.sh
# 📍 PATH: ./kurir.sh
# 🏛️ STUDIO: (N/A - File tool)
# 👨‍💻 AUTHOR: Omniverse Highland Studio
# 🎯 MISI: Buat Modul 'TeleportSystem' (via Dumb CLI).
# ------------------------------------------------

# AI DILARANG nulis 'echo' atau 'mkdir' di sini.
# Biarkan tool 'ovhl-tools' yang menangani semua log.

# Panggil tool CLI (asumsi 'ovhl-tools' sudah di-register)
npx ovhl-tools create module --name teleportsystem --type client-server

# Cek status error terakhir
if [ $? -ne 0 ]; then
  # Satu-satunya echo yang diizinkan adalah laporan final
  echo "❌ [KURIR MISI] Misi GAGAL. Cek log di atas."
  exit 1
fi

echo "✅ [KURIR MISI] Misi Selesai."

# ------------------------------------------------
# 🏁 End of: ./kurir.sh
# ------------------------------------------------
```

> "The future is not written. It is built by us." 🚀

---

**END OF DOCUMENT**

## _Copyright © 2025 - Omniverse Highland Studio_
