# 🚀 01_OVHL_ENGINE_SPEC.md - OMNIVERSE HIGHLAND CORE OS

> 🏛️ **Project:** Omniverse Highland - Multi-Game Engine
> 📄 **Dokumen:** Spesifikasi Teknis Core Engine
> 🏷️ **Versi:** 2.0.0 (Refactored)
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

### 2.1 🗺️ Struktur Folder Revolusioner

(🇮🇩) Struktur ini WAJIB dipatuhi oleh AI dan Developer (Ref: `00_AI_CONSTITUTION.md - Protokol 3.2`).
(🇬🇧) **This structure MUST be adhered to by AI and Developers (Ref: `00_AI_CONSTITUTION.md - Protocol 3.2`).**

```bash
📁 OVHL_CORE/
├── 📁 Source
│   ├── 🎯 Core/                   (❌ ZERO TOUCH | READ-ONLY)
│   │   ├── 📁 Kernel/             # Bootstrapper & ServiceManager
│   │   ├── 📁 Server/
│   │   │   ├── 📁 Services/      # Global services (Data, Event, Zone)
│   │   │   └── 📁 Systems/      # Core systems (Network, Migration)
│   │   ├── 📁 Client/
│   │   │   ├── 📁 Services/      # UI, Input, Audio services
│   │   │   └── 📁 Systems/      # Client-side systems
│   │   └── 📁 Shared/
│   │       ├── 📁 Config/        # Konfigurasi game
│   │       └── 📁 Utils/        # Utilitas bersama
│   ├── 🧩 Modules/                (✅ DEVELOPER & AI AREA)
│   │   ├── 📁 Server/            # Modul gameplay server
│   │   ├── 📁 Client/            # Modul UI/Controller client
│   │   └── 📁 Shared/            # Modul cross-platform
│   ├── 🎮 Games/                   (🎯 PROFIL GAME | AI & DEV AREA)
│   │   ├── 📁 OjolRoleplay/      # Konfigurasi game A
│   │   ├── 📁 RacingGame/        # Konfigurasi game B
│   │   └── 📁 RPGSandbox/        # Konfigurasi game C
├── 🛠️ Tools/                      (🔧 DEVELOPMENT TOOLS | AI & DEV AREA)
│   ├── 📁 VisualEditor/          # In-game world builder
│   ├── 📁 AICoPilot/             # Asisten AI (Ref: 00_AI_CONSTITUTION.md)
│   └── 📁 Dashboard/             # Monitoring real-time
└── 📚 DOCS/                       (📖 DOKUMENTASI | WAJIB UPDATE)
    ├── 📄 00_AI_CONSTITUTION.md     # (Aturan Inti & AI)
    ├── 📄 01_OVHL_ENGINE_SPEC.md    # (File ini)
    ├── 📄 02_OVHL_MODULE_ARCHITECTURE.md # (Blueprint Modul)
    ├── 📄 03_OVHL_BUILDER_GUIDE.md    # (Manual Builder)
    ├── 📄 04_PROGRESS_LOG.md        # (Log Makro)
    └── 📄 05_DEV_LOGS.md            # (Log Mikro)
```

_(CATATAN: Referensi dokumen di atas telah diperbarui ke V2)_

### 2.2 🔗 Struktur Proyek Rojo

(🇮🇩) Struktur ini mendefinisikan bagaimana file di-sync ke Roblox Studio.
(🇬🇧) **This structure defines how files are synced to Roblox Studio.**

```json
{
  "name": "OVHL_CORE_ENGINE",
  "tree": {
    "$className": "DataModel",
    "ReplicatedStorage": {
      "OVHL_Core": { "$path": "OVHL_CORE/Source/Core" },
      "OVHL_Modules": { "$path": "OVHL_CORE/Source/Modules" },
      "OVHL_GameConfig": { "$path": "OVHL_CORE/Source/Games/CurrentGame" }
    },
    "ServerScriptService": {
      "OVHL_Bootstrap": {
        "$path": "OVHL_CORE/Source/Core/Kernel/ServerBootstrapper.lua"
      }
    },
    "StarterPlayer": {
      "StarterPlayerScripts": {
        "OVHL_Client": {
          "$path": "OVHL_CORE/Source/Core/Kernel/ClientBootstrapper.lua"
        }
      }
    },
    "ServerStorage": {
      "OVHL_Tools": { "$path": "OVHL_CORE/Tools/" }
    }
  }
}
```

---

## ⚙️ 3.0 ARSITEKTUR SISTEM INTI (CORE SYSTEMS)

### 3.1 ⚡ Sistem Bootstrap Cerdas (Intelligent Bootstrap System)

- **Lokasi:** `Core/Kernel/SmartBootstrapper.lua`
- **Fungsi:**
  - `AutoDetectGameProfile()`: Deteksi game (`Games/`) & load config.
  - `ScanAndLoadModules()`: Scan folder `Modules/` (Ref: `02_OVHL_MODULE_ARCHITECTURE.md`), auto-register, & selesaikan dependensi.
  - `HealthCheck()`: Validasi semua sistem sebelum start.

### 3.2 🔥 Mesin Hot-Reload (Hot-Reload Engine)

- **Lokasi:** `Core/Systems/HotReloadEngine.lua`
- **Fungsi:**
  - `LiveModuleUpdate()`: Update modul tanpa restart game (mempertahankan state).
  - `ConfigHotSwap()`: Ganti nilai config secara real-time.
  - `StatePreservation()`: Backup state sebelum reload, restore setelah reload.

### 3.3 🖌️ Rangkaian Tools Builder Visual (Builder Visual Tools Suite)

- **Lokasi:** `Tools/VisualEditor/BuilderTools.lua`
- **Fungsi:** (Dirinci di `03_OVHL_BUILDER_GUIDE.md`)
  - `ZonePainter()`: Membuat zona via drag-and-drop.
  - `SpawnPointEditor()`: Menaruh titik spawn via klik.
  - `RealTimeConfig()`: Panel konfigurasi in-game.
- **Fitur Panel In-Game:**
  - "Zone Visualization - Lihat semua tag zones dengan warna"
  - "Spawn Point Preview - Visual spawn density"
  - "Real-time Config Editing - Edit values tanpa restart"
  - "Performance Overlay - Monitor FPS, memory, network"
  - "AI Assistant Panel - Natural language commands"

### 3.4 🔄 Sistem Migrasi Otomatis (Auto-Migration System)

- **Lokasi:** `Core/Systems/MigrationEngine.lua`
- **Fungsi:**
  - `VersionTracking()`: Lacak versi modul & deteksi isu kompatibilitas.
  - `SmartDataUpgrade()`: Auto-konversi data player ke skema baru.
  - `RollbackProtection()`: Backup data sebelum migrasi.

### 3.5 🎮 Arsitektur Multi-Game (Multi-Game Architecture)

- **Lokasi:** `Core/Systems/GameProfileManager.lua`
- **Fungsi:**
  - `SwitchGameProfile()`: Load profil game yang berbeda secara dinamis.
  - Manajemen aset & modul spesifik per game.

```lua
-- Contoh GameProfiles
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
            assets = "GamesK/RacingGame/assets/"
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
-- "vehicle-system", "ui-components"
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
2.  **Real-time Collaboration:** Multiple builder/dev kerja simultan.
3.  **Intelligent Performance:** Adaptive loading modul berdasarkan area.

### 5.2 🎯 Metrik Sukses - Target 30 Hari

- **Minggu 1-2:** Fondasi Inti (Bootstrap, Core Services, Module System).
- **Minggu 3:** Fitur Lanjutan (Hot-Reload, Visual Tools).
- **Minggu 4:** Polish & Integrasi (Auto-Migration, AI Context, Testing).

### 5.3 🛣️ Roadmap Masa Depan (Pasca 30 Hari)

- **Fase 2:** AI Co-Pilot Canggih (Natural language to code).
- **Fase 3:** Integrasi Cloud (Cloud saves, cross-server).
- **Fase 4:** Ekosistem Marketplace (Module & Asset store).

---

## 🚑 6.0 PROTOKOL DARURAT & MAINTENANCE

### 6.1 🚨 Protokol Darurat (Emergency Protocols)

- `AutoRollback`: Jika sistem crash, revert ke versi stabil terakhir.
- `HealthMonitoring`: Cek kesehatan sistem real-time.
- `RecoveryMode`: Safe mode dengan modul minimal.

### 6.2 🧹 Tools Maintenance (Maintenance Tools)

- `CleanupOrphanedData()`: Bersihkan data yang tidak terpakai.
- `RepairCorruptedModules()`: Perbaiki modul yang rusak.
- `OptimizeDatabase()`: Optimasi database.

---

> "Code is like humor. When you have to explain it, it’s bad." – Cory House

---

**END OF DOCUMENT**

## _Copyright © 2025 - Omniverse Highland Studio_
