# 📓 04_DEV_LOGS.MD - Catatan Harian Development (Mikro)

> **Project:** Omniverse Highland (OVHL)
> **Dokumen:** Log Mikro (Harian) Development
> **Versi:** 3.0.0 (Sinkronisasi Arsitektur V10)
> **Founder:** Hanif Saifudin
> **Status:** AKTIF (Sesuai Konstitusi `00`)

---

## 1.0 ATURAN PENULISAN LOG (WAJIB BACA!)

<details>
<summary>
🥇 1.1 Log Terbaru Selalu di Atas: Jangan nulis di bawah, biasakan buka file ini dan langsung tulis di baris paling atas (setelah bagian aturan ini).
</summary>

🏷️ **1.2 Format Header Ketat:** Selalu gunakan format ini agar gampang di-scan:
`## [DD-MM-YYYY HH:MM:SS] - [KONTEKS]`

🔍 **1.3 Konteks Harus Jelas:** Gunakan tag konteks yang konsisten. Ini contohnya:

- `[BUG]` 🐞 - Ada masalah atau error.
- `[FIXED]` ✅ - Bug yang sudah diselesaikan.
- `[FITUR]` 🚀 - Nambahin fungsionalitas baru.
- `[REFACTOR]` 🧹 - Merapikan kode tanpa mengubah fungsionalitas.
- `[TES]` 🧪 - Proses testing atau hasil testing.
- `[DOKS]` 📚 - Update dokumentasi (Ref: `00-05`).
- `[WIP]` 🚧 - (Work in Progress) Lagi dikerjain tapi belum kelar.
- `[ARSITEKTUR]` 🏛️ - Perubahan desain/konsep fundamental.

🎁 **1.4 Selalu Pakai Spoiler:** Bungkus _selalu_ log detailmu pakai tag `<details>` biar rapi dan gampang di-scroll di GitHub.

```html
<details>
  <summary>Judul Log yang Jelas (kasih emoji!)</summary>

  (Isi detailnya di sini...)
</details>
```

⚡ **1.5 Fleksibel & KreatIF!** Aturan di atas itu panduan, jangan kaku. Kalo nemu konteks baru (misal: `[IDE] 💡`, `[HOTFIX] 🩹`, `[PERFORMANCE] ⚡`), bebas tambahin! Kasih emoji baru yang relevan juga biar gampang di-scan dan seru dibaca.

📌 **1.6 Struktur Internal:** Di dalam `<details>`, gunakan format yang jelas. Nggak harus kaku, tapi usahakan ada poin-poin ini:

- `**CASE:**` (Masalahnya apa?)
- `**SOLVED:**` (Solusinya gimana?)
- `**NOTES/TIPS:**` (Catatan atau pelajaran penting.)

_Atau bisa juga:_

- `**PROGRESS:**` (Apa yang udah dikerjain?)
- `**NEXT_STEP:**` (Apa langkah selanjutnya?)
- `**BLOCKER:**` (Ada hambatan apa?)
</details>

## 2.0 LOG TERBARU MULAI DISINI

## [25-10-2025 16:00:00] - [AUDIT, CRITICAL, KONSTITUSI]

<details>
<summary>🚨 CRITICAL AUDIT: KONSTITUSI V10.2 API SALAH TOTAL - OVHL_OS vs OVHL-TOOLS MISMATCH</summary>

## 🔍 **ROOT CAUSE ANALYSIS**

### ❌ **MASALAH #1: KONSTITUSI V10.2 SALAH ASI API**

**Yang DIKIRA:**

```javascript
import { logger, getTemplate, ensureDir, writeFile } from "ovhl-tools";
```

**KENYATAAN:**

- `TemplateManager.js` → `export const TemplateManager` (bukan `getTemplate`)
- `Logger.js` → `export const logger` (bukan default)
- **TIDAK ADA** `ensureDir`, `writeFile` di exports yang terlihat

### ❌ **MASALAH #2: OVHL-TOOLS STRUCTURE INCOMPLETE**

**YANG KITA LIAT:**

- ✅ `TemplateManager.js` - ada, tapi butuh `ConfigLoader.js`
- ✅ `Logger.js` - ada, work
- ✅ `package.json` - set main = "index.js"
- ❌ **`index.js` di ROOT - ??? (BELUM DILIHAT)**
- ❌ **`ConfigLoader.js` - ??? (BUTUH UNTUK TemplateManager)**

### ❌ **MASALAH #3: IMPORT PATH CONFLICT**

File core saling import pake relative path:

```javascript
import { ConfigLoader } from "./ConfigLoader.js"; // ❌ Ini bakal fail dari external!
```

## 🎯 **IMPACT KE OVHL_OS**

### 1. **KURIR.JS CURRENT IMPOSSIBLE**

```javascript
// ❌ GA BAKAL WORK!
import { logger, getTemplate } from "ovhl-tools"; // Functions ga exist!
```

### 2. **MODULE CREATION STUCK**

- PingPong module gagal dibuat via kurir.js
- AI workflow terhambat total

### 3. **DEVELOPMENT BLOCKED**

- Sprint 2 (module development) tidak bisa lanjut
- Core OS udah jalan, tapi modul system mati

## 💡 **SOLUTION PATHS**

### **OPTION 1: FIX OVHL-TOOLS EXPORTS**

```javascript
// Buat file: node_modules/ovhl-tools/index.js
export { TemplateManager } from "./core/TemplateManager.js";
export { logger } from "./core/Logger.js";
export { ConfigLoader } from "./core/ConfigLoader.js";
```

### **OPTION 2: REVISI KONSTITUSI + DIRECT IMPORT**

```javascript
// kurir.js baru
import { TemplateManager } from "ovhl-tools/core/TemplateManager.js";
import { logger } from "ovhl-tools/core/Logger.js";
```

### **OPTION 3: CLI FALLBACK**

```javascript
// kurir.js pake CLI
const { execSync } = await import("child_process");
execSync("npx ovhl-tools create module pingpong --type client-server");
```

## 🚀 **NEXT SESSION ACTION PLAN**

### **PHASE 1: DIAGNOSIS COMPLETE**

- [ ] Cek existence of `node_modules/ovhl-tools/index.js`
- [ ] Audit `core/ConfigLoader.js`
- [ ] Audit `tools/create/index.js`

### **PHASE 2: QUICK FIX**

- [ ] Pilih solution path (Option 1/2/3)
- [ ] Implement fix ke Konstitusi + kurir.js
- [ ] Test module creation

### **PHASE 3: VALIDATION**

- [ ] Test PingPong module creation
- [ ] Verify AI workflow jalan
- [ ] Update dokumentasi

## 📊 **STATUS CURRENT**

- ✅ **Core OS**: BOOT SUCCESS (dari log 15:00:00)
- ✅ **Bootstrap**: WORKING
- ❌ **Module System**: BLOCKED
- ❌ **AI Workflow**: STUCK
- 🔧 **Konstitusi V10.2**: NEEDS URGENT REVISION

**BLOCKER:** Missing critical files di ovhl-tools untuk complete audit.

## 🎯 **KESIMPULAN SINGKAT:**

**MASALAH BESAR:** Konstitusi V10.2 asumsi API yang **GA ADA** di ovhl-tools!
**SOLUSI:** Butuh complete audit ovhl-tools structure + revisi Konstitusi.
**NEXT SESSION:** Cek 3 file missing → Pilih fix strategy → Gas bikin modul! 🚀

</details>

## [25-10-2025 15:00:00] - [ARSITEKTUR, REFACTOR, DOKS, HOTFIX]

<details>
<summary>🏛️⚡ V10 "SMART LIBRARY" & SINKRONISASI TOTAL - (Fix `UIManager` & `InputService` bugs)</summary>

**CASE:**
Melanjutkan sesi dari log `14:30:00`. `Core OS` sudah boot tapi masih ada error di Output (`UIManager` & `InputService`). Selain itu, Arsitektur `V9` (Konstitusi, `kurir.js` lama, path `Source/`) sudah usang dan perlu dirombak total.

**SOLVED - ARSITEKTUR V10 (Fundamental):**

1.  **Workflow V10 "Smart Library":** (Ref: `00_CONST 1.4`)
    - **Primer (`kurir.js`):** AI generate script yang `import { logger, ... } from "ovhl-tools"` (NPM Package).
    - **Fallback (`kurir.sh`):** AI generate script "bodoh" yang hanya manggil CLI `npx ovhl-tools ...`.
2.  **Struktur Folder V10:** (Ref: `00_CONST 3.2`)
    - Finalisasi struktur `src/lowercase/` (misal: `src/replicated/Modules/`, `src/serverstorage/Core/`, `src/client/Main.client.lua`, dll). Path `Source/PascalCase/` resmi USANG.
3.  **Protokol AI V11 "Segel Ganda":** (Ref: `00_CONST 1.1.5`)
    - Meresmikan protokol "Segel Ganda" (Header & Footer metadata) untuk _semua_ blok kode yang di-generate AI, demi kemudahan tracking (mencakup `PATH:`, `STUDIO:`, `AUTHOR:`, `🏁 End of:`).
4.  **Protokol Git V10:** (Ref: `00_CONST 2.0`)
    - Menambahkan aturan wajib AI untuk `CHECK_BRANCH` di awal sesi, proteksi `main`/`dev`, dan bantuan `commit message`.

**SOLVED - HOTFIX (Lanjutan Log 14:30):**

1.  **Rojo Hybrid Fix:** Dikonfirmasi `default.project.json` "Hybrid Fix" (dari log 14:30) yang menggunakan `Main.server.lua` (tanpa `$className` child) adalah "Master Kebenaran" (Ref: `01_SPEC 2.2`).
2.  **`UIManager.lua` (FIXED):** 🐞 Syntax error `Parent:t` di `ShowToastNotification` diperbaiki menjadi `Parent = t`.
3.  **`InputService.lua` (FIXED):** 🐞 Runtime error `invalid argument #3 to 'format' (got nil)` di `Logger:info` diperbaiki. `InputService:init` sekarang memanggil `Logger:new("InputService")` untuk membuat _instance_ logger yang benar sebelum digunakan.

**HASIL & STATUS:**

- ✅ **Core OS: NO ERROR!** Server dan Client boot 100% bersih tanpa error (kecuali warning DataStore yang normal di Studio).
- ✅ **Dokumen:** `00_AI_CONSTITUTION.md`, `01_OVHL_ENGINE_SPEC.md`, `02_OVHL_MODULE_ARCHITECTURE.md`, dan `03_OVHL_BUILDER_GUIDE.md` telah sukses di-revisi ke V10+ dan di-ACC oleh Developer.
- ✅ **AI (Gemini):** Sekarang beroperasi penuh di bawah Konstitusi V10.2 yang baru.

</details>

## [25-10-2025 14:30:00] - [FIXED, HOTFIX, LESSON_LEARNED]

<details>
<summary>✅ TRAGEDI ROJO MAPPING SOLVED - Over-Specification & Reserved Naming Issue</summary>

**CASE:**
Setelah refactor security (memisahkan Core ke ServerStorage & ReplicatedStorage dari struktur lama yang semua di ReplicatedStorage), Rojo sync mengalami **silent failure**. Script & LocalScript muncul di Explorer Studio dengan struktur yang benar, tetapi **konten file KOSONG**.

**TIMELINE SINGKAT:**

- **Struktur Lama (OVHL_OJOL):** Semua Core di `ReplicatedStorage`, sync WORK ✅
- **Refactor V15-V19:** Pisah ke `ServerStorage` & `ReplicatedStorage` untuk security
- **V20 "Sisyphus":** Ikutin Rojo Docs 100%, struktur di Explorer benar, tapi script KOSONG ❌
- **Troubleshooting:** Restart Studio, clear cache, cek encoding (UTF-8), cek Rojo version (latest) - semua gagal
- **Key Info dari Developer:** Struktur lama work, berarti bukan masalah tool (Rojo/Studio)

**PROBLEMATIKA (Root Cause Analysis):**

1.  **Over-Specification di `default.project.json`:**

    ```json
    // ❌ SALAH (Yang gue coba):
    "ServerScriptService": {
      "$className": "ServerScriptService",
      "init": {
        "$className": "Script",  // ← Over-specified!
        "$path": "src/server/init.server.lua"
      }
    }
    ```

    **Masalah:** Rojo punya auto-detection dari file extension (`.server.lua` → Script, `.client.lua` → LocalScript). Nambah `$className` explicit di child level malah bikin **conflict** atau Rojo bingung.

2.  **Reserved Naming (`init`):** Entry point file bernama `init.server.lua` kemungkinan **conflict** dengan Rojo's internal indexing system (Rojo pake `init.lua` untuk folder indexing).

**SOLUSI FINAL (Yang Work):**

```json
{
  "name": "OVHL_OS_FIXED",
  "tree": {
    "$className": "DataModel",

    "ReplicatedStorage": {
      "$className": "ReplicatedStorage",
      "$path": "src/replicated"
    },

    "ServerStorage": {
      "$className": "ServerStorage",
      "$path": "src/serverstorage"
    },

    "ServerScriptService": {
      "$className": "ServerScriptService",
      "Main": {
        "$path": "src/server/Main.server.lua" // ← TANPA $className!
      }
    },

    "StarterPlayer": {
      "$className": "StarterPlayer",
      "StarterPlayerScripts": {
        "$className": "StarterPlayerScripts",
        "Main": {
          "$path": "src/client/Main.client.lua" // ← TANPA $className!
        }
      }
    }
  }
}
```

**PERUBAHAN KRUSIAL:**

1.  ✅ **Rename entry point:** `init.server.lua` → `Main.server.lua`
2.  ✅ **Hapus `$className` di child level** - Cukup `$path` + extension yang jelas
3.  ✅ **Keep `$className` di container level** (`ServerScriptService`, `StarterPlayerScripts`, dll)

**KEY LEARNINGS (Best Practices Rojo Mapping):**

| Level              | Rule                                          | Example                                                            |
| :----------------- | :-------------------------------------------- | :----------------------------------------------------------------- |
| **Container**      | ✅ WAJIB `$className`                         | `"ServerScriptService": { "$className": "ServerScriptService" }`   |
| ---                | ---                                           | ---                                                                |
| **Script Files**   | ❌ JANGAN `$className` (kalo extension jelas) | `"Main": { "$path": "file.server.lua" }`                           |
| **ModuleScript**   | ❌ JANGAN `$className`                        | `"Module": { "$path": "Module.lua" }` (`.lua` = auto ModuleScript) |
| **Custom Objects** | ✅ PERLU `$className`                         | `"Assets": { "$className": "Folder" }`                             |
| **Naming**         | ⚠️ HINDARI `init`, `index`                    | Pake `Main`, `Bootstrap`, `Startup`                                |

**ROJO AUTO-DETECTION:**

- `.server.lua` → `Script`
- `.client.lua` → `LocalScript`
- `.lua` (plain) → `ModuleScript`

**HASIL:**

- ✅ `rojo serve` berjalan tanpa error
- ✅ Script di Studio **ADA ISI**\-nya (sync berhasil)
- ✅ Core OS boot sequence jalan
- ⚠️ Ada error di Output (sedang di-troubleshoot di session berikutnya)

**NOTES/TIPS:**

- **Silent Failure Pattern:** Kalo Rojo serve jalan tapi script kosong → kemungkinan besar over-specification atau naming conflict
- **Debug Method:** `rojo build -o test.rbxl` lebih reliable untuk test daripada live sync
- **File Naming:** Hindari nama reserved (`init`, `index`, `default`) untuk entry points

**STRUKTUR FILE FINAL (V20 Fixed):**

```bash
src/
├── client/
│   └── Main.client.lua       (Entry point client)
├── replicated/
│   ├── Core/
│   │   ├── Kernel/
│   │   │   └── ClientBootstrapper.lua
│   │   └── Services/
│   │       ├── InputService.lua
│   │       └── UIManager.lua
│   ├── Modules/
│   │   └── pingpong/
│   │       ├── manifest.lua
│   │       └── PingPong.client.lua
│   └── Shared/
│       ├── Utils/
│       │   └── Logger.lua
│       └── Config.lua
├── server/
│   └── Main.server.lua       (Entry point server)
└── serverstorage/
    ├── Core/
    │   ├── Kernel/
    │   │   └── ServerBootstrapper.lua
    │   └── Services/
    │       ├── DataService.lua
    │       ├── EventService.lua
    │       ├── ReplicationService.lua
    │       ├── ServiceManager.lua
    │       ├── StyleService.lua
    │       ├── SystemMonitor.lua
    │       ├── TagService.lua
    │       └── ZoneService.lua
    └── Modules/
        └── pingpong/
            └── PingPong.server.lua
```

**STATUS:**

- ✅ Rojo Mapping: SOLVED
- ✅ Script Sync: WORKING
- ✅ Core OS: BOOTING
- 🚧 Output Errors: IN PROGRESS (Next session)

**CREDITS:**

- Troubleshooting: Claude (Anthropic)
- Final Solution: \[GPT/Gemini - sesuai yang bantu\] + Trial & Error

**IMPACT:**

- ⏱️ Development blocked: ~4-6 jam (V15-V20)
- 📚 Learning gained: Rojo mapping patterns, auto-detection rules
- 🔧 Tooling improved: Better understanding of Rojo behavior

</details>

## [24-10-2025 19:11:00] - [BUG, HOTFIX, DOKS, REFACTOR]

<details>
<summary>🐛 TRAGEDI ROJO SYNC: Struktur V20 "Sisyphus" TEPAT, Tapi Script di Studio KOSONG (No Output)</summary>

**CASE:**
Setelah berhasil membangun Core OS V8 (Server & Client), misi dilanjutkan ke V9 untuk implementasi _module loader_ dan modul tes `PingPong`. Namun, meskipun `kurir.js` sukses, output di Roblox Studio menunjukkan **0 modul di-load**. Ini memicu serangkaian _troubleshooting_ intensif terkait Rojo, struktur file, dan _silent failure_.

**PROBLEMATIKA (Rangkaian Tragedi):**

1.  **Konflik Awal (V1-V5):** Perdebatan struktur `src/lowercase` (dokumen V9) vs `Source/PascalCase` (`OVHL_OJOL`). Menyebabkan Rojo mapping error dan `require` path salah total. Di-solve di V5 dengan adopsi `Source/`.
2.  **Typo AI (V6, V11):** Kesalahan AI dalam generate `kurir.js` menyebabkan crash (`sm:Log`, `obj.logger`). Di-solve dengan Hotfix V7 & V12.
3.  **Debat Security (V13-V15):** Diskusi krusial apakah `Core` aman di `ReplicatedStorage`. Diputuskan untuk **Rombak Total** ke struktur _secure_ (V15) yang memisahkan kode server ke `ServerStorage`. Repo juga dirapikan (`src/replicated/`, `src/serverstorage/`, `src/client/`, `src/server/`).
4.  **Rojo vs Nama File (V15):** Ditemukan bahwa Rojo _error_ jika entry point (`init.server.lua`) mengandung titik (`.`) _kecuali_ dipaksa dengan `$className`.
5.  **Fix `$className` (V16):** `default.project.json` di-patch pake `$className`. `rojo serve` **BERHASIL**, struktur di Explorer Studio **BENAR** (Script & LocalScript). **TAPI TETAP TIDAK ADA OUTPUT**.
6.  **Isolasi Masalah (V17):** Penambahan `print()` di baris 1 `init.lua` tetap tidak muncul. Tes manual _tanpa Rojo_ **BERHASIL**. **Kesimpulan: Rojo Sync SILENT FAILURE**.
7.  **Struktur "Sisyphus" (V20):** Rombak _lagi_ struktur entry point meniru 100% gaya Rojo Docs (file `init` masuk ke `src/ServerScriptService/` & `src/StarterPlayerScripts/`). `rojo serve` **BERHASIL**.
8.  **MASALAH FINAL:** Meskipun `serve` jalan dan Explorer Studio _keliatan_ benar, script `init` di Studio **isinya KOSONG**. Rojo gagal menyalin _konten_ file.

**SOLUSI DICOBA (Yang Gagal Mengatasi "No Output"):**

- Restart Total (Rojo, Studio, Komputer).
- Ganti Baseplate baru.
- Cek Properti Script (`Disabled=false`).
- Rename Entry Point di JSON (V18) -> Malah bikin `serve` error lagi.
- Revert JSON ke V16 ($className).
- Implementasi struktur Sisyphus (V20).
- Clear Cache Studio & Tes Sync Simpel. -> _User belum konfirmasi hasil ini._

**STATUS SEKARANG (V20):**

- ✅ Struktur file di VS Code sudah final (V20 - Rapi & Aman).
- ✅ `default.project.json` sudah final (V20 - Sisyphus Mapping).
- ✅ `rojo serve` berjalan **TANPA ERROR**.
- ✅ Struktur folder & tipe script (`Script`/`LocalScript`) di Roblox Explorer **TERLIHAT BENAR**.
- ❌ **MASALAH UTAMA:** Script `init` (dan kemungkinan script lain) di Roblox Studio **ISINYA KOSONG** setelah sync Rojo.
- ❌ Akibatnya: **TIDAK ADA OUTPUT** sama sekali saat Play.

**STRUKTUR FILE SEKARANG (V20 - Sesuai Audit):**

```
📁 OVHL_OS
├── 📁 Docs
│   ├── 📝 00_AI_CONSTITUTION.md
│   ├── 📝 01_OVHL_ENGINE_SPEC.md
│   ├── 📝 02_OVHL_MODULE_ARCHITECTURE.md
│   ├── 📝 03_OVHL_BUILDER_GUIDE.md
│   └── 📝 04_DEV_LOGS.md
├── 📁 src
│   ├── 📁 client
│   │   └── 🔷 init.client.lua
│   ├── 📁 replicated
│   │   ├── 📁 Core
│   │   │   ├── 📁 Kernel
│   │   │   │   └── 🔷 ClientBootstrapper.lua
│   │   │   └── 📁 Services
│   │   │       ├── 🔷 InputService.lua
│   │   │       └── 🔷 UIManager.lua
│   │   ├── 📁 Modules
│   │   │   └── 📁 pingpong
│   │   │       ├── 🔷 manifest.lua
│   │   │       └── 🔷 PingPong.client.lua
│   │   └── 📁 Shared
│   │       ├── 📁 Utils
│   │       │   └── 🔷 Logger.lua
│   │       └── 🔷 Config.lua
│   ├── 📁 server
│   │   └── 🔷 init.server.lua
│   └── 📁 serverstorage
│       ├── 📁 Core
│       │   ├── 📁 Kernel
│       │   │   └── 🔷 ServerBootstrapper.lua
│       │   └── 📁 Services
│       │       ├── 🔷 DataService.lua
│       │       ├── 🔷 EventService.lua
│       │       ├── 🔷 ReplicationService.lua
│       │       ├── 🔷 ServiceManager.lua
│       │       ├── 🔷 StyleService.lua
│       │       ├── 🔷 SystemMonitor.lua
│       │       ├── 🔷 TagService.lua
│       │       └── 🔷 ZoneService.lua
│       └── 📁 Modules
│           └── 📁 pingpong
│               └── 🔷 PingPong.server.lua
├── 📋 default.project.json
├── 📜 kurir.js
└── 📄 selene.toml
```

**ROJO SYNC SEKARANG (`default.project.json` V20):**

```json
{
  "name": "OVHL_OS_V20_SISYPHUS",
  "tree": {
    "$className": "DataModel",

    "ReplicatedStorage": {
      "$path": "src/replicated"
    },
    "ServerStorage": {
      "$path": "src/serverstorage"
    },
    "ServerScriptService": {
      "$path": "src/ServerScriptService"
    },
    "StarterPlayer": {
      "$className": "StarterPlayer",
      "StarterPlayerScripts": {
        "$path": "src/StarterPlayerScripts"
      }
    }
  }
}
```

**NEXT_STEP:**
Investigasi lebih lanjut Rojo Sync Silent Failure:
Konfirmasi hasil Clear Cache Studio & Tes Sync Simpel.
Cek versi Rojo & Roblox Studio.
Coba sync ke project Roblox yang benar-benar baru (bukan cuma baseplate).
Jika semua gagal, pertimbangkan lapor bug ke Rojo.

**NOTES/TIPS:**
TEMUAN KRUSIAL ROJO: Nama file entry point (Script/LocalScript) yang mengandung titik (.) kemungkinan membutuhkan $className di default.project.json agar tipenya benar. Namun, ini tidak menyelesaikan masalah sync konten kosong.

DOKUMEN USANG: Dokumen 00_AI_CONSTITUTION.md dan 01_OVHL_ENGINE_SPEC.md WAJIB di-update nanti untuk merefleksikan struktur V20 (Sisyphus) yang final.

</details>

## [24-10-2025 17:31:00] - [HOTFIX, REFACTOR]

<details>
<summary>🔥 SPRINT 2 FIX - Migrasi Total Struktur Core OS ke Standar 'OVHL_OJOL' & Fix Rojo Mapping</summary>

**CASE:**
Setelah eksekusi `kurir.js` SPRINT 2 (pembuatan Core OS awal), `rojo serve` gagal total. Output di Roblox Studio kosong atau Rojo error `File $path ... not found`.

**PROBLEMATIKA (Masalah Utama):**

1.  **KONFLIK DOKUMEN vs. REALITA:** Ada konflik besar antara dokumen `00_AI_CONSTITUTION.md` (V9) dan `01_OVHL_ENGINE_SPEC.md` yang mewajibkan struktur `src/lowercase`, melawan `default.project.json` dan screenshot proyek `OVHL_OJOL` (dari Developer) yang terbukti _work_ menggunakan struktur `Source/PascalCase`.
2.  **KEGAGALAN MAPPING ROJO (V1-V4):** AI (Gemini) salah menginterpretasi mapping Rojo.
    - **V1 & V2:** Mencoba mapping seluruh `src/` ke `ReplicatedStorage.ovhl_game`. GAGAL.
    - **V3 & V4:** Mencoba menggunakan folder `server/` dan `client/` di _root_ project. GAGAL, Rojo tidak menemukan file (`File $path: server/init.server.lua`).
3.  **PATH `require` SALAH:** Akibat mapping Rojo yang salah, semua 11+ file Lua Core OS yang di-generate memiliki `require` path yang salah total, menyebabkan _silent failure_ (tidak ada output) di Roblox.

**SOLVED (V5):**

1.  **Keputusan Kunci:** Developer (Hanif) memberikan `default.project.json` dan screenshot `OVHL_OJOL` sebagai "Master Key" / "Kebenaran Tunggal".
2.  **Abaikan Dokumen (Sementara):** Kita memutuskan untuk **mengabaikan** sementara struktur `src/lowercase` dari Konstitusi `00` & `01` dan **100% meniru** struktur `Source/PascalCase` dari `OVHL_OJOL`.
3.  **Kurir V5 (Reset Total):** AI men-generate `kurir.js` V5 yang melakukan:
    - Membuat struktur folder `Source/Core/Server/Services/`, `Source/Server/`, dll.
    - Menulis ulang `default.project.json` agar 100% identik dengan `OVHL_OJOL`.
    - Menulis ulang **SEMUA 11+ file Core OS** (`ServerBootstrapper.lua`, `ServiceManager.lua`, `Init.server.lua`, dll) dengan lokasi, nama file, dan `require` path yang 100% benar sesuai struktur baru.

**HASIL:**

- `rojo serve` berhasil.
- Log output Roblox (Server & Client) sukses 100% tanpa error.
- Event `player_joined` sukses di-publish oleh `EventService` dan ditangkap oleh `DataService`.
- **SPRINT 2 (Core OS MVP) resmi SELESAI dan STABIL.**

**NOTES/TIPS:**

- Dokumen `00_AI_CONSTITUTION.md` dan `01_OVHL_ENGINE_SPEC.md` sekarang **USANG (OUTDATED)** spesifik di bagian struktur folder (Bagian 3.2 di `00` dan 2.1 di `01`). Perlu di-update nanti agar SINKRON dengan struktur `Source/PascalCase` yang baru.
- Dokumen `00_AI_CONSTITUTION.md` dan `01_OVHL_ENGINE_SPEC.md` sekarang telah diperbarui dan bisa digunakan kembali.

</details>

## [24-10-2025 14:50:00] - [REFACTOR, DOKS]

<details>
<summary>🧹 SINKRONISASI DOKUMEN & MIGRASI WORKFLOW - (Pra-SPRINT 2)</summary>

**PROGRESS:**

- Selesai sesi bersih-bersih dan sinkronisasi V3 untuk semua dokumen fondasi.
- **Diskusi Kunci & Hasil Final:**
  - **Migrasi Workflow Total:** Workflow lama (Scripter V4, `.sh`, `devtools.js`) resmi **DIBUANG**.
  - **Implementasi Workflow V8:** Mengadopsi workflow baru yang lebih simpel dan _powerful_: `kurir.js` (Smart Script Node.js).
  - **Sinkronisasi `00_AI_CONSTITUTION.md`:** Bagian `3.1 (Siklus Dev)` dan `3.3 (Struktur Tools)` telah di-patch (via `kurir.js` v3.0) agar 100% merefleksikan workflow `kurir.js`.
  - **Klarifikasi Aturan Core:** Aturan `1.1.3` (Core Kontekstual) berhasil di-fix manual.
  - **Sinkronisasi `01_OVHL_ENGINE_SPEC.md`:** Label `Core/` di-patch (via `kurir.js` v3.1) dari `READ-ONLY` menjadi `KONSETEKSTUAL`. Referensi ke file `05_DEV_LOGS.md` yang usang juga telah dihapus.
  - **Sinkronisasi `03_OVHL_BUILDER_GUIDE.md`:** Aturan Core untuk Builder di-patch (via `kurir.js` v3.2) agar selaras dengan `00_AI_CONSTITUTION.md`.
- **Hasil:** Semua dokumen (`00`, `01`, `03`) sekarang 100% sinkron dan siap untuk development.

**STATUS PROYEK SAAT INI:**

- ✅ **Fondasi Dokumen:** V3 Final, 100% Sinkron.
- ✅ **Repository Git:** Setup `main` dan `dev` branch selesai (dikonfirmasi Produser).
- ✅ **Toolchain Awal:** Siap (`package.json` untuk dependensi & `kurir.js` sebagai runner AI).

**NEXT_STEP:**

- **Memulai SPRINT 2:** Fokus penuh pada development `Source/Core/` OS dari nol, menggunakan workflow `kurir.js`.

**BLOCKER:**

- Tidak ada. Fondasi bersih dan solid.

**NOTES/TIPS:**

- Ini adalah _hard reset_ pada workflow. AI (Gemini/Asprod) sekarang WAJIB mematuhi Konstitusi V8 (`kurir.js`) dan dilarang keras menyarankan workflow lama.

</details>

---

## [24-10-2025 08:30:00] - [REFACTOR]

<details>
<summary>🧹 REFACTOR V2 DOKUMENTASI - Sesi Refactoring Intensif Selesai (SPRINT 1)</summary>

**PROGRESS:**

- Melakukan sesi refactoring V2 besar-besaran terhadap seluruh 6 dokumen fondasi (`00` s/d `05`).
- **Diskusi Kunci & Hasil Final:**
  - Perombakan struktur file (`02` -> `00`, geser nomor).
  - Implementasi penomoran hirarkis di semua dokumen.
  - Penguatan `00_AI_CONSTITUTION.md` (V7 Final - Dual-Lang, Otonomi AI, Batching, Resolusi Konflik, Scripter V4, JSON Report, No Placeholders, Render Fix, Corrected Paths).
  - Koreksi path di `01_OVHL_ENGINE_SPEC.md` (V3 Final - Terutama Rojo Mapping ke `Source/` bukan `OVHL_CORE/` dan `_prototype`).
  - Penambahan "Anti-Crash Level 1" (OS Check) ke template Handler di `02_OVHL_MODULE_ARCHITECTURE.md` (V2.1 Final).
  - Penambahan "Nota Dinamis" ke `03_OVHL_BUILDER_GUIDE.md` (V2.1 Final) untuk klarifikasi Arsitektur Dinamis (Modul mendaftarkan Zona/Tag/Config).
  - Pembaruan `04_PROGRESS_LOG.md` (V2.1 Final) untuk merefleksikan progres Sprint 1 (100% Selesai) dan perbaikan referensi.
  - Finalisasi `05_DEV_LOGS.md` (V2 Final - File ini) dengan penomoran V2 dan log ini.
  - Finalisasi `package.json` untuk Toolchain Node.js.
- **Hasil:** Menghasilkan 6 Draf Dokumen V2 FINAL + 1 `package.json` FINAL, siap untuk di-save oleh Developer.

**NEXT_STEP:**

- Developer (Hanif) menyimpan semua 7 file ini.
- Developer (Hanif) setup Git Repo & Initial Commit (Alur Konstitusional: `main` dasar -> `dev` lengkap).
- Developer (Hanif) clone ulang, checkout `dev`, `npm install`.
- Memulai SPRINT 2 (Coding `devtools.js` MVP).

**BLOCKER:**

- Tidak ada. Sprint 1 Selesai. Menunggu eksekusi Developer.

**NOTES/TIPS:**

- Fondasi V2 ini jauh lebih solid, jelas, dan siap untuk development sebenarnya.
- Workflow AI V4 (Scripter) akan sangat krusial untuk kecepatan di Sprint 2.

</details>

---

## [23-10-2025 14:00:00] - [DOKS]

<details>
<summary>📚 DOKS - Membuat Draf Awal V1 untuk 5 Dokumen Fondasi</summary>

**PROGRESS:**

- Membuat draf V1 untuk `01_OVHL_ENGINE_SPEC.md`.
- Membuat draf V1 untuk `02_OVHL_DEV_PROTOCOLS.md`.
- Membuat draf V1 untuk `03_OVHL_MODULE_ARCHITECTURE.md`.
- Membuat draf V1 untuk `04_BUILDER_GUIDE.md`.
- Membuat draf V1 untuk `05_PROGRESS_LOG.md`.

**BLOCKER:**

- Workflow AI (manual copas) tidak efisien.
- Ambiguitas arsitektur (Statis vs Dinamis).
- Kesalahan struktur path (`OVHL_CORE/`).

</details>

---

## **END OF DOCUMENT**
