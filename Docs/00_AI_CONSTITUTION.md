# 📖 00_AI_CONSTITUTION.md - Protokol Inti & Aturan AI

> 🏛️ **Project:** Omniverse Highland (OVHL)
> 📄 **Dokumen:** Konstitusi Inti, Aturan AI, dan Protokol Workflow
> 🏷️ **Versi:** 7.0.0 (Final w/ Corrected Paths)
> 👑 **Founder:** Hanif Saifudin
> 🚨 **Status:** **WAJIB DIBACA DAN DIPATUHI OLEH AI & DEVELOPER**

---

## 📜 1.0 ATURAN MUTLAK AI (AI BOOTLOADER #0)

> (🇮🇩) Perintah ini wajib di-load AI sebelum memproses request apapun.
> (🇬🇧) **These commands MUST be loaded by the AI before processing any request.**

### 1.1 🛡️ CORE MANDATES (ATURAN INTI)

> (🇮🇩) Pelanggaran terhadap aturan ini = Kegagalan Misi Otomatis.
> (🇬🇧) **Violation of these rules = Automatic Mission Failure.**

#### 1.1.1 🤖 Smart-Script Execution (Wajib)

(🇮🇩) Semua operasi file (create, update, delete, scaffold) **WAJIB** dieksekusi melalui **"Smart Script" Node.js** yang di-generate AI.
(🇬🇧) **All file operations (create, update, delete, scaffold) MUST be executed via an AI-generated Node.js "Smart Script".**

#### 1.1.2 🚫 No Manual Code (Wajib)

(🇮🇩) AI **DILARANG KERAS** memberikan blok kode (Lua, dll) mentah untuk di-copy-paste manual oleh Developer. Pengecualian **HANYA** untuk "Smart Script" yang akan dieksekusi via `kurir.js`.
(🇬🇧) **AI is FORBIDDEN from providing raw code blocks (Lua, etc.) for manual copy-pasting. The ONLY exception is the "Smart Script" intended for execution via `kurir.js`.**

#### 1.1.3 🔒 Protokol Core (Konteks Wajib)

(🇮🇩) Aturan folder `Source/Core/` bergantung pada Misi:

- **Saat Misi `Module-Dev`: DILARANG KERAS** memodifikasi `Source/Core/`.
- **Saat Misi `Core-Dev`: DIIZINKAN** memodifikasi `Source/Core/` setelah konfirmasi eksplisit (Ref: `1.4`).

(🇬🇧) **The rule for `Source/Core/` is Mission-dependent:**

- **During `Module-Dev` Missions: FORBIDDEN** to modify `Source/Core/`.
- **During `Core-Dev` Missions: ALLOWED** to modify `Source/Core/` after explicit confirmation (Ref: `1.4`).\*\*

#### 1.1.4 ✍️ No Placeholders (Wajib)

(🇮🇩) AI **DILARANG KERAS** menggunakan _placeholder_ (seperti `... (konten sama) ...` atau `... (dst) ...`) saat men-generate file/skrip. Semua _output_ RAW Markdown atau skrip harus **100% LENGKAP** dan siap eksekusi/simpan.
(🇬🇧) **AI is FORBIDDEN from using placeholders (e.g., `... (content same) ...` or `... (etc) ...`) when generating files/scripts. All RAW Markdown or script outputs must be 100% COMPLETE and ready-to-execute/save.**

---

### 1.2 🧠 AI AUTONOMY & STRATEGY (OTONOMI & STRATEGI AI)

#### 1.2.1 🎯 Mission Objective (Tujuan Misi)

(🇮🇩) Tugas AI adalah memenuhi "Misi" (Permintaan Developer) dengan menyediakan "Rencana Eksekusi" (skrip) yang paling efektif, aman, dan _self-contained_ (bisa jalan sendiri).
(🇬🇧) **The AI's task is to fulfill the "Mission" (Developer's request) by providing the most effective, safe, and self-contained "Execution Plan" (script).**

#### 1.2.2 🛠️ Tool Selection (Pemilihan Alat)

(🇮🇩) AI **wajib** menggunakan **Node.js** untuk semua "Smart Script". Penggunaan `.sh` (Bash) dihilangkan untuk konsistensi dan mengurangi risiko.
(🇬🇧) **AI MUST use Node.js for all "Smart Scripts". The use of `.sh` (Bash) is eliminated for consistency and risk reduction.**

---

### 1.3 📦 SCALABILITY & BATCHING (SKALABILITAS & BATCH)

(🇮🇩) Jika "Misi" terlalu besar (misal: generate 10 modul), AI **berhak** memecah "Rencana Eksekusi" menjadi beberapa _batch_ (langkah) yang logis. AI wajib memberikan instruksi urutan eksekusi _batch_ tersebut dengan jelas.
(🇬🇧) **If a Mission is too large, the AI has the right to break the Execution Plan into logical batches. The AI must provide clear sequential instructions for each batch.**

---

### 1.4 ⚖️ CONFLICT RESOLUTION (RESOLUSI KONFLIK)

(🇮🇩) Jika permintaan Developer **BERKONFLIK** dengan protokol di Konstitusi ini (misal: melanggar `1.1.3 Core Read-Only`), AI **WAJIB**: 1. **STOP:** Hentikan proses. 2. **CITE:** Sebutkan protokol yang dilanggar (misal: `Pelanggaran Protokol 1.1.3`). 3. **WARN:** Jelaskan risikonya (misal: "Akan merusak Core Engine"). 4. **CONFIRM:** Minta konfirmasi eksplisit ("Apakah Anda yakin ingin melanjutkan? Ketik 'LANJUTKAN PELANGGARAN'").
(🇬🇧) **If a Developer request conflicts with a Protocol, AI MUST: 1. STOP. 2. CITE the violated protocol. 3. WARN of the risks. 4. Ask for explicit confirmation (e.g., 'Type 'CONFIRM VIOLATION') to proceed.**

---

### 1.5 ⚡ WORKFLOW KURIR (Workflow V4 - Wajib)

#### 1.5.1 📨 Alur Kerja 'kurir.js'

(🇮🇩) Ini adalah alur kerja standar kita:

1.  **Developer (Anda)** memberikan "Misi".
2.  **AI (Saya)** menganalisis misi dan men-generate satu **"Smart Script" Node.js** yang lengkap.
3.  **Developer (Anda)** meng-copy-paste _seluruh_ Smart Script tersebut ke file `kurir.js` di root project.
4.  **Developer (Anda)** menjalankan `node kurir.js` di terminal.
5.  **Smart Script** mengeksekusi misi dan memberikan laporan `console.log` real-time.
    (🇬🇧) **This is our standard workflow: 1. Developer gives "Mission". 2. AI generates one complete Node.js "Smart Script". 3. Developer copy-pastes the entire script into `kurir.js`. 4. Developer runs `node kurir.js`. 5. The Smart Script executes and provides real-time `console.log` reports.**

#### 1.5.2 🧬 Anatomi Smart Script (Wajib)

(🇮🇩) Setiap "Smart Script" yang di-generate AI WAJIB memiliki 3 fase: 1. **PHASE 1: PRE-CHECK:** Validasi kondisi awal (file/folder ada? konflik?). 2. **PHASE 2: EXECUTION:** Eksekusi tugas (membuat/memodifikasi file). 3. **PHASE 3: POST-AUDIT:** Validasi hasil (file beneran ada? isi beneran berubah?).
(🇬🇧) **Every "Smart Script" MUST have 3 phases: 1. PRE-CHECK, 2. EXECUTION, 3. POST-AUDIT.**

#### 1.5.3 🩹 Patching Protocol (Anti-Version-Hell)

(🇮🇩) "Smart Script" WAJIB mem-patch file yang ada _in-place_. **DILARANG** membuat file duplikat (cth: `_fix.js`).
(🇬🇧) **The "Smart Script" MUST patch existing files in-place. Creating new `_fix.js` files is FORBIDDEN.**

---

### 1.6 📊 STANDARD MISSION REPORTING (STANDAR LAPORAN MISI)

(🇮🇩) "Smart Script" yang dieksekusi oleh `kurir.js` **WAJIB** memberikan laporan progres yang jelas ke konsol menggunakan `console.log()`. Laporan ini harus mencantumkan status PRE-CHECK, EXEC, POST-AUDIT, dan Laporan Akhir Misi.
(🇬🇧) **The "Smart Script" executed by `kurir.js` MUST provide clear progress reports to the console using `console.log()`. This report must include PRE-CHECK, EXEC, POST-AUDIT statuses, and a Final Mission Report.**

#### 1.6.1 📝 Contoh Laporan Konsol (Kontrak Tampilan)

(🇮🇩) Ini adalah "kontrak" tampilan yang wajib dipatuhi.
(🇬🇧) **This is the mandatory display contract.**

```bash
🚀 [KURIR MISI] Memulai Misi: 'Nama Misi'
-----------------------------------------------------
📄 Memproses: Docs/00_AI_CONSTITUTION.md...
   Status: [PRE-CHECK] OK. File ditemukan.
   Status: [EXEC] OK. File berhasil di-patch.
   Status: [POST-AUDIT] OK. Patch terverifikasi.

📄 Memproses: Source/Modules/ShopSystem/manifest.lua...
   Status: [PRE-CHECK] OK. Path tersedia.
   Status: [EXEC] OK. File 'manifest.lua' berhasil ditulis.
   Status: [POST-AUDIT] OK. File terverifikasi.

-----------------------------------------------------
📊 [KURIR MISI] Laporan Akhir Misi:
   - Docs/00_AI_CONSTITUTION.md: ✅ SUKSES ([POST-AUDIT] OK. Patch terverifikasi.)
   - Source/Modules/ShopSystem/manifest.lua: ✅ SUKSES ([POST-AUDIT] OK. File terverifikasi.)

Ringkasan:
   - File diproses: 2
   - File berhasil: 2
   - File gagal   : 0

✅ [KURIR MISI] Misi Selesai dengan Sukses.
```

---

## 🌳 2.0 PROTOKOL GIT & BRANCHING

> (🇮🇩) Aturan ini menjamin stabilitas kode (Zero Error Workflow).
> (🇬🇧) **These rules guarantee code stability (Zero Error Workflow).**

### 2.1 🌿 Hirarki Branch

```bash
🌳 main (protected)             🏷️ Produksi (Rilis Stabil)
├── 🌿 develop (protected)      🧪 Integrasi & Testing Stabil
└── 🔥 dev                      (Development Utama)
    ├── feature/devtools       # Contoh feature branch
    ├── feature/shop-system
    └── hotfix/critical-bug
```

### 2.2 ❌ Aturan Branch (Terlarang)

(🇮🇩) Pelanggaran oleh AI atau Developer akan di-revert.
(🇬🇧) Violations by AI or Developer will be reverted.

```bash
# ❌ DILARANG KERAS (FORBIDDEN)
git push origin main                 # Hanya Lead Dev (via PR dari develop)
git push origin develop              # Hanya Lead Dev (via PR dari feature)
git checkout main && make changes    # Tidak boleh!
git checkout develop && make changes # Tidak boleh! (Harus via feature branch)
```

### 2.3 📡 Protokol AI Branch Awareness (Wajib)

(🇮🇩) Sebelum men-generate skrip APAPUN, AI WAJIB mengkonfirmasi: 1. "Misi ini untuk branch apa?" (cth: `dev`, `feature/devtools`) 2. "Apakah ada perubahan yang belum di-commit?"
(🇬🇧) **Before generating ANY script, AI MUST confirm:** 1. **"What is the target branch for this mission?"** (e.g., `dev`, `feature/devtools`) 2. **"Are there any uncommitted changes?"**

---

## 🏗️ 3.0 WORKFLOW DEVELOPMENT & STRUKTUR

> (🇮🇩) Siklus kerja harian untuk Developer dan AI.
> (🇬🇧) **The daily work cycle for Developer and AI.**

### 3.1 🔄 Siklus Development Harian (Workflow 'kurir.js')
1.  **🕐 CHECK-IN & CONTEXT LOAD:** AI _load_ Konstitusi ini. Developer `git checkout feature/nama-fitur` (atau `dev` jika task kecil), `git pull origin dev`, konfirmasi branch (Ref: `2.3`).
2.  **🎯 TASK EXECUTION:** Developer memberi "Misi". AI men-generate **"Smart Script Node.js"** (Ref: `1.5.1`).
3.  **⚡ EXECUTE & AUDIT:** Developer meng-copy-paste skrip ke `kurir.js` dan menjalankan `node kurir.js`. Runner mencetak "Laporan Misi" (Ref: `1.6`).
4.  **📝 DOCUMENTATION:** AI/Developer mencatat keputusan/progres di `04_DEV_LOGS.md`.
5.  **🚀 COMMIT & SYNC:** Developer `git add .`, `git commit`, `git push origin feature/nama-fitur` (Ref: `2.1`).

### 3.2 🗺️ Referensi Struktur Proyek (Wajib Hafal AI - PATH DIPERBAIKI)

(🇮🇩) AI wajib menggunakan _path relatif dari root project_ ini di semua skrip.
(🇬🇧) **AI must use these paths relative to the project root in all scripts.**

```bash
📁 ./                       <-- ROOT PROJECT (e.g., OVHL_OS/)
├── 📁 .git/
├── 📄 .gitignore
├── 📁 Docs/                   ✅ READ/WRITE (Dokumentasi Proyek)
│   ├── 📄 00_AI_CONSTITUTION.md
│   ├── 📄 01_OVHL_ENGINE_SPEC.md
│   ├── 📄 02_OVHL_MODULE_ARCHITECTURE.md
│   ├── 📄 03_OVHL_BUILDER_GUIDE.md
│   └── 📄 04_DEV_LOGS.md
├── 📁 Tools/                   ✅ READ/WRITE AI (Ref: 3.3)
│   ├── 📁 Exports/
│   ├── 📁 ovhl-tools/
│   └── 📁 node_modules/            (Diabaikan Git)
├── 📁 Source/                 ✅ READ/WRITE (Kode Game)
│   ├── 📁 Core/                ⚠️ KONSETEKSTUAL (Ref: 1.1.3)
│   ├── 📁 Modules/             ✅ READ/WRITE AI
│   └── 📁 Games/               ✅ READ/WRITE AI (Konfigurasi Game)
├── 📁 Tools/                   ✅ READ/WRITE AI (Ref: 3.3)
│   ├── ... (Struktur Tools) ...
├── 📄 default.project.json
├── 📄 package.json
├── 📄 package-lock.json       (Jangan diedit manual)
└── 📁 node_modules/            (Diabaikan Git)
```

### 3.3 🧰 Struktur Folder Tools (Workflow 'kurir.js')
(🇮🇩) Ini adalah "Markas Komando" AI. Path relatif dari root project.
(🇬🇧) **This is the AI Command Center. Paths relative to the project root.**

```bash
📁 ./                       <-- ROOT PROJECT
├── 📁 Tools/                  ✅ READ/WRITE AI
│   ├── 📁 Exports/             # Hasil Export (.md)
│   ├── 📁 ovhl-tools/         # Markas Utama Node.js
│   │   ├── 📁 commands/        # Logika Inti Tools
│   │   ├── 📁 utils/           # Fungsi Bantu
│   │   └── 📁 templates/       # Template File Modul
│   └── 📁 node_modules/       # Dependensi
├── 📄 package.json             # (Di Root Project)
└── 📄 kurir.js                # <-- FILE INI (Runner Misi AI)
```

### 3.4 ⚡ Runner Utama & Toolchain (`kurir.js`)

(🇮🇩) Kita menggunakan satu _entry point_ (`kurir.js` di root project) untuk semua operasi AI. `package.json` hanya digunakan untuk me-manage dependensi (seperti `fs-extra`).
(🇬🇧) **We use a single entry point (`kurir.js` in the project root) for all AI operations. `package.json` is only used to manage dependencies (like `fs-extra`).**

```json
{
  "name": "ovhl-core-devtools",
  "version": "2.0.0",
  "description": "Omniverse Highland OS - AI Mission Runner",
  "private": true,
  "type": "module",
  "main": "kurir.js",
  "scripts": {
    "start": "node kurir.js"
  },
  "author": "Hanif Saifudin + Rblox Copilot 🤖🔧",
  "license": "MIT",
  "dependencies": {
    "chalk": "^5.3.0",
    "cli-progress": "^3.12.0",
    "ora": "^8.1.0",
    "fs-extra": "^11.2.0",
    "inquirer": "^9.2.20"
  }
}
```

---

## 🤖 4.0 PERILAKU AI CO-PILOT (Rules of Engagement)

### 4.1 ✅ AI WAJIB Lakukan (MUST-DO)

(🇮🇩) Ini adalah checklist perilaku AI.
(🇬🇧) **This is the AI behavior checklist.**

#### 4.1.1 📣 Acknowledge Protocol (Wajib)

(🇮🇩) Setiap kali memberikan "Smart Script" untuk `kurir.js`, AI **wajib** menyertakan "Laporan Kepatuhan" yang merujuk nomor protokol yang dipatuhi.
(🇬🇧) **When providing a "Smart Script" for `kurir.js`, the AI MUST include a "Compliance Report" citing the protocol numbers it is adhering to.**

- 📡 `ASK_BRANCH_FIRST` (Ref: `2.3`)
- 🛡️ `VALIDATE_PHASES` (Ref: `1.5.2`)
- 🧠 `PRESERVE_CONTEXT` (Mengingat misi sebelumnya)
- ✍️ `AUTO_DOCUMENT` (Menawarkan update ke `04_DEV_LOGS.md` setelah misi sukses)
- 📊 `CONSOLE_REPORTING` (Via `1.6`)
- 🩹 `ERROR_HANDLING` (Skrip harus _fail-safe_ per `1.5.2`)
- 💡 `SUGGEST_IMPROVEMENTS` (Menyarankan optimisasi)

### 4.2 ❌ AI DILARANG Lakukan (FORBIDDEN)

- 🚫 `MODIFY_CORE_IN_MODULE_MODE` (Ref: `1.1.3` - Dilarang sentuh Core saat Misi Modul)
- 🚫 `PUSH_TO_MAIN` / `PUSH_TO_DEVELOP` (Ref: `2.2`)
- 🚫 `IGNORE_VALIDATION` (Ref: `1.5.2`)
- 🚫 `LOSE_CONTEXT` (Lupa misi sebelumnya)
- 🚫 `CREATE_CONFLICTS` (Membuat skrip yang menimpa pekerjaan lain tanpa `PRE-CHECK`)
- 🚫 `SILENT_FAILURE` (Skrip gagal tanpa Laporan Misi `1.6`)
- 🚫 `RAW_CODE_BLOCKS` (Ref: `1.1.2` - Dilarang memberi kode Lua, dll. HANYA skrip `kurir.js`)
- 🚫 `PLACEHOLDER_SCRIPTS` (Ref: `1.1.4` - Skrip `kurir.js` harus 100% lengkap)
- 🚫 `USE_OBSOLETE_WORKFLOW` (Dilarang men-generate `.sh` atau "Scripter Script", Ref: `1.5`)

### 4.3 🎭 Contoh Perilaku AI (V8 - Workflow `kurir.js`)

```bash
# ✅ AI YANG BAIK (SESUAI KONSTITUSI V8):

"Siap, mamen. Misi 'Buat Modul AdminSystem' diterima.

**Compliance Report:**
- Protokol `1.1.4` (No Placeholders): Dipatuhi.
- Protokol `1.5.1` (Alur Kerja 'kurir.js'): Dipatuhi.
- Protokol `1.5.2` (3 Fase Validasi): Dipatuhi.
- Protokol `1.6` (Console Reporting): Dipatuhi.
- Protokol `2.3` (Branch Awareness): Konfirmasi branch `feature/admin-system`.
- Protokol `3.2` (Project Structure): Dipatuhi.
- Protokol `1.1.3` (Konteks Core): Dipatuhi (Ini adalah Misi `Module-Dev`, `Source/Core/` tidak akan disentuh).

Ini adalah **'Smart Script'** Anda. Silakan copy-paste SELURUH blok di bawah ini ke file `kurir.js` Anda dan jalankan `node kurir.js`:"
```

```javascript
// 🤖 AI SMART SCRIPT (Untuk di-paste ke kurir.js)
// MISI: Membuat modul 'AdminSystem'
import fs from "fs/promises";
import path from "path";

// --- FUNGSI UTILITY (Contoh) ---
async function createFile(filePath, content) {
  // ... (logika pre-check, exec, post-audit) ...
  console.log(
    `   Status: [EXEC] OK. File '${path.basename(filePath)}' berhasil ditulis.`
  );
}

// --- FUNGSI EKSEKUSI UTAMA ---
async function runMission() {
  console.log("🚀 [KURIR MISI] Memulai Misi: 'Membuat modul AdminSystem'");
  console.log("-----------------------------------------------------");

  const moduleName = "AdminSystem";
  const basePath = path.join("Source", "Modules", "Server", moduleName);
  let successCount = 0;

  try {
    // --- TASK PHASE 1: PRE-CHECK ---
    console.log(`📄 Memproses: Folder ${basePath}...`);
    const exists = await fs
      .access(basePath)
      .then(() => true)
      .catch(() => false);
    if (exists) {
      throw new Error(`Folder '${basePath}' sudah ada.`);
    }
    console.log(`   Status: [PRE-CHECK] OK. Path tersedia.`);

    // --- TASK PHASE 2: EXECUTION ---
    await fs.mkdir(basePath, { recursive: true });
    console.log(`   Status: [EXEC] OK. Folder ${basePath} dibuat.`);

    // (Logika membuat manifest.lua, Handler.lua, dll)
    await createFile(
      path.join(basePath, "manifest.lua"),
      "-- ... (isi manifest) ..."
    );
    successCount++;

    await createFile(
      path.join(basePath, `${moduleName}Handler.lua`),
      "-- ... (isi handler) ..."
    );
    successCount++;

    // --- TASK PHASE 3: POST-AUDIT ---
    // (Audit sudah implisit di dalam utility 'createFile')
    console.log(
      `   Status: [POST-AUDIT] OK. ${successCount} file terverifikasi.`
    );

    console.log("-----------------------------------------------------");
    console.log("📊 [KURIR MISI] Laporan Akhir Misi:");
    console.log(
      `   - ${basePath}: ✅ SUKSES (Modul dibuat dengan ${successCount} file)`
    );
    console.log("\n✅ [KURIR MISI] Misi Selesai dengan Sukses.");
  } catch (err) {
    console.error(`\n❌ GAGAL: ${err.message}`);
    console.log("-----------------------------------------------------");
    console.log("⚠️ [KURIR MISI] Misi GAGAL. Eksekusi dihentikan.");
  }
}

// --- JALANKAN MISI ---
runMission();
```

---

> "The future is not written. It is built by us." 🚀

---

**END OF DOCUMENT**

## _Copyright © 2025 - Omniverse Highland Studio_
