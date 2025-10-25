# 🧩 02_OVHL_MODULE_ARCHITECTURE.md - Kitab Suci Development Modul

| 🏛️ **Project** | Omniverse Highland (OVHL)              |
| :------------- | :------------------------------------- |
| 📄 **Dokumen** | Standar Arsitektur & Development Modul |
| 🏷️ **Versi**   | 3.0.0 (Koreksi Path V9)                |
| 👑 **Founder** | Hanif Saifudin                         |
| 🚨 **Status**  | **AKTIF (Sesuai Konstitusi \`00\`)**   |

---

## 💡 1.0 FILOSOFI & PRINSIP DESAIN

### 1.1 🧠 Pola Pikir Modul Inti (Core Module Mindset)

(🇮🇩) "Setiap modul adalah kota mandiri dalam negara OVHL."
(🇬🇧) **"Every module is an independent city within the OVHL nation."**

```lua
-- Prinsip Modul OVHL
OVHL_MODULE_PRINCIPLES = {
    "SINGLE_RESPONSIBILITY",  -- Satu modul, satu tanggung jawab
    "PLUG_AND-PLAY",          -- Bisa ditambah/hapus tanpa efek samping
    "CONFIG_DRIVEN",          -- Behavior dikontrol via config, bukan code
    "EVENT_BASED",            -- Komunikasi via events, bukan direct calls
    "AUTO_DISCOVERABLE",      -- System otomatis detect (Ref: 01_SPEC 3.1)
    "HOT_RELOAD_READY",       -- Support live updates (Ref: 01_SPEC 3.2)
    "DEFENSIVE_DESIGN"        -- Selalu pasang logic anti-crash / nil-check
}
```

### 1.2 🎯 Struktur File Modul (V9)

(🇮🇩) Semua modul baru yang di-generate AI harus mengikuti struktur \`flat\` dan \`lowercase\` yang ditetapkan di Konstitusi V9 (Ref: \`00_AI_CONSTITUTION.md 3.2\`).

```bash
📁 src/modules/
└── 📁 [nama_modul_lowercase]/ # WAJIB lowercase & Flat (misal: "simplehud")
    ├── 📄 manifest.lua            # Metadata Modul (Wajib)
    ├── 📄 [PascalName]Handler.lua # Entry Point / Logika Inti (Wajib)
    ├── 📄 [PascalName]Config.lua  # Setting Default (Wajib)
    ├── 📄 README.md               # Dokumentasi Khusus (Wajib)
    └── 📁 tests/                  # Opsional
```

---

## 2.0 PROTOKOL KEAMANAN & KETAHANAN

### 2.1 🛡️ Desain Defensif (Anti-Crash)

(🇮🇩) Setiap Modul Handler WAJIB melakukan `nil-check` pada Core Service yang di-inject. Jika `Core OS` tidak ditemukan, Modul harus `return nil` untuk mencegah _crash_ sistem.
(🇬🇧) **Every Module Handler MUST perform a `nil-check` on injected Core Services. If the Core OS is not found, the Module must `return nil` to prevent system crash.**

### 2.2 🔌 Protokol Injeksi Ketergantungan (Dependency Injection)

(🇮🇩) Modul **DILARANG** `require()` service inti secara manual. Modul harus _minta_ Core Service melalui `context` yang disediakan oleh `ServiceManager` (Ref: `01_SPEC 4.0`).
(🇬🇧) **Modules are FORBIDDEN from manually `require()`ing Core Services. Modules must _request_ Core Services via the `context` provided by `ServiceManager`.**

---

## 9.0 CONTOH IMPLEMENTASI (MINIMAL)

### 9.1 Simple HUD (Client-Side)

Ini adalah struktur minimal yang dibutuhkan Modul Client _SimpleHUD_ agar bisa di-load oleh OVHL Core OS.

**Path & File (SESUAI V9):**

```lua
-- src/modules/simplehud/manifest.lua
return {
    -- ... (Identitas)
    name = "SimpleHUD",
    version = "1.0.0",

    -- ... (Dependencies)
    depends = { "UIManager" }, -- Asumsi UIManager adalah Core Service

    -- ... (Loading Config)
    side = "CLIENT",        -- WAJIB!
    autoInit = true,
    loadOrder = 10,

    -- Entry Point harus menunjuk ke nama file Handler (tanpa .lua)
    entry = "SimpleHUDHandler"
}
```

```lua
-- src/modules/simplehud/SimpleHUDHandler.lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local OVHL_ENV = ReplicatedStorage:WaitForChild("ovhl", 5)

if not OVHL_ENV or not OVHL_ENV:FindFirstChild("core") then
    warn("!! [OVHL_ERROR] Module 'SimpleHUD' GAGAL LOAD. Core OS (ovhl/core) tidak ditemukan!!")
    return nil
end

local SimpleHUDHandler = {}
function SimpleHUDHandler:init(context)
    -- Asumsi UIManager adalah Core Service Client yang di-inject
    self.UIManager = context.UIManager
    print("📱 SimpleHUD [Anti-Crash OK] aktif!")
end
function SimpleHUDHandler:start() end
function SimpleHUDHandler:stop() end

return SimpleHUDHandler

-- Jangan lupa file Config, Tests, README kosong
```

---

## 🔭 10.0 PENGEMBANGAN MASA DEPAN

### 10.1 Fitur Terencana (Pasca-Prototipe)

```lua
OVHL.FutureModuleFeatures = {
    "MODULE_MARKETPLACE",     -- Berbagi/jual-beli modul
    "AUTO_SCALING",           -- Manajemen sumber daya dinamis
    "MACHINE_LEARNING",       -- Optimisasi modul prediktif
    "CROSS_GAME_MODULES",     -- Modul yang berfungsi lintas game
    "VISUAL_MODULE_BUILDER"   -- Membuat modul via drag-and-drop
}
```

### 10.2 Pernyataan Penutup

> **"Arsitektur modul yang solid adalah fondasi untuk game yang tak terbatas."**

**END OF DOCUMENT**

## _Copyright © 2025 - Omniverse Highland Studio_
