# 🚀 01_OVHL_ENGINE_SPEC.MD - OMNIVERSE HIGHLAND CORE OS

| 🏛️ **Project** | Omniverse Highland (OVHL)            |
| :------------- | :----------------------------------- |
| 📄 **Dokumen** | Spesifikasi Teknis Core Engine       |
| 🏷️ **Versi**   | **5.0.0 (Revisi V10.2 Compliance)**  |
| 👑 **Founder** | Hanif Saifudin                       |
| 🗓️ **Update**  | 25 Oktober 2025                      |
| 🚨 **Status**  | **AKTIF (Sesuai Konstitusi \`00\`)** |

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

### 2.1 🗺️ Struktur Folder V10 (Sesuai Konstitusi `00` 3.2)

(🇮🇩) Struktur ini WAJIB dipatuhi oleh AI dan Developer. Path `lowercase` (`src/`) adalah standar baru menggantikan `Source/PascalCase` yang usang.
(🇬🇧) **This structure MUST be adhered to by AI and Developers. `src/lowercase` paths are the new standard, replacing the obsolete `Source/PascalCase`.**

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

### 2.2 🔗 Struktur Proyek Rojo V10 ("Hybrid Fix")

(🇮🇩) Struktur ini mendefinisikan bagaimana file di-sync ke Roblox Studio. Ini adalah "Master Kebenaran" yang terbukti work (Ref: `04_DEV_LOGS 14:30:00`).
(🇬🇧) **This structure defines how files are synced to Roblox Studio. This is the "Master Truth" (Ref: `04_DEV_LOGS 14:30:00`).**

```json
{
  "name": "OVHL_OS_HYBRID_FIX",
  "tree": {
    "$className": "DataModel",

    "ReplicatedStorage": {
      "$path": "src/replicated"
    },

    "ServerStorage": {
      "$path": "src/serverstorage"
    },

    "ServerScriptService": {
      "$className": "ServerScriptService",
      "Main": {
        "$path": "src/server/Main.server.lua"
      }
    },

    "StarterPlayer": {
      "$className": "StarterPlayer",
      "StarterPlayerScripts": {
        "$className": "StarterPlayerScripts",
        "Main": {
          "$path": "src/client/Main.client.lua"
        }
      }
    }
  }
}
```

**CATATAN PENTING (Rojo Mapping):**

1.  **GameConfig Path:** Path `src/games/_prototype` (jika ada) digunakan sebagai _default_ yang aman. Nanti, gunakan _script_ di `kurir.js` untuk mengubah path ini ke game profile yang aktif.
2.  **Folder \`Tools/\` dan \`docs/\`:** Folder-folder ini **sengaja tidak dimasukkan** dalam mapping Rojo karena berisi _developer tools_ dan dokumentasi.

---

## ⚙️ 3.0 ARSITEKTUR SISTEM INTI (CORE SYSTEMS)

### 3.1 ⚡ Sistem Bootstrap Cerdas (Intelligent Bootstrap System)

- **Lokasi:** `src/serverstorage/Core/Kernel/ServerBootstrapper.lua` & `.../ModuleLoader.lua`
- **Fungsi:**
  - `AutoDetectGameProfile()`
  - `ScanAndLoadModules()` (Scan folder `src/replicated/Modules/` & `src/serverstorage/Modules/`)
  - `HealthCheck()`

### 3.2 🔥 Mesin Hot-Reload (Hot-Reload Engine)

- **Lokasi:** `src/serverstorage/Core/Services/HotReloadEngine.lua` (Asumsi Path)
- **Fungsi:** `LiveModuleUpdate()`, `ConfigHotSwap()`, `StatePreservation()`

### 3.3 🖌️ Rangkaian Tools Builder Visual (Builder Visual Tools Suite)

- **Lokasi:** (Konseptual, dikelola oleh Plugin/Tools)
- **Fungsi:** (Dirinci di \`03_OVHL_BUILDER_GUIDE.md\`)

### 3.4 🔄 Sistem Migrasi Otomatis (Auto-Migration System)

- **Lokasi:** `src/serverstorage/Core/Services/MigrationEngine.lua` (Asumsi Path)
- **Fungsi:** `VersionTracking()`, `SmartDataUpgrade()`, `RollbackProtection()`

### 3.5 🎮 Arsitektur Multi-Game (Multi-Game Architecture)

- **Lokasi:** `src/serverstorage/Core/Kernel/GameProfileManager.lua` (Asumsi Path)
- **Fungsi:** `SwitchGameProfile()`

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

(🇮🇩) Core Services **DILARANG KERAS** memanggil satu sama lain secara langsung. Komunikasi **WAJIB** melalui \`EventService\` (`src/serverstorage/Core/Services/EventService.lua`) atau injeksi melalui \`ServiceManager\`.
(🇬🇧) **Core Services MUST NOT call each other directly. Communication MUST be via \`EventService\` or injection via \`ServiceManager\`.**

### 4.2 Contoh Injeksi ke Modul

```lua
-- Dari ServiceManager.lua (Server-side)
local function setupModuleContext(module)
    return {
        EventService = ServiceManager:getService("EventService"),
        DataService = ServiceManager:getService("DataService"),
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

- **Minggu 1 (Selesai):** Fondasi Dokumen V5 (Konstitusi V10) & Setup Awal.
- **Minggu 2:** Fondasi Inti (Bootstrap, Core Services Minimal, Module System Dasar).
- **Minggu 3:** Fitur Lanjutan Awal (Hot-Reload Dasar, Visual Tools MVP).
- **Minggu 4:** Integrasi & Testing Awal (Tes Bootstrap & Modul Dasar).

### 5.3 🛣️ Roadmap Masa Depan (Pasca 30 Hari)

- **Fase 2:** AI Co-Pilot Canggih (`kurir.js` & `ovhl-tools` yang lebih canggih).
- **Fase 3:** Integrasi Cloud (DataStore2 / ProfileService).
- **Fase 4:** Ekosistem Marketplace (Belum direncanakan detail).

---

## 🚑 6.0 PROTOKOL DARURAT & MAINTENANCE

### 6.1 🚨 Protokol Darurat (Emergency Protocols - Diimplementasikan di Core)

- \`AutoRollback\`: Jika _Bootstrap_ gagal load service kritis, masuk \`RecoveryMode\`.
- \`HealthMonitoring\`: Service \`SystemMonitor\` akan memantau _heartbeat_ service lain.
- \`RecoveryMode\`: Mode darurat dengan modul minimal / hanya Core Services.

### 6.2 🧹 Tools Maintenance (Diimplementasikan via `kurir.js` / `ovhl-tools`)

- \`npm run check:core\`: (Implementasi via `kurir.js`) Cek kesehatan Core Services.
- \`npm run audit:all\`: (Implementasi via `kurir.js`) Jalankan Audit Generator dan buat laporan.

> "Code is like humor. When you have to explain it, it’s bad." – Cory House

---

**END OF DOCUMENT**

## _Copyright © 2025 - Omniverse Highland Studio_
