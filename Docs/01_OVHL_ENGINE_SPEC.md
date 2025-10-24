# 🚀 01_OVHL_ENGINE_SPEC.md - OMNIVERSE HIGHLAND CORE OS

| 🏛️ **Project** | Omniverse Highland (OVHL)                  |
| :------------- | :----------------------------------------- |
| 📄 **Dokumen** | Spesifikasi Teknis Core Engine             |
| 🏷️ **Versi**   | 4.0.0 (Path V9 Final & Naming Consistency) |
| 👑 **Founder** | Hanif Saifudin                             |
| 🚨 **Status**  | **AKTIF (Sesuai Konstitusi \`00\`)**       |

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
    "HOT_RELOAD",         -- Development tanpa restart (Ref: 3.2)
}
```

---

## 🏛️ 2.0 TINJAUAN ARSITEKTUR

### 2.1 🗺️ **CONTOH** Struktur Folder Revolusioner (V9 Paths)

(🇮🇩) Struktur ini WAJIB dipatuhi oleh AI dan Developer (Ref: \`00_AI_CONSTITUTION.md - Protokol 3.2\`). Path relatif dari Root Project.
(🇬🇧) **This structure MUST be adhered to by AI and Developers. Paths relative to Project Root.**

```text
📁 ./                                 # root project
├── 📁 Source/
│   ├── 📁 Client/
│   │   └── 📄 Init.client.lua         # Entrypoint Client
│   │
│   ├── 📁 Server/
│   │   └── 📄 Init.server.lua         # Entrypoint Server
│   │
│   ├── 📁 Core/                      # Core OS (di ReplicatedStorage)
│   │   ├── 📁 Client/
│   │   │   ├── 📁 Kernel/
│   │   │   │   └── ClientBootstrapper.lua
│   │   │   └── 📁 Services/
│   │   │       ├── UIService.lua
│   │   │       └── InputService.lua
│   │   │
│   │   ├── 📁 Server/
│   │   │   ├── 📁 Kernel/
│   │   │   │   ├── ServerBootstrapper.lua
│   │   │   │   └── ModuleLoader.lua
│   │   │   └── 📁 Services/
│   │   │       ├── ServiceManager.lua
│   │   │       ├── EventService.lua
│   │   │       ├── DataService.lua
│   │   │       └── ReplicationService.lua
│   │   │
│   │   └── 📁 Shared/
│   │       └── 📁 Utils/
│   │           └── Logger.lua
│   │
│   ├── 📁 Modules/                   # Gameplay Modules
│   │   ├── 📁 simplehud/
│   │   ...
│   └── 📁 Replicated/                # Aset Game Profile
│       ├── 📁 assets/
│       ...
│
├── 📁 Tools/                         # Developer Tools
│   └── 📁 ovhl-tools/
│
├── 📁 docs/                          # Documentation
│   ├── 00_AI_CONSTITUTION.md
│   └── 01_OVHL_ENGINE_SPEC.md
│
└── 📄 default.project.json           # Rojo config
```

### 2.2 🔗 Struktur Proyek Rojo (Corrected Paths)

(🇮🇩) Struktur ini mendefinisikan bagaimana file di-sync ke Roblox Studio.
(🇬🇧) **This structure defines how files are synced to Roblox Studio.**

```json
{
  "name": "OVHL_OJOL_CLONE",
  "tree": {
    "$className": "DataModel",
    "ReplicatedStorage": {
      "Core": {
        "$path": "Source/Core"
      },
      "Modules": {
        "$path": "Source/Modules"
      },
      "Replicated": {
        "$path": "Source/Replicated"
      }
    },
    "ServerScriptService": {
      "Init": {
        "$path": "Source/Server/Init.server.lua"
      }
    },
    "StarterPlayer": {
      "StarterPlayerScripts": {
        "Init": {
          "$path": "Source/Client/Init.client.lua"
        }
      }
    }
  }
}
```

**CATATAN PENTING (Rojo Mapping):**

1.  **GameConfig Path:** Path \`src/games/_prototype\` digunakan sebagai \_default_ yang aman untuk _initial setup_. Nanti, gunakan _script_ di `kurir.js` untuk mengubah path ini ke game profile yang aktif sebelum sync Rojo.
2.  **Folder \`Tools/\` dan \`docs/\`:** Folder-folder ini **sengaja tidak dimasukkan** dalam mapping Rojo karena berisi _developer tools_ dan dokumentasi.

---

## ⚙️ 3.0 ARSITEKTUR SISTEM INTI (CORE SYSTEMS)

### 3.1 ⚡ Sistem Bootstrap Cerdas (Intelligent Bootstrap System)

- **Lokasi:** \`src/core/kernel/ModuleLoader.lua\` (Fungsi inti)
- **Fungsi:**
  - \`AutoDetectGameProfile()\`
  - \`ScanAndLoadModules()\` (Scan folder \`src/modules/\`)
  - \`HealthCheck()\`

### 3.2 🔥 Mesin Hot-Reload (Hot-Reload Engine)

- **Lokasi:** \`src/core/services/server/HotReloadEngine.lua\`
- **Fungsi:** \`LiveModuleUpdate()\`, \`ConfigHotSwap()\`, \`StatePreservation()\`

### 3.3 🖌️ Rangkaian Tools Builder Visual (Builder Visual Tools Suite)

- **Lokasi:** (Konseptual, dikelola oleh Plugin/Tools)
- **Fungsi:** (Dirinci di \`03_OVHL_BUILDER_GUIDE.md\`)

### 3.4 🔄 Sistem Migrasi Otomatis (Auto-Migration System)

- **Lokasi:** \`src/core/services/server/MigrationEngine.lua\`
- **Fungsi:** \`VersionTracking()\`, \`SmartDataUpgrade()\`, \`RollbackProtection()\`

### 3.5 🎮 Arsitektur Multi-Game (Multi-Game Architecture)

- **Lokasi:** \`src/core/kernel/GameProfileManager.lua\`
- **Fungsi:** \`SwitchGameProfile()\`

```lua
-- Contoh GameProfiles
OVHL.GameManager = {
    GameProfiles = {
        -- ...
    }
}
```

---

## 4.0 SERVICE INJECTION PROTOCOL

### 4.1 💉 Aturan Injeksi (Injection Rules)

(🇮🇩) Core Services **DILARANG KERAS** memanggil satu sama lain secara langsung. Komunikasi **WAJIB** melalui \`EventService\` (\`src/core/services/shared/EventService.lua\`) atau injeksi melalui \`ServiceManager\`.
(🇬🇧) **Core Services MUST NOT call each other directly. Communication MUST be via \`EventService\` or injection via \`ServiceManager\`.**

### 4.2 Contoh Injeksi ke Modul

```lua
-- Dari ServiceManager.lua
local function setupModuleContext(module)
    return {
        EventService = ServiceManager:getSharedService("EventService"),
        DataService = ServiceManager:getServerService("DataService"),
        -- ...
    }
end
```

---

## 5.0 TARGET & ROADMAP

### 5.1 🌟 Visi Jangka Pendek (V1 Prototype Goals)

- **Fungsionalitas:** Minimum set Core Services berjalan, Modul Loader berfungsi.
- **Performa:** Intelligent Performance: Adaptive loading modul berdasarkan area.

### 5.2 🎯 Metrik Sukses - Target 30 Hari

- **Minggu 1 (Selesai):** Fondasi Dokumen V4 & Setup Awal.
- **Minggu 2:** Fondasi Inti (Bootstrap, Core Services Minimal, Module System Dasar).
- **Minggu 3:** Fitur Lanjutan Awal (Hot-Reload Dasar, Visual Tools MVP).
- **Minggu 4:** Integrasi & Testing Awal (Tes Bootstrap & Modul Dasar).

### 5.3 🛣️ Roadmap Masa Depan (Pasca 30 Hari)

- **Fase 2:** AI Co-Pilot Canggih (_Smart Script_ diperkaya, _command_ lebih banyak).
- **Fase 3:** Integrasi Cloud (DataStore2 / ProfileService).
- **Fase 4:** Ekosistem Marketplace (Belum direncanakan detail).

---

## 🚑 6.0 PROTOKOL DARURAT & MAINTENANCE

### 6.1 🚨 Protokol Darurat (Emergency Protocols - Diimplementasikan di Core)

- \`AutoRollback\`: Jika _Bootstrap_ gagal load service kritis, masuk \`RecoveryMode\`.
- \`HealthMonitoring\`: Service \`SystemMonitor\` akan memantau _heartbeat_ service lain.
- \`RecoveryMode\`: Mode darurat dengan modul minimal / hanya Core Services.

### 6.2 🧹 Tools Maintenance (Diimplementasikan via \`kurir.js\`)

- \`npm run check:core\`: (Implementasi via \`kurir.js\`) Cek kesehatan Core Services.
- \`npm run audit:all\`: (Implementasi via \`kurir.js\`) Jalankan Audit Generator dan buat laporan (Ref: \`README_TOOLS.md\`).

> "Code is like humor. When you have to explain it, it’s bad." – Cory House

---

**END OF DOCUMENT**

## _Copyright © 2025 - Omniverse Highland Studio_
