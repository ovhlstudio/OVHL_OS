# 🚀 01_OVHL_ENGINE_SPEC.md - OMNIVERSE HIGHLAND CORE OS

> 🏛️ **Project:** Omniverse Highland - Multi-Game Engine
> 📄 **Dokumen:** Spesifikasi Teknis Core Engine
> 🏷️ **Versi:** 3.0.0 (Corrected Paths)
> 👑 **Founder:** Hanif Saifudin
> 🟢 **Status:** AKTIF (Sesuai Konstitusi `00`)

---

## 💎 1.0 BRAND IDENTITY & FILOSOFI

### 1.1 💡 Filosofi Inti (Core Philosophy)

(🇮🇩) "Build Once, Deploy Everywhere". Prinsip ini memandu semua keputusan arsitektur.
(🇬🇧) **"Build Once, Deploy Everywhere". This principle guides all architectural decisions.**

```lua
-- Prinsip OVHL (Sesuai Konstitusi 00)
OVHL_PRINCIPLES = {
    "ZERO_TOUCH_CORE",    -- (Ref: 00_AI_CONSTITUTION.md - Protokol 1.1.3)
    "AUTO_DISCOVERY",     -- Modul mendaftarkan diri secara otomatis
    "BUILDER_FIRST",      -- Tools visual untuk non-koder (Ref: 03_BUILDER_GUIDE.md)
    "AI_READY",           -- Dukungan co-development AI penuh (Ref: 00_AI_CONSTITUTION.md)
    "MULTI_GAME",         -- Satu core, banyak game
    "HOT_RELOAD",         -- Development tanpa restart
}
```

### 1.2 🔭 Visi Kekuatan (Power Vision)

**"Tidak hanya framework, tapi ecosystem development lengkap"**

- 🧑‍🎨 Builder bisa setup game tanpa coding.
- 🧑‍💻 Developer bisa bikin fitur kompleks dalam hitungan jam.
- 🤖 AI bisa lanjutkan project tanpa _lost context_.
- 🎮 Satu core bisa handle berbagai genre game.

---

## 🏛️ 2.0 TINJAUAN ARSITEKTUR

### 2.1 🗺️ Struktur Folder Revolusioner (Corrected Paths)

(🇮🇩) Struktur ini WAJIB dipatuhi oleh AI dan Developer (Ref: `00_AI_CONSTITUTION.md - Protokol 3.2`). Path relatif dari Root Project.
(🇬🇧) **This structure MUST be adhered to by AI and Developers (Ref: `00_AI_CONSTITUTION.md - Protocol 3.2`). Paths relative to Project Root.**

```bash
📁 ./                       <-- ROOT PROJECT (e.g., OVHL_OS/)
├── 📁 Source/                 # Kode Game
│   ├── 📁 Core/                # Inti Engine (❌ READ-ONLY AI)
│   │   ├── 📁 Kernel/           # Bootstrapper & ServiceManager
│   │   ├── 📁 Server/           # Logika Sisi Server
│   │   │   ├── 📁 Services/    # Layanan Global (Data, Event, Zone)
│   │   │   └── 📁 Systems/     # Sistem Inti (Network, Migration)
│   │   ├── 📁 Client/           # Logika Sisi Client
│   │   │   ├── 📁 Services/    # Layanan UI, Input, Audio
│   │   │   └── 📁 Systems/     # Sistem Sisi Client
│   │   └── 📁 Shared/           # Kode Bersama Server-Client
│   │       ├── 📁 Config/      # Konfigurasi Default
│   │       └── 📁 Utils/       # Utilitas Bersama
│   ├── 📁 Modules/              # Modul Gameplay (✅ AI AREA)
│   │   ├── 📁 Server/           # Modul Sisi Server
│   │   ├── 📁 Client/           # Modul Sisi Client
│   │   └── 📁 Shared/           # Modul Bersama
│   └── 📁 Games/                # Profil Spesifik Game (✅ AI AREA)
│       ├── 📁 _prototype/       # Profil Default/Awal
│       ├── 📁 OjolRoleplay/     # Contoh Profil Game A
│       └── 📁 RacingGame/       # Contoh Profil Game B
├── 📁 Tools/                   # Toolchain Developer (✅ AI AREA)
│   ├── 📁 Bash/
│   ├── 📁 Node/
│   ├── 🚀 devtools.js          # Runner Utama
│   ├── 📁 Exports/             # Hasil Laporan
│   └── 📄 README_TOOLS.md
├── 📁 Docs/                    # Dokumentasi Proyek (✅ AI AREA)
│   ├── 📄 00_AI_CONSTITUTION.md
│   ├── 📄 01_OVHL_ENGINE_SPEC.md # (File ini)
│   ├── 📄 02_OVHL_MODULE_ARCHITECTURE.md
│   ├── 📄 03_OVHL_BUILDER_GUIDE.md
│   ├── 📄 04_PROGRESS_LOG.md
│   └── 📄 05_DEV_LOGS.md
├── 📄 default.project.json     # Konfigurasi Rojo
├── 📄 package.json             # Konfigurasi Node.js
├── 📄 package-lock.json
├── 📄 .gitignore               # Pengabaian Git
└── 📁 node_modules/            # Dependensi Node (Diabaikan Git)
```

### 2.2 🔗 Struktur Proyek Rojo (Corrected Paths)

(🇮🇩) Struktur ini mendefinisikan bagaimana file di-sync ke Roblox Studio. Catatan penting ada di bawah kode.
(🇬🇧) **This structure defines how files are synced to Roblox Studio. Important notes are below the code.**

```json
{
  "name": "OVHL_OS_ENGINE",
  "tree": {
    "$className": "DataModel",
    "ReplicatedStorage": {
      "$className": "ReplicatedStorage",
      "OVHL_Core": {
        "$path": "Source/Core"
      },
      "OVHL_Modules": {
        "$path": "Source/Modules"
      },
      "OVHL_GameConfig": {
        "$path": "Source/Games/_prototype"
      }
    },
    "ServerScriptService": {
      "$className": "ServerScriptService",
      "OVHL_Bootstrap": {
        "$path": "Source/Core/Kernel/ServerBootstrapper.lua"
      }
    },
    "StarterPlayer": {
      "$className": "StarterPlayer",
      "StarterPlayerScripts": {
        "$className": "StarterPlayerScripts",
        "OVHL_Client": {
          "$path": "Source/Core/Kernel/ClientBootstrapper.lua"
        }
      }
    }
  }
}
```

**CATATAN PENTING (Rojo Mapping):**

1.  **GameConfig Path:** Path `"Source/Games/_prototype"` digunakan sebagai _default_ yang aman untuk _initial setup_. Pastikan folder `_prototype` **ada** (meskipun kosong) di `Source/Games/` untuk menghindari error Rojo. Nanti, gunakan _script_ di `Tools/devtools.js` (misal: `npm run set-game OjolRoleplay`) untuk mengubah path ini ke game profile yang aktif sebelum sync Rojo.
2.  **Folder `Tools/` dan `Docs/`:** Folder-folder ini **sengaja tidak dimasukkan** dalam mapping Rojo karena berisi _developer tools_ dan dokumentasi, bukan _runtime assets_ game.

---

## ⚙️ 3.0 ARSITEKTUR SISTEM INTI (CORE SYSTEMS)

_(Path internal di dalam Core tetap sama, karena relatif terhadap folder `Source/Core/`)_

### 3.1 ⚡ Sistem Bootstrap Cerdas (Intelligent Bootstrap System)

- **Lokasi:** `Source/Core/Kernel/SmartBootstrapper.lua`
- **Fungsi:**
  - `AutoDetectGameProfile()`: Deteksi game (`Source/Games/`) & load config.
  - `ScanAndLoadModules()`: Scan folder `Source/Modules/` (Ref: `02_OVHL_MODULE_ARCHITECTURE.md`), auto-register, & selesaikan dependensi.
  - `HealthCheck()`: Validasi semua sistem sebelum start.

### 3.2 🔥 Mesin Hot-Reload (Hot-Reload Engine)

- **Lokasi:** `Source/Core/Server/Systems/HotReloadEngine.lua` (Contoh Path Server System)
- **Fungsi:**
  - `LiveModuleUpdate()`: Update modul tanpa restart game (mempertahankan state).
  - `ConfigHotSwap()`: Ganti nilai config secara real-time.
  - `StatePreservation()`: Backup state sebelum reload, restore setelah reload.

### 3.3 🖌️ Rangkaian Tools Builder Visual (Builder Visual Tools Suite)

- **Lokasi:** (Akan diimplementasikan, kemungkinan di dalam `Tools/` tapi di-_load_ khusus oleh Studio Plugin atau mekanisme lain, BUKAN di-sync via Rojo ke game).
- **Fungsi (Konseptual):** (Dirinci di `03_OVHL_BUILDER_GUIDE.md`)
  - `ZonePainter()`: Membuat zona via drag-and-drop.
  - `SpawnPointEditor()`: Menaruh titik spawn via klik.
  - `RealTimeConfig()`: Panel konfigurasi in-game (untuk testing di Studio).

### 3.4 🔄 Sistem Migrasi Otomatis (Auto-Migration System)

- **Lokasi:** `Source/Core/Server/Systems/MigrationEngine.lua` (Contoh Path Server System)
- **Fungsi:**
  - `VersionTracking()`: Lacak versi modul & deteksi isu kompatibilitas.
  - `SmartDataUpgrade()`: Auto-konversi data player ke skema baru.
  - `RollbackProtection()`: Backup data sebelum migrasi.

### 3.5 🎮 Arsitektur Multi-Game (Multi-Game Architecture)

- **Lokasi:** `Source/Core/Kernel/GameProfileManager.lua` (Contoh Path Kernel)
- **Fungsi:**
  - `SwitchGameProfile()`: Load profil game yang berbeda secara dinamis dari `Source/Games/`.
  - Manajemen aset & modul spesifik per game.

```lua
-- Contoh GameProfiles (Path sudah relatif dari Source/Games/)
OVHL.GameManager = {
    GameProfiles = {
        OjolRoleplay = {
            requiredModules = {"DeliverySystem", "CompanySystem", "VehicleSystem"},
            config = "Games/OjolRoleplay/config.lua",
            assets = "Games/OjolRoleplay/assets/"
        },
        RacingGame = {
            requiredModules = {"RaceSystem", "VehicleCustomization", "TrackSystem"},
            config = "Games/RacingGame/config.lua",
            assets = "Games/RacingGame/assets/"
        }
    }
}
```

---

## 📏 4.0 STANDAR KODING (STRICT ENFORCEMENT)

(🇮🇩) Standar ini WAJIB dipatuhi oleh AI saat men-generate skrip (Ref: `00_AI_CONSTITUTION.md`).
(🇬🇧) **These standards MUST be enforced by the AI when generating scripts (Ref: `00_AI_CONSTITUTION.md`).**

### 4.1 CASE Aturan Case (Case Rules) - Toleransi Nol

```lua
-- ✅ BENAR - Sesuai standar OVHL

-- PascalCase: Classes, Modules, Services
local PlayerService = {}
local VehicleController = {}

-- camelCase: variables, functions, methods
local playerHealth = 100
function getPlayerData() end

-- snake_case: constants, config keys, events
local MAX_HEALTH = 1000
local PLAYER_JOINED_EVENT = "player_joined"

-- kebab-case: HANYA untuk nama folder (di luar kode Lua)
-- "vehicle-system", "ui-components" (Contoh di Modules/)
```

### 4.2 ❌ Contoh Salah (Dilarang)

```lua
-- ❌ DILARANG - Akan gagal validasi
local player_health = 100      -- (snake_case untuk variable)
local CalculateDamage = ()       -- (PascalCase untuk function)
local maxHealth = 1000           -- (camelCase untuk constant)
```

---

## 🚀 5.0 FITUR UNIK & ROADMAP

### 5.1 ✨ Fitur Unik OVHL

1.  **AI Context Preservation:** AI bisa melanjutkan development dari state terakhir.
2.  **Real-time Collaboration:** Multiple builder/dev kerja simultan (via Git & Tools).
3.  **Intelligent Performance:** Adaptive loading modul berdasarkan area.

### 5.2 🎯 Metrik Sukses - Target 30 Hari

- **Minggu 1 (Selesai):** Fondasi Dokumen V2 & Setup Awal.
- **Minggu 2:** Fondasi Inti (Bootstrap, Core Services Minimal, Module System Dasar).
- **Minggu 3:** Fitur Lanjutan Awal (Hot-Reload Dasar, Visual Tools MVP).
- **Minggu 4:** Integrasi & Testing Awal (Tes Bootstrap & Modul Dasar).

### 5.3 🛣️ Roadmap Masa Depan (Pasca 30 Hari)

- **Fase 2:** AI Co-Pilot Canggih (`devtools.js` diperkaya, _command_ lebih banyak).
- **Fase 3:** Integrasi Cloud (DataStore2 / ProfileService).
- **Fase 4:** Ekosistem Marketplace (Belum direncanakan detail).

---

## 🚑 6.0 PROTOKOL DARURAT & MAINTENANCE

### 6.1 🚨 Protokol Darurat (Emergency Protocols - Diimplementasikan di Core)

- `AutoRollback`: Jika `SmartBootstrapper` gagal load service kritis, masuk `RecoveryMode`.
- `HealthMonitoring`: Service `SystemMonitor` akan memantau _heartbeat_ service lain.
- `RecoveryMode`: Mode darurat dengan modul minimal / hanya Core Services.

### 6.2 🧹 Tools Maintenance (Diimplementasikan via `devtools.js`)

- `npm run check:core`: Menjalankan _health check_ dasar.
- (Future) `npm run cleanup:data`: Membersihkan data orphaned.
- (Future) `npm run migrate:schema`: Menjalankan migrasi skema data.

---

> "Code is like humor. When you have to explain it, it’s bad." – Cory House

---

**END OF DOCUMENT**

## _Copyright © 2025 - Omniverse Highland Studio_
