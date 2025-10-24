# 📖 00_AI_CONSTITUTION.md - Protokol Inti & Aturan AI

> 🏛️ **Project:** Omniverse Highland (OVHL)
> 📄 **Dokumen:** Konstitusi Inti, Aturan AI, dan Protokol Workflow
> 🏷️ **Versi:** 6.0.0 (Final w/ Render Fix)
> 👑 **Founder:** Hanif Saifudin
> 🚨 **Status:** **WAJIB DIBACA DAN DIPATUHI OLEH AI & DEVELOPER**

---

## 📜 1.0 ATURAN MUTLAK AI (AI BOOTLOADER #0)

> (🇮🇩) Perintah ini wajib di-load AI sebelum memproses request apapun.
> (🇬🇧) **These commands MUST be loaded by the AI before processing any request.**

### 1.1 🛡️ CORE MANDATES (ATURAN INTI)

> (🇮🇩) Pelanggaran terhadap aturan ini = Kegagalan Misi Otomatis.
> (🇬🇧) **Violation of these rules = Automatic Mission Failure.**

#### 1.1.1 🤖 Script-Based Execution (Wajib)

(🇮🇩) Semua operasi file (create, update, delete, scaffold) **WAJIB** dieksekusi melalui skrip (`.sh` atau `.js`) yang di-generate AI.
(🇬🇧) **All file operations (create, update, delete, scaffold) MUST be executed via AI-generated scripts (`.sh` or `.js`).**

#### 1.1.2 🚫 No Manual Code (Wajib)

(🇮🇩) AI **DILARANG KERAS** memberikan blok kode (Lua, dll) mentah untuk di-copy-paste manual oleh Developer. Pengecualian hanya untuk diskusi konseptual.
(🇬🇧) **AI is FORBIDDEN from providing raw code blocks (Lua, etc.) for manual copy-pasting by the Developer. Exception only for conceptual discussion.**

#### 1.1.3 🔒 Core Read-Only (Wajib)

(🇮🇩) AI **DILARANG KERAS** memodifikasi atau membuat skrip yang memodifikasi folder `OVHL_CORE/Source/Core/`.
(🇬🇧) **AI is FORBIDDEN from modifying, or generating scripts that modify, the `OVHL_CORE/Source/Core/` directory.**

#### 1.1.4 ✍️ No Placeholders (Wajib)

(🇮🇩) AI **DILARANG KERAS** menggunakan _placeholder_ (seperti `... (konten sama) ...` atau `... (dst) ...`) saat men-generate file/skrip. Semua _output_ RAW Markdown atau skrip harus **100% LENGKAP** dan siap eksekusi/simpan.
(🇬🇧) **AI is FORBIDDEN from using placeholders (e.g., `... (content same) ...` or `... (etc) ...`) when generating files/scripts. All RAW Markdown or script outputs must be 100% COMPLETE and ready-to-execute/save.**

---

### 1.2 🧠 AI AUTONOMY & STRATEGY (OTONOMI & STRATEGI AI)

#### 1.2.1 🎯 Mission Objective (Tujuan Misi)

(🇮🇩) Tugas AI adalah memenuhi "Misi" (Permintaan Developer) dengan menyediakan "Rencana Eksekusi" (skrip) yang paling efektif, aman, dan _self-contained_ (bisa jalan sendiri).
(🇬🇧) **The AI's task is to fulfill the "Mission" (Developer's request) by providing the most effective, safe, and self-contained "Execution Plan" (script).**

#### 1.2.2 🛠️ Tool Selection (Pemilihan Alat)

(🇮🇩) AI **berhak penuh dan wajib** menentukan alat terbaik untuk misi:
_ **Gunakan Bash (.sh):** Untuk tugas simpel (membuat/memindahkan/patch file, operasi folder).
_ **Gunakan Node.js (.js):** Untuk tugas kompleks (logika _generation_ yang rumit, parsing JSON, _generate_ file besar, butuh _dependencies_ `npm`).
(🇬🇧) **AI has full autonomy and responsibility to select the best tool: Use Bash (.sh) for simple tasks (fs ops, patch). Use Node.js (.js) for complex logic, parsing, or large-scale generation.**

---

### 1.3 📦 SCALABILITY & BATCHING (SKALABILITAS & BATCH)

(🇮🇩) Jika "Misi" terlalu besar (misal: generate 10 modul), AI **berhak** memecah "Rencana Eksekusi" menjadi beberapa _batch_ (langkah) yang logis. AI wajib memberikan instruksi urutan eksekusi _batch_ tersebut dengan jelas.
(🇬🇧) **If a Mission is too large, the AI has the right to break the Execution Plan into logical batches. The AI must provide clear sequential instructions for each batch.**

---

### 1.4 ⚖️ CONFLICT RESOLUTION (RESOLUSI KONFLIK)

(🇮🇩) Jika permintaan Developer **BERKONFLIK** dengan protokol di Konstitusi ini (misal: melanggar `1.1.3 Core Read-Only`), AI **WAJIB**: 1. **STOP:** Hentikan proses. 2. **CITE:** Sebutkan protokol yang dilanggar (misal: `Pelanggaran Protokol 1.1.3`). 3. **WARN:** Jelaskan risikonya (misal: "Akan merusak Core Engine"). 4. **CONFIRM:** Minta konfirmasi eksplisit ("Apakah Anda yakin ingin melanjutkan? Ketik 'LANJUTKAN PELANGGARAN'").
(🇬🇧) **If a Developer request conflicts with a Protocol, AI MUST: 1. STOP. 2. CITE the violated protocol. 3. WARN of the risks. 4. Ask for explicit confirmation (e.g., 'Type 'CONFIRM VIOLATION') to proceed.**

---

### 1.5 ⚙️ SCRIPTER & TASK PROTOCOL (Workflow V3)

#### 1.5.1 📨 Scripter Workflow (Wajib)

(🇮🇩) AI tidak men-generate _Task Script_ (logika inti 200 baris) di chat. AI men-generate **"Scripter Script"** (Kurir 20 baris) di chat. "Scripter" ini bertugas membuat/mem-patch file _Task_ di `Tools/` (Ref: `3.3`) dan langsung mengeksekusinya via Runner Utama (Ref: `3.4`).
(🇬🇧) **AI generates a "Scripter Script" (Courier) in chat. This Scripter creates/patches a "Task Script" in `Tools/` (Ref: `3.3`) and executes it via the Main Runner (Ref: `3.4`).**

#### 1.5.2 🧬 Task Anatomy (Wajib)

(🇮🇩) _Task Script_ (yang ada di `Tools/`) WAJIB memiliki 3 fase: 1. **PHASE 1: PRE-CHECK:** Validasi kondisi awal (file/folder ada? konflik?). 2. **PHASE 2: EXECUTION:** Eksekusi tugas (membuat/memodifikasi file). 3. **PHASE 3: POST-AUDIT:** Validasi hasil (file beneran ada? isi beneran berubah?).
(🇬🇧) **The _Task Script_ (in `Tools/`) MUST have 3 phases: 1. PRE-CHECK, 2. EXECUTION, 3. POST-AUDIT.**

#### 1.5.3 🩹 Patching Protocol (Anti-Version-Hell)

(🇮🇩) "Scripter" WAJIB mem-patch _Task Script_ yang ada _in-place_. **DILARANG** membuat file baru (cth: `_fix.js`).
(🇬🇧) **The "Scripter" MUST patch existing Task Scripts in-place. Creating new `_fix.js` files is FORBIDDEN.**

---

### 1.6 📊 STANDARD MISSION REPORTING (STANDAR LAPORAN MISI)

(🇮🇩) Setiap _Task Script_ (Ref: `1.5.2`) yang dieksekusi oleh Runner Utama (`devtools.js`) **DILARANG** `console.log` sembarangan. Task Script WAJIB me-`return` sebuah **"Standardized Report Object" (JSON)**. Runner Utama-lah yang bertugas mencetak laporan ini ke konsol.
(🇬🇧) **Every _Task Script_ (Ref: `1.5.2`) MUST NOT `console.log` directly. It MUST return a "Standardized Report Object" (JSON) to the Main Runner (`devtools.js`). The Runner is responsible for printing this report.**

#### 1.6.1 📝 Struktur Standar Laporan (JSON Contract)

(🇮🇩) Ini adalah "kontrak" JSON yang wajib dipatuhi.
(🇬🇧) **This is the mandatory JSON contract.**

```json
{
  "status": "SUCCESS", // "SUCCESS" atau "FAILURE"
  "mission": "Create Module: AdminSystem", // Judul Misi
  "logs": [
    "[PRE-CHECK] OK: Directory available.",
    "[EXEC] OK: Folder created at ...",
    "[EXEC] OK: manifest.lua written.",
    "[POST-AUDIT] OK: 5 files verified."
  ],
  "summary": {
    "filesCreated": 5,
    "foldersCreated": 1,
    "location": "OVHL_CORE/Source/Modules/Server/AdminSystem"
  },
  "error": null // Diisi string error jika status == "FAILURE"
}
```

---

## 🌳 2.0 PROTOKOL GIT & BRANCHING

> (🇮🇩) Aturan ini menjamin stabilitas kode (Zero Error Workflow).
> (🇬🇧) **These rules guarantee code stability (Zero Error Workflow).**

### 2.1 🌿 Hirarki Branch

```bash
🌳 main (protected)             🏷️ Produksi (Rilis)
├── 🌿 develop (protected)      🧪 Integrasi & Testing
└── 🔥 dev                      (Development & Eksperimen)
    ├── feature/shop-system
    ├── feature/quest-system
    └── hotfix/critical-bug
```

### 2.2 ❌ Aturan Branch (Terlarang)

(🇮🇩) Pelanggaran oleh AI atau Developer akan di-revert.
(🇬🇧) Violations by AI or Developer will be reverted.

```bash
# ❌ DILARANG KERAS (FORBIDDEN)
git push origin main                 # Hanya Lead Dev (via PR)
git push origin develop              # Hanya Lead Dev (via PR)
git checkout main && make changes    # Tidak boleh!
```

### 2.3 📡 Protokol AI Branch Awareness (Wajib)

(🇮🇩) Sebelum men-generate skrip APAPUN, AI WAJIB mengkonfirmasi: 1. "Misi ini untuk branch apa?" (cth: `dev`, `feature/shop-system`) 2. "Apakah ada perubahan yang belum di-commit?"
(🇬🇧) **Before generating ANY script, AI MUST confirm:** 1. **"What is the target branch for this mission?"** (e.g., `dev`, `feature/shop-system`) 2. **"Are there any uncommitted changes?"**

---

## 🏗️ 3.0 WORKFLOW DEVELOPMENT & STRUKTUR

> (🇮🇩) Siklus kerja harian untuk Developer dan AI.
> (🇬🇧) **The daily work cycle for Developer and AI.**

### 3.1 🔄 Siklus Development Harian

1.  **🕐 CHECK-IN & CONTEXT LOAD:** AI _load_ Konstitusi ini. Developer `git pull` dan konfirmasi branch (Ref: `2.3`).
2.  **🎯 TASK EXECUTION:** Developer memberi "Misi". AI men-generate "Scripter Script" (Ref: `1.5.1`).
3.  **⚡ EXECUTE & AUDIT:** Developer menjalankan "Scripter". Runner Utama (`devtools.js`) mengeksekusi _Task_ dan mencetak "Laporan Misi" (Ref: `1.6`).
4.  **📝 DOCUMENTATION:** AI/Developer mencatat keputusan/progres di `04_PROGRESS_LOG.md` (Makro) atau `05_DEV_LOGS.md` (Mikro).
5.  **🚀 COMMIT & SYNC:** Developer `git add .`, `git commit`, `git push` ke branch yang tepat (Ref: `2.1`).

### 3.2 🗺️ Referensi Struktur Proyek (Wajib Hafal AI)

(🇮🇩) AI wajib menggunakan _path_ absolut ini di semua skrip.
(🇬🇧) **AI must use these absolute paths in all scripts.**

```bash
📁 OVHL_CORE/
├── 📁 Source/
│   ├── 🎯 Core/                      (❌ READ-ONLY | Ref: 1.1.3)
│   ├── 🧩 Modules/                   (✅ READ/WRITE | Modul Gameplay)
│   ├── 🎮 Games/                      (✅ READ/WRITE | Konfigurasi Game)
├── 🛠️ Tools/                         (✅ READ/WRITE | Ref: 3.3)
└── 📚 DOCS/                          (✅ READ/WRITE | Dokumentasi Proyek)
    ├── 📄 00_AI_CONSTITUTION.md        # (File ini)
    ├── 📄 01_OVHL_ENGINE_SPEC.md       # (Blueprint Engine)
    ├── 📄 02_OVHL_MODULE_ARCHITECTURE.md # (Blueprint Modul)
    ├── 📄 03_OVHL_BUILDER_GUIDE.md     # (Manual Builder)
    ├── 📄 04_PROGRESS_LOG.md           # (Log Makro)
    └── 📄 05_DEV_LOGS.md               # (Log Mikro)
```

### 3.3 🧰 Struktur Folder Tools (Wajib Hafal AI)

(🇮🇩) Ini adalah "Markas Komando" AI. Semua _Task Script_ yang bisa dieksekusi ulang _wajib_ disimpan di sini.
(🇬🇧) **This is the AI Command Center. All re-executable Task Scripts MUST be stored here.**

```bash
📁 OVHL_CORE/
├── 🛠️ Tools/
│   ├── 🐧 Bash/
│   │   └── 📁 tasks/
│   │       ├── 📜 01_create_module.sh (Arsip Task 1)
│   │       └── 📜 02_patch_handler.sh (Arsip Task 2)
│   ├── 🟢 Node/
│   │   └── 📁 tasks/
│   │       └── 📜 01_complex_generator.js (Arsip Task 3)
│   ├── 🚀 devtools.js                  # (RUNNER UTAMA | Ref: 3.4)
│   └── 📦 package.json                 # (Definisi Toolchain)
...
```

### 3.4 ⚡ Runner Utama & Toolchain (`package.json`)

(🇮🇩) Kita menggunakan satu _entry point_ (`devtools.js`) untuk semua operasi.
(🇬🇧) **We use a single entry point (`devtools.js`) for all operations.**

```json
{
  "name": "ovhl-core-devtools",
  "version": "2.0.0",
  "description": "Omniverse Highland OS - Unified Node Toolchain",
  "private": true,
  "type": "module",
  "main": "Tools/devtools.js",
  "scripts": {
    "start": "node Tools/devtools.js",
    "init": "node Tools/devtools.js init",
    "create:module": "node Tools/devtools.js create:module",
    "create:game": "node Tools/devtools.js create:game",
    "check:core": "node Tools/devtools.js check:core",
    "run:task": "node Tools/devtools.js run:task"
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

(🇮🇩) Setiap kali memberikan "Scripter Script", AI **wajib** menyertakan "Laporan Kepatuhan" yang merujuk nomor protokol yang dipatuhi.
(🇬🇧) **When providing a "Scripter Script", the AI MUST include a "Compliance Report" citing the protocol numbers it is adhering to.**

- 📡 `ASK_BRANCH_FIRST` (Ref: `2.3`)
- 🛡️ `VALIDATE_BEFORE_GENERATE` (Ref: `1.5.2`)
- 🧠 `PRESERVE_CONTEXT` (Mengingat misi sebelumnya)
- ✍️ `AUTO_DOCUMENT` (Menawarkan update ke `04` atau `05` setelah misi sukses)
- 📊 `PROGRESS_REPORT` (Via `1.6`)
- 🩹 `ERROR_HANDLING` (Skrip harus _fail-safe_ per `1.5.2`)
- 💡 `SUGGEST_IMPROVEMENTS` (Menyarankan optimisasi)

### 4.2 ❌ AI DILARANG Lakukan (FORBIDDEN)

- 🚫 `MODIFY_CORE` (Ref: `1.1.3`)
- 🚫 `PUSH_TO_MAIN` / `PUSH_TO_DEVELOP` (Ref: `2.2`)
- 🚫 `IGNORE_VALIDATION` (Ref: `1.5.2`)
- 🚫 `LOSE_CONTEXT` (Lupa misi sebelumnya)
- 🚫 `CREATE_CONFLICTS` (Membuat skrip yang menimpa pekerjaan lain tanpa `PRE-CHECK`)
- 🚫 `SILENT_FAILURE` (Skrip gagal tanpa Laporan Misi `1.6`)
- 🚫 `MANUAL_CODE_BLOCKS` (Ref: `1.1.2`)
- 🚫 `VERSION_HELL_FILES` (Ref: `1.5.3`)
- 🚫 `DIRECT_TASK_GENERATION` (Memberi _Task Script_ 200 baris di chat, Ref: `1.5.1`)
- 🚫 `USE_PLACEHOLDERS` (Ref: `1.1.4`)

#### 4.2.1 🖥️ Catatan Rendering Chat (Meta-Aturan)

(🇮🇩) **PENTING:** Saat Anda (AI) men-generate "Scripter Script" (seperti di contoh `4.3`), _output chat_ Anda akan berisi blok kode yang _nested_ (bersarang). Untuk mencegah _chat_ rusak, Anda **WAJIB** membungkus _seluruh_ "Scripter Script" Anda (yang 20 baris itu) dengan **4 backticks (````)**.
(🇬🇧) **IMPORTANT:** When you (AI) generate a "Scripter Script" (like in example `4.3`), your chat output will contain _nested_ code blocks. To prevent broken rendering, you **MUST** wrap your _entire_ "Scripter Script" (the 20-line courier) in **4 backticks (````)**.

### 4.3 🎭 Contoh Perilaku AI (V6)

```bash
# ❌ AI YANG BURUK (MELANGGAR KONSTITUSI):
"Oke, ini kode Lua-nya untuk AdminSystemHandler.lua. Silakan copy-paste ya:"
(memberikan blok kode Lua mentah...)

# ❌ AI YANG BURUK (V2 - SUDAH KUNO):
"Oke, ini skrip 200 baris untuk membuat modul. Copy-paste ke terminal ya:"
(memberikan Task Script 200 baris di chat...)

# ❌ AI YANG BURUK (V4 - MALAS):
"Oke, ini draf 03_BUILDER_GUIDE.md... Bagian 7.0 ... (konten sama) ..."
(menggunakan placeholder...)
```

`````bash
# ✅ AI YANG BAIK (SESUAI KONSTITUSI V6):

"Siap, Mamen. Misi 'Buat Modul AdminSystem' diterima.

**Compliance Report:**
- Protokol `1.1.4` (No Placeholders): Dipatuhi.
- Protokol `1.5.1` (Scripter Workflow): Dipatuhi.
- Protokol `1.2.2` (Tool Selection): Dipatuhi (Task akan dibuat sebagai Node.js).
- Protokol `1.6` (Std. Report): Dipatuhi (Task Script akan me-return JSON).
- Protokol `2.3` (Branch Awareness): Konfirmasi branch `feature/admin-system`.
- Protokol `3.3` (Tools Structure): Dipatuhi.
- Protokol `4.2.1` (Render Fix): Dipatuhi (Output ini akan menggunakan 4 backticks).
- Referensi Dokumen: `02_OVHL_MODULE_ARCHITECTURE.md` (Bagian 2.0).

Ini adalah **'Scripter Script' (Kurir)** Anda. Silakan copy-paste SELURUH blok di bawah ini ke terminal Anda:"

````markdown
#!/bin/bash
# 🤖 [AI_ORCHESTRATOR] - Scripter V6
# MISI: Membuat 'Task Script' untuk modul 'AdminSystem' dan mengeksekusinya.

TASK_FILE_PATH="OVHL_CORE/Tools/Node/tasks/01_create_admin_system.js"
RUNNER_PATH="OVHL_CORE/Tools/devtools.js"

echo "🚀 [SCRIPTER] Memulai Misi..."

# --- PHASE 1: PRE-CHECK ---
if [ ! -f "$RUNNER_PATH" ]; then
    echo "❌ [SCRIPTER GAGAL] Runner Utama '$RUNNER_PATH' tidak ditemukan!"
    exit 1
fi
echo "✅ [SCRIPTER] Runner Utama ditemukan."

# --- PHASE 2: EXECUTION (Membuat Task Script) ---
echo "✍️  [SCRIPTER] Menulis Task Script ke $TASK_FILE_PATH..."
cat <<'EOT' > "$TASK_FILE_PATH"
// 🤖 [AI TASK SCRIPT] - 01_create_admin_system.js
// Misi: Membuat struktur modul 'AdminSystem'
import fse from 'fs-extra';
// (Catatan: fs-extra harus di-install via package.json)

async function runMission() {
    const moduleName = "AdminSystem";
    const basePath = `OVHL_CORE/Source/Modules/Server/${moduleName}`;
    const report = {
        status: "FAILURE",
        mission: `Create Module: ${moduleName}`,
        logs: [],
        summary: {},
        error: null
    };

    try {
        // --- TASK PHASE 1: PRE-CHECK ---
        report.logs.push("[PRE-CHECK] Memeriksa ketersediaan path...");
        if (await fse.pathExists(basePath)) {
            throw new Error(`Folder '${basePath}' sudah ada. Misi dibatalkan.`);
        }
        report.logs.push("[PRE-CHECK] OK: Path tersedia.");

        // --- TASK PHASE 2: EXECUTION ---
        report.logs.push("[EXEC] Membuat folder...");
        await fse.mkdirp(basePath);

        // (Logika membuat manifest.lua, Handler.lua, dll...)
        // Sesuai 02_OVHL_MODULE_ARCHITECTURE.md (Bagian 2.2)
        await fse.writeFile(`${basePath}/manifest.lua`,
`-- ============================================
-- OVHL RBLX Framework v2.0.0
-- Founder: Hanif Saifudin
-- Module: AdminSystem
-- ============================================
return {
    name = "AdminSystem",
    version = "1.0.0",
    description = "Mengelola perintah admin.",
    depends = {"DataService", "EventService"},
    loadOrder = 1,
    autoInit = true,
    entry = "Handler",
    subscribesTo = {"player_chat_message"},
    publishes = {"admin_action_logged"}
}
`);
        report.logs.push("[EXEC] OK: manifest.lua ditulis.");

        await fse.writeFile(`${basePath}/${moduleName}Handler.lua`,
`-- ============================================
-- OVHL RBLX Framework v2.0.0
-- Founder: Hanif Saifudin
-- Module: AdminSystem Handler
-- ============================================

-- --- FASE 0: ANTI-CRASH LEVEL 1 (OS CHECK) ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CORE_OS_PATH = ReplicatedStorage:WaitForChild("OVHL_Core", 5)
if not CORE_OS_PATH then
    warn("!! [OVHL_ERROR] Module 'AdminSystem' GAGAL LOAD. Core OS tidak ditemukan!!")
    return nil
end
print("[OVHL] OS Check OK for AdminSystem.")
-- --- END OF FASE 0 ---

local AdminSystemHandler = {}
AdminSystemHandler.__index = AdminSystemHandler
local _isInitialized = false

function AdminSystemHandler:init(context)
    if _isInitialized then return end
    self.DataService = context.DataService
    self.EventService = context.EventService
    print("[AdminSystem] berhasil diinisialisasi!")
    _isInitialized = true
end

function AdminSystemHandler:start()
    print("[AdminSystem] is now running!")
end

return AdminSystemHandler
`);
        report.logs.push("[EXEC] OK: ${moduleName}Handler.lua ditulis.");

        await fse.writeFile(`${basePath}/${moduleName}Config.lua`,
`-- ============================================
-- OVHL RBLX Framework v2.0.0
-- Founder: Hanif Saifudin
-- Module: AdminSystem Configuration
-- ============================================
return {
    enabled = true,
    commandPrefix = "/"
}
`);
        report.logs.push("[EXEC] OK: ${moduleName}Config.lua ditulis.");

        await fse.writeFile(`${basePath}/${moduleName}Tests.lua`, `-- Tests for AdminSystem`);
        report.logs.push("[EXEC] OK: ${moduleName}Tests.lua ditulis.");
        await fse.writeFile(`${basePath}/README_${moduleName}.md`, `# AdminSystem`);
        report.logs.push("[EXEC] OK: README_${moduleName}.md ditulis.");

        report.logs.push("[EXEC] OK: 5 file berhasil ditulis.");

        // --- TASK PHASE 3: POST-AUDIT ---
        report.logs.push("[POST-AUDIT] Memverifikasi file...");
        const handlerExists = await fse.pathExists(`${basePath}/${moduleName}Handler.lua`);
        if (!handlerExists) {
            throw new Error("Audit gagal, file Handler tidak ditemukan!");
        }
        report.logs.push("[POST-AUDIT] OK: File terverifikasi.");

        // --- FINAL ---
        report.status = "SUCCESS";
        report.summary = {
            filesCreated: 5,
            foldersCreated: 1,
            location: basePath
        };
        return report;

    } catch (err) {
        report.status = "FAILURE";
        report.error = err.message;
        report.logs.push(`❌ GAGAL: ${err.message}`);
        return report;
    }
}

// Ekspor fungsi runMission agar bisa di-import oleh devtools.js
export default runMission;
EOT

echo "✅ [SCRIPTER] Task Script berhasil ditulis."

# --- PHASE 3: POST-AUDIT (Menjalankan Task via Runner) ---
echo "🚀 [SCRIPTER] Mengeksekusi Task via Runner Utama..."
echo "-----------------------------------------------------"
node "$RUNNER_PATH" run:task "$TASK_FILE_PATH"
echo "-----------------------------------------------------"
echo "✅ [SCRIPTER] Misi Selesai."
`````

---

> "The future is not written. It is built by us." 🚀

---

**END OF DOCUMENT**

## _Copyright © 2025 - Omniverse Highland Studio_
