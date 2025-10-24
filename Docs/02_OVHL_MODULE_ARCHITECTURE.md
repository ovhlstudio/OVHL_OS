# 🧩 02_OVHL_MODULE_ARCHITECTURE.md - Kitab Suci Development Modul

> 🏛️ **Project:** Omniverse Highland - Multi-Game Engine
> 📄 **Dokumen:** Standar Arsitektur & Development Modul
> 🏷️ **Versi:** 2.1.0 (Final w/ Anti-Crash & Corrected Refs)
> 👑 **Founder:** Hanif Saifudin
> 🟢 **Status:** AKTIF (Sesuai Konstitusi `00`)

---

## 💡 1.0 FILOSOFI & PRINSIP DESAIN

### 1.1 🧠 Pola Pikir Modul Inti (Core Module Mindset)

(🇮🇩) "Setiap modul adalah kota mandiri dalam negara OVHL."
(🇬🇧) **"Every module is an independent city within the OVHL nation."**

```lua
-- Prinsip Modul OVHL
OVHL_MODULE_PRINCIPLES = {
    "SINGLE_RESPONSIBILITY",  -- Satu modul, satu tanggung jawab
    "PLUG_AND_PLAY",          -- Bisa ditambah/hapus tanpa efek samping
    "CONFIG_DRIVEN",          -- Behavior dikontrol via config, bukan code
    "EVENT_BASED",            -- Komunikasi via events, bukan direct calls
    "AUTO_DISCOVERABLE",      -- System otomatis detect (Ref: 01_SPEC 3.1)
    "HOT_RELOAD_READY",       -- Support live updates (Ref: 01_SPEC 3.2)
    "DEFENSIVE_DESIGN",       -- Anti-Crash & Fault-Tolerant (Baru)
}
```

### 1.2 🏗️ Tipe Arsitektur Modul

| Tipe              | Tujuan                   | Lokasi (Ref: `00_CONST 3.2`) | Contoh                         |
| :---------------- | :----------------------- | :--------------------------- | :----------------------------- |
| **Server Module** | Logika game, data        | `Source/Modules/Server/`     | `ShopSystem`, `QuestManager`   |
| **Client Module** | UI, kontrol, visual      | `Source/Modules/Client/`     | `MainHUD`, `VehicleController` |
| **Shared Module** | Utilitas lintas platform | `Source/Modules/Shared/`     | `MathUtils`, `GameConstants`   |

---

## 🗺️ 2.0 STANDAR STRUKTUR MODUL

### 2.1 📦 Template Modul Standar

```bash
📁 ./Source/Modules/
└── 📁 [ModuleType]/ (Server, Client, Shared)
    └── 📁 [ModuleName]/ (PascalCase)
        ├── 📄 manifest.lua            -- WAJIB: Metadata modul
        ├── ⚙️ [ModuleName]Handler.lua   -- WAJIB: Logika inti
        ├── 🎨 [ModuleName]Config.lua   -- WAJIB: Nilai konfigurasi
        ├── 🧪 [ModuleName]Tests.lua    -- WAJIB: Tes otomatis
        ├── 📖 README_[ModuleName].md   -- WAJIB: Dokumentasi
        └── 📄 [ModuleName]Utils.lua    -- OPSIONAL: Fungsi helper
```

### 2.2 📑 Template Konten File

#### 2.2.1 📄 manifest.lua (WAJIB)

(🇮🇩) Ini adalah "KTP" modul. Dibaca oleh `SmartBootstrapper` (Ref: `01_SPEC 3.1`).
(🇬🇧) **This is the module's "ID Card". Read by the `SmartBootstrapper` (Ref: `01_SPEC 3.1`).**

```lua
-- ============================================
-- OVHL RBLX Framework v2.1.0
-- Studio: Omniverse Highland Studio
-- Founder: Hanif Saifudin
-- Module: [ModuleName]
-- Purpose: [Deskripsi singkat tujuan modul]
-- ============================================

return {
    -- === 1. IDENTITAS ===
    name = "[ModuleName]",            -- PascalCase, e.g., "ShopSystem"
    version = "1.0.0",                -- Semantic versioning
    description = "[Deskripsi detail modul]",

    -- === 2. DEPENDENSI ===
    depends = {                       -- Modul lain yang dibutuhkan
        "DataService",                -- Core services (Nama Service di Source/Core/)
        "EventService",
        -- "OtherModule"              -- Modul gameplay lain (Nama Modul di Source/Modules/)
    },

    -- === 3. KONFIGURASI LOADING ===
    loadOrder = 10,                   -- 1-100 (Kecil = duluan load)
    autoInit = true,                  -- true = auto start, false = manual

    -- === 4. ENTRY POINT ===
    entry = "Handler",                -- File handler utama (tanpa .lua)

    -- === 5. KONTRAK EVENT (EVENT CONTRACT) ===
    subscribesTo = {                  -- Events yang didengar modul ini
        "player_joined",
        "player_data_loaded",
    },

    publishes = {                     -- Events yang disiarkan modul ini
        "shop_item_purchased",
        "inventory_updated",
    },

    -- === 6. SKEMA KONFIGURASI (Untuk validasi di Config Manager) ===
    configSchema = {
        enabled = "boolean",
        maxItems = "number",
        currencyType = "string"
    }
}
```

#### 2.2.2 ⚙️ Handler Template (Server/Client) - (WAJIB)

(🇮🇩) Logika inti. **Telah disuntik "Anti-Crash Level 1" (OS Check).**
(🇬🇧) **Core logic. Injected with "Anti-Crash Level 1" (OS Check).**

```lua
-- ============================================
-- OVHL RBLX Framework v2.1.0
-- Founder: Hanif Saifudin
-- Module: [ModuleName] Handler
-- Purpose: Logika inti untuk [ModuleName]
-- ============================================

-- --- FASE 0: ANTI-CRASH LEVEL 1 (OS CHECK) ---
-- (Sesuai Filosofi Anti-Crash)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CORE_OS_PATH = ReplicatedStorage:WaitForChild("OVHL_Core", 5) -- Timeout 5 detik

if not CORE_OS_PATH then
    -- OS GAK KETEMU! Berhenti dengan aman, jangan crash game.
    warn("!! [OVHL_ERROR] Module '[ModuleName]' GAGAL LOAD. Core OS (OVHL_Core) tidak ditemukan di ReplicatedStorage!!")

    -- TODO: Tampilkan GUI Error Visual jika ini modul Client

    return nil -- Hentikan eksekusi modul ini dengan aman
end
print("[OVHL] OS Check OK for [ModuleName].")
-- --- END OF FASE 0 ---


-- --- FASE 1: INISIALISASI MODUL ---
local [ModuleName]Handler = {}
[ModuleName]Handler.__index = [ModuleName]Handler

-- Private variables (snake_case)
local _isInitialized = false
local _moduleConfig = nil
local _context = nil -- Menyimpan dependencies (termasuk Core Services dari OS)

-- === METODE PUBLIK (Siklus Hidup Modul) ===

-- Dipanggil oleh SmartBootstrapper setelah semua dependensi ter-load
function [ModuleName]Handler:init(context)
    if _isInitialized then
        warn("[ModuleName] sudah diinisialisasi!")
        return
    end

    -- Simpan dependencies (Core Services, Config, dll)
    _context = context
    self.DataService = context.DataService -- Disuntik oleh OS
    self.EventService = context.EventService -- Disuntik oleh OS

    -- Load konfigurasi modul
    _moduleConfig = self:_loadConfiguration()

    -- Inisialisasi sistem internal modul
    self:_setupEventListeners()
    self:_initializeSystems()

    _isInitialized = true
    print("[ModuleName] berhasil diinisialisasi!")
end

-- Dipanggil oleh SmartBootstrapper jika autoInit = true
function [ModuleName]Handler:start()
    if not _isInitialized then
        error("[ModuleName] harus di-init() sebelum di-start()!")
    end

    -- Mulai proses aktif modul (loop, listener, dll)
    self:_startBackgroundProcesses()

    print("[ModuleName] is now running!")
end

-- Dipanggil saat shutdown atau hot-reload
function [ModuleName]Handler:stop()
    if not _isInitialized then return end -- Sudah berhenti

    -- Hentikan semua proses aktif & cleanup resources
    self:_cleanupEventListeners()
    self:_stopBackgroundProcesses()

    _isInitialized = false
    print("[ModuleName] telah dihentikan.")
end

-- === METODE PRIVATE (Logika Internal Modul - prefix _) ===

function [ModuleName]Handler:_loadConfiguration()
    -- Prioritas: DataService (jika ada) > File Config Lokal
    local config = self.DataService:GetModuleConfig("[ModuleName]")

    if not config then
        warn("[ModuleName] Config tidak ditemukan di DataService, load fallback dari file Config.")
        -- Bootstrapper akan inject path ke file config lokal
        config = require(_context.ConfigPath) or {}
    end

    -- Validasi config terhadap schema (opsional tapi bagus)
    -- local isValid, errMsg = self:_validateConfig(config)
    -- if not isValid then warn("Config [ModuleName] tidak valid:", errMsg) end

    -- Terapkan defaults jika ada nilai yang hilang (contoh)
    local defaults = require(script.Parent:FindFirstChild("[ModuleName]Config")) -- Ambil default dari file
    for key, value in pairs(defaults) do
        if config[key] == nil then
            config[key] = value
        end
    end
    -- Bisa juga validasi tipe data di sini

    return config
end

function [ModuleName]Handler:_setupEventListeners()
    -- Berlangganan ke event global dari EventService
    self.EventService:Subscribe("player_joined", function(player)
        self:_onPlayerJoined(player)
    end)

    self.EventService:Subscribe("player_data_loaded", function(playerData)
        self:_onPlayerDataLoaded(playerData)
    end)
end

function [ModuleName]Handler:_initializeSystems()
    -- Inisialisasi state atau sub-komponen internal modul (jika ada)
    self._internalState = {
        activePlayers = {},
        systemReady = true
    }
    print("[ModuleName] Sistem internal diinisialisasi.")
end

function [ModuleName]Handler:_startBackgroundProcesses()
    -- Contoh: Mulai loop update per detik, dll.
    print("[ModuleName] Proses background dimulai.")
end

function [ModuleName]Handler:_cleanupEventListeners()
    -- PENTING: Unsubscribe semua listener untuk mencegah memory leak saat stop/reload!
    self.EventService:UnsubscribeAll(self) -- Asumsi EventService punya fitur ini
    print("[ModuleName] Event listeners di-cleanup.")
end

function [ModuleName]Handler:_stopBackgroundProcesses()
    -- Hentikan semua loop/proses background
    print("[ModuleName] Proses background dihentikan.")
end

-- === CONTOH EVENT HANDLER ===

function [ModuleName]Handler:_onPlayerJoined(player)
    -- Handle event player join
    if not _isInitialized or not _moduleConfig.enabled then return end -- Cek modul aktif
    print("[ModuleName] Event Player joined:", player.Name)

    -- Contoh: Menambahkan player ke state internal
    self._internalState.activePlayers[player.UserId] = player

    -- Contoh: Menyiarkan event SPESIFIK modul ini
    self.EventService:Publish("[module_name]_player_ready", {
        player = player,
        timestamp = os.time()
    })
end

function [ModuleName]Handler:_onPlayerDataLoaded(playerData)
    -- Handle event data player sudah siap
    if not _isInitialized or not _moduleConfig.enabled then return end
    print("[ModuleName] Event Player data loaded:", playerData.UserId)
end

-- === CONTOH FUNGSI PUBLIK MODUL (jika perlu dipanggil modul lain - JARANG!) ===
-- function [ModuleName]Handler:DoSomethingPublic(arg1, arg2)
--   if not _isInitialized then return end
--   -- Sebaiknya hindari ini, gunakan event
-- end

return [ModuleName]Handler
```

#### 2.2.3 🎨 Config Template (WAJIB)

(🇮🇩) Nilai default. Akan di-override oleh `DataService` atau `GameProfile` (Ref: `01_SPEC 3.5`).
(🇬🇧) **Default values. Will be overridden by `DataService` or `GameProfile` (Ref: `01_SPEC 3.5`).**

```lua
-- ============================================
-- OVHL RBLX Framework v2.1.0
-- Founder: Hanif Saifudin
-- Module: [ModuleName] Configuration (Defaults)
-- ============================================

return {
    -- === 1. PENGATURAN MODUL ===
    enabled = true,
    debugMode = false,

    -- === 2. KONFIGURASI GAMEPLAY ===
    gameplay = {
        maxInventorySize = 50,
        defaultCurrency = "gold",
        transactionTimeout = 30, -- detik
    },

    -- === 3. KESEIMBANGAN EKONOMI ===
    economy = {
        itemPrices = {
            sword = 100,
            potion = 50,
            shield = 150
        },
        sellMultiplier = 0.7, -- 70% harga beli
    },

    -- === 4. KONFIGURASI UI (jika modul Client/Shared) ===
    ui = {
        showItemIcons = true,
        confirmPurchases = true,
        animationDuration = 0.5,
    },

    -- === 5. ATURAN VALIDASI ===
    validation = {
        minItemPrice = 1,
        maxItemPrice = 10000,
        allowedItemTypes = {"weapon", "armor", "consumable"}
    }
}
```

---

## 📏 3.0 STANDAR DEVELOPMENT

### 3.1 🏷️ Konvensi Penamaan (Strict Enforcement)

(🇮🇩) Sesuai `01_SPEC 4.0`. Wajib dipatuhi AI (Ref: `00_CONST`).
(🇬🇧) **Per `01_SPEC 4.0`. AI must enforce (Ref: `00_CONST`).**

#### 3.1.1 Penamaan File

```lua
-- ✅ BENAR
"ShopSystemHandler.lua"    -- PascalCase untuk Handler/Class
"[ModuleName]Config.lua"   -- PascalCase untuk Config
"ShopUtils.lua"            -- PascalCase untuk Utils
"manifest.lua"             -- lowercase untuk file manifest
"README_[ModuleName].md"   -- UPPERCASE untuk README

-- ❌ SALAH
"shop_handler.lua"         -- (snake_case untuk handler)
"ShopConfig.lua"           -- (Salah, harusnya [NamaModul]Config.lua)
"utils.lua"                -- (Nama terlalu generik)
```

#### 3.1.2 Penamaan Variabel & Fungsi (Sesuai `01_SPEC 4.1`)

```lua
-- ✅ BENAR
local playerHealth = 100               -- camelCase (variabel lokal)
local MAX_INVENTORY_SIZE = 50          -- UPPER_SNAKE_CASE (konstanta modul)

function Module:calculateTotalPrice() end -- camelCase (metode publik)
function Module:_privateHelper() end    -- _camelCase (metode private)

-- ❌ SALAH
local player_health = 100              -- (snake_case untuk variabel)
local maxInventorySize = 50            -- (camelCase untuk konstanta)
```

### 3.2 ✨ Pola Kode & Praktik Terbaik

#### 3.2.1 📡 Komunikasi Berbasis Event (Event-Driven)

(🇮🇩) DILARANG `require()` modul lain secara langsung. Gunakan `EventService`.
(🇬🇧) **DO NOT `require()` other modules directly. Use `EventService`.**

```lua
-- ✅ BENAR: Gunakan events
function ShopHandler:playerBuyItem(player, itemId)
    -- ... (logika validasi) ...
    if success then
        -- Siarkan event untuk didengar modul lain (misal: InventorySystem)
        self.EventService:Publish("item_purchased", {
            player = player,
            itemId = itemId,
            price = itemPrice,
        })
    end
end

-- ❌ SALAH: Panggilan langsung (Direct call)
function ShopHandler:playerBuyItem(player, itemId)
    -- JANGAN LAKUKAN INI! (Coupling ketat & rawan error jika InventorySystem belum load)
    local InventoryHandler = _context.InventorySystem -- Mengambil dari context (LEBIH BAIK, tapi tetap direct call)
    if InventoryHandler then
        InventoryHandler:AddItem(player, itemId) -- Masih direct call
    end
end
```

#### 3.2.2 🔧 Perilaku Berbasis Konfigurasi (Config-Driven)

(🇮🇩) DILARANG _hardcode_ nilai. Gunakan file `Config`.
(🇬🇧) **DO NOT hardcode values. Use the `Config` file.**

```lua
-- ✅ BENAR: Gunakan config
function ShopHandler:getItemPrice(itemId)
    -- Ambil dari _moduleConfig yang di-load saat init
    local price = _moduleConfig.economy.itemPrices[itemId]

    if not price then
        warn("Harga tidak ada di config untuk:", itemId)
        return _moduleConfig.economy.defaultPrice or 10
    end
    return price
end

-- ❌ SALAH: Hardcoded
function ShopHandler:getItemPrice(itemId)
    -- JANGAN LAKUKAN INI! (Susah di-balance & diubah)
    if itemId == "sword" then return 100 end
    if itemId == "potion" then return 50 end
end
```

#### 3.2.3 🛡️ Penanganan Error & Validasi (Anti-Crash Level 3)

(🇮🇩) Semua fungsi publik WAJIB divalidasi dan dibungkus `pcall` jika berisiko.
(🇬🇧) **All public functions MUST have validation and be wrapped in `pcall` if risky.**

```lua
-- ✅ BENAR: Penanganan error komprehensif
function ShopHandler:processTransaction(player, itemId, quantity)
    -- 1. Validasi Input Awal
    if not player or not itemId or not quantity or quantity <= 0 then
        warn("[ShopHandler] Input tidak valid untuk processTransaction")
        return false, "Input tidak valid"
    end

    -- 2. Validasi Gameplay (contoh)
    if not self:_isValidPlayer(player) then
        error("[ShopHandler] Player tidak valid di processTransaction") -- Error jika fatal
    end
    if not self:_isValidItem(itemId) then
        warn("[ShopHandler] Attempted to purchase invalid item:", itemId)
        return false, "Item tidak valid" -- Return false jika tidak fatal
    end

    -- 3. Eksekusi Aman (Anti-Crash) untuk operasi berisiko (misal: interaksi DataService)
    local success, result = pcall(function()
        -- Misal: Mengurangi uang player, menambah item
        return self:_executeTransaction(player, itemId, quantity)
    end)

    if not success then
        -- Laporkan error tapi JANGAN crash
        warn("[ShopHandler] Gagal eksekusi transaksi:", result) -- Log error detail
        self.EventService:Publish("transaction_failed", {
            player = player,
            itemId = itemId,
            error = "Terjadi kesalahan internal" -- Pesan error aman untuk client
        })
        return false, "Terjadi kesalahan internal"
    end

    return true, result
end
```

---

## 🔄 4.0 MANAJEMEN SIKLUS HIDUP (LIFECYCLE)

### 4.1 📊 Urutan Loading (Loading Sequence)

```
1. 🕐 BOOTSTRAP DISCOVERY (Ref: 01_SPEC 3.1)
    ├── Scan folder `Source/Modules/`
    ├── Baca `manifest.lua`
    ├── Validasi dependensi (Ref: 2.2.1)
    └── Sortir berdasarkan `loadOrder` (Ref: 2.2.1)

2. 🚀 INITIALIZATION PHASE (init())
    ├── Buat instance modul
    ├── Suntik dependensi (Core Services, ConfigPath, Modul lain yang sudah init) ke `context`
    └── Panggil `module:init(context)`

3. 🎯 STARTUP PHASE (start())
    ├── Panggil `module:start()` (hanya untuk `autoInit = true`)
    └── Siarkan event "[ModuleName]_ready"

4. ⚙️ RUNTIME PHASE
    ├── Tangani event global & modul
    └── Proses background tasks

5. 🛑 SHUTDOWN PHASE (stop())
    ├── Panggil `module:stop()`
    ├── Cleanup resources (unsubscribe events, hentikan loops)
    └── Simpan state (jika perlu, via DataService)
```

### 4.2 🔥 Kompatibilitas Hot-Reload (Ref: `01_SPEC 3.2`)

(🇮🇩) Modul WAJIB didesain untuk mendukung hot-reload dengan state preservation.
(🇬🇧) **Modules MUST be designed to support hot-reloading with state preservation.**

```lua
-- Akan dipanggil oleh HotReloadEngine (OS) saat update terdeteksi
function ShopHandler:hotReload(newHandlerCode)
    print("[ShopHandler] Memulai proses Hot-Reload...")
    -- 1. Backup state krusial saat ini
    local currentState = self:_exportState()

    -- 2. Hentikan operasi saat ini (cleanup)
    self:stop()

    -- 3. OS akan menimpa kode 'self' dengan 'newHandlerCode' (magic!)
    -- Anggap saja setelah ini, 'self' adalah instance baru dengan state lama kosong

    -- 4. Restore state krusial ke instance baru
    self:_importState(currentState)

    -- 5. Jalankan kembali init() dan start() dengan context yang sama
    self:init(_context) -- Gunakan context yang disimpan
    if _moduleConfig.autoInit then -- Cek dari config baru
       self:start()
    end

    print("[ShopHandler] Hot-Reload selesai!")
end

-- Wajib ada jika modul punya state yang perlu diselamatkan
function ShopHandler:_exportState()
    print("[ShopHandler] Mengekspor state...")
    return {
        -- Simpan hanya data yang TIDAK bisa direkonstruksi dari DataService
        internalState = self._internalState
        -- Jangan simpan _context, _moduleConfig (akan di-load ulang)
    }
end

-- Wajib ada jika _exportState ada
function ShopHandler:_importState(savedState)
    print("[ShopHandler] Mengimpor state...")
    if savedState and savedState.internalState then
        self._internalState = savedState.internalState
        print("[ShopHandler] State internal berhasil direstore.")
    else
        warn("[ShopHandler] Gagal mengimpor state atau state kosong.")
        -- Inisialisasi state default jika perlu
        self:_initializeSystems()
    end
end
```

---

## 🔬 5.0 PENGUJIAN & JAMINAN KUALITAS (QA)

### 5.1 🧪 Template Tes (WAJIB)

(🇮🇩) Setiap modul wajib punya file `[ModuleName]Tests.lua`.
(🇬🇧) **Each module must have a `[ModuleName]Tests.lua` file.**

```lua
-- Source/Modules/[ModuleType]/[ModuleName]/[ModuleName]Tests.lua

-- Lakukan OS Check juga di file Test!
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CORE_OS_PATH = ReplicatedStorage:WaitForChild("OVHL_Core", 5)
if not CORE_OS_PATH then
    warn("!! [TESTS] GAGAL LOAD CORE OS untuk Tes [ModuleName]")
    return nil
end

local [ModuleName]Tests = {}
-- Framework test runner (contoh, perlu dibuat)
local TestRunner = require(CORE_OS_PATH.Parent.Tools.Node.utils.TestRunner) -- Contoh path

-- Handler yang akan di-test
local Handler = require(script.Parent:FindFirstChild("[ModuleName]Handler"))

-- Mock Dependencies (PENTING!)
local MockDataService = {
    GetModuleConfig = function(moduleName) return {} end, -- Return config kosong/mock
    GetPlayerData = function(player) return { cash = 1000 } end,
    SavePlayerData = function(player, data) end
}
local MockEventService = {
    _listeners = {},
    Subscribe = function(self, eventName, callback)
        if not self._listeners[eventName] then self._listeners[eventName] = {} end
        table.insert(self._listeners[eventName], callback)
    end,
    Publish = function(self, eventName, ...)
        if self._listeners[eventName] then
            for _, callback in ipairs(self._listeners[eventName]) do
                task.spawn(callback, ...) -- Spawn agar tidak block
            end
        end
    end,
    UnsubscribeAll = function() end -- Mock
}

-- Setup context untuk init()
local mockContext = {
    DataService = MockDataService,
    EventService = MockEventService,
    ConfigPath = script.Parent:FindFirstChild("[ModuleName]Config") -- Path ke file config default
}

TestRunner:Describe("[ModuleName] Tests", function()

    local handlerInstance

    TestRunner:BeforeEach(function()
        -- Buat instance baru untuk setiap test case
        handlerInstance = setmetatable({}, Handler)
        -- Reset mock state jika perlu
        MockEventService._listeners = {}
    end)

    TestRunner:It("should initialize without errors", function()
        local success, err = pcall(handlerInstance.init, handlerInstance, mockContext)
        TestRunner:Expect(success).ToBe(true)
        -- TestRunner:Expect(handlerInstance._isInitialized).ToBe(true) -- Cek state internal
    end)

    TestRunner:It("should handle player joined event", function()
        handlerInstance:init(mockContext)
        local mockPlayer = { Name = "Tester", UserId = 123 }

        -- Buat Spy untuk mengecek apakah event dipublish
        local published = false
        MockEventService:Subscribe("[module_name]_player_ready", function(data)
            published = true
            TestRunner:Expect(data.player).ToBe(mockPlayer)
        end)

        -- Trigger event internal
        handlerInstance:_onPlayerJoined(mockPlayer)

        -- Tunggu sebentar karena publish pakai task.spawn
        task.wait(0.1)

        TestRunner:Expect(published).ToBe(true)
        -- Cek state internal jika perlu
        -- TestRunner:Expect(handlerInstance._internalState.activePlayers[123]).ToBe(mockPlayer)
    end)

    -- Tambahkan test case lain untuk business logic, error handling, dll.
    TestRunner:It("should process transaction correctly (example)", function()
        handlerInstance:init(mockContext)
        local mockPlayer = { Name = "Tester", UserId = 123 }

        -- Asumsikan ada _executeTransaction, _isValidPlayer, _isValidItem
        -- Mock fungsi private ini jika perlu untuk isolasi

        -- local success, result = handlerInstance:processTransaction(mockPlayer, "sword", 1)
        -- TestRunner:Expect(success).ToBe(true)
    end)

end)

return [ModuleName]Tests -- atau biarkan TestRunner yang jalan
```

### 5.2 🚦 Gerbang Kualitas (Quality Gates)

```lua
OVHL.QualityGates = {
    CodeCoverage = "Minimal 80% test coverage (Target Awal)",
    Performance = "Tidak ada operasi > 16ms per frame (diukur di runtime)",
    MemoryUsage = "Tidak ada memory leak dalam 30 menit stress test",
    ErrorHandling = "Semua metode publik WAJIB punya validasi & penanganan error (Ref: 3.2.3)",
    Documentation = "README.md WAJIB diisi (minimal purpose & cara pakai dasar)"
}
```

---

## 🤝 6.0 POLA INTEGRASI

### 6.1 Manajemen Dependensi

```lua
-- ✅ BENAR: Deklarasi di manifest (Ref: 2.2.1)
-- manifest.lua
depends = {"DataService", "InventorySystem", "EconomyService"}
-- (OS akan menyuntikkan instance service/modul ini ke dalam 'context' saat init)

-- ❌ SALAH: Hard require (Ref: 3.2.1)
-- JANGAN lakukan ini di dalam Handler!
local InventorySystem = require(game.ReplicatedStorage.OVHL_Modules.Server.InventorySystem...) -- (Menciptakan coupling ketat & rawan path salah)
```

### 6.2 Integrasi Berbasis Event

(🇮🇩) Cara standar komunikasi antar modul yang paling aman dan _decoupled_.
(🇬🇧) **The safest and most decoupled way for modules to communicate.**

```lua
-- Module A (Publisher)
function QuestSystem:completeQuest(player, questId)
    -- ... (Logika selesai quest) ...

    -- Siarkan event GLOBAL untuk didengar modul lain
    self.EventService:Publish("quest_completed", {
        player = player,
        questId = questId,
        reward = questReward
    })
    print("[QuestSystem] Event quest_completed published.")
end

-- Module B (Subscriber)
function AchievementSystem:init(context)
    self.EventService = context.EventService

    -- Berlangganan ke event GLOBAL
    self.EventService:Subscribe("quest_completed", function(data)
        -- Pastikan modul ini sudah siap
        if not self._isInitialized then return end
        print("[AchievementSystem] Event quest_completed received.")
        self:_checkQuestAchievements(data.player, data.questId)
    end)
end
```

---

## 🎓 7.0 POLA DESAIN LANJUTAN

### 7.1 Pola Pabrik (Factory Pattern)

(🇮🇩) Untuk membuat instance objek yang kompleks atau bervariasi secara dinamis.
(🇬🇧) **For creating complex or varied object instances dynamically.**

```lua
-- Contoh: Source/Shared/Utils/VehicleFactory.lua
local VehicleFactory = {}
VehicleFactory._vehicleClasses = {} -- Registry

function VehicleFactory:createVehicle(vehicleType, config)
    local VehicleClass = self._vehicleClasses[vehicleType]
    if not VehicleClass then
        warn("VehicleFactory: Tipe kendaraan tidak dikenal:", vehicleType)
        return nil
    end
    -- Asumsi setiap kelas kendaraan punya metode .new()
    return VehicleClass.new(config)
end

function VehicleFactory:registerVehicleType(vehicleType, vehicleClass)
    print("VehicleFactory: Mendaftarkan tipe:", vehicleType)
    self._vehicleClasses[vehicleType] = vehicleClass
end

return VehicleFactory
```

### 7.2 Pencari Layanan (Service Locator)

(🇮🇩) Alternatif untuk Dependency Injection (DI) jika _context_ tidak cukup atau untuk akses service dari tempat lain (gunakan dengan hati-hati!).
(🇬🇧) **An alternative to DI if context isn't sufficient or for accessing services elsewhere (use cautiously!).**

```lua
-- Contoh: Source/Core/Kernel/ServiceLocator.lua (DIKELOLA OS)
local ServiceLocator = {}
local services = {}

function ServiceLocator:RegisterService(name, instance)
    services[name] = instance
end

function ServiceLocator:GetService(name, isOptional)
    local service = services[name]
    if not service and not isOptional then
        error("ServiceLocator: Service '" .. name .. "' tidak ditemukan!")
    end
    return service
end

return ServiceLocator

-- Penggunaan di Modul (JIKA TERPAKSA):
-- local DataService = ServiceLocator:GetService("DataService")
```

---

## ❤️‍🩹 8.0 PEMANTAUAN KESEHATAN MODUL

### 8.1 Template Pengecekan Kesehatan (Health Check)

(🇮🇩) Fungsi opsional yang bisa dipanggil oleh `SystemMonitor` (OS) untuk diagnostik.
(🇬🇧) **Optional function callable by `SystemMonitor` (OS) for diagnostics.**

```lua
function ModuleHandler:healthCheck()
    -- Kembalikan status internal modul
    local status = "healthy"
    local issues = {}
    if not self._isInitialized then status = "uninitialized" end
    if #self._internalState.activePlayers > 1000 then -- Contoh cek beban
        status = "warning"
        table.insert(issues, "High player count")
    end

    return {
        module = _moduleConfig.name or "[ModuleName]", -- Ambil dari config
        status = status,
        active_players = #self._internalState.activePlayers,
        issues = issues
        -- Tambahkan metrik lain jika perlu
    }
end
```

---

## ⚡ 9.0 TEMPLATE QUICK-START

### 9.1 Server Module (5 Menit Setup)

```lua
-- Source/Modules/Server/QuickShop/manifest.lua
return {
    name = "QuickShop",
    depends = {"DataService", "EventService"},
    loadOrder = 50,
    autoInit = true,
    entry = "QuickShopHandler"
}

-- Source/Modules/Server/QuickShop/QuickShopHandler.lua
local CORE_OS_PATH = game:GetService("ReplicatedStorage"):WaitForChild("OVHL_Core", 5)
if not CORE_OS_PATH then return nil end

local QuickShopHandler = {}
function QuickShopHandler:init(context)
    self.DataService = context.DataService
    self.EventService = context.EventService
    print("🛒 QuickShop [Anti-Crash OK] siap!")
end
function QuickShopHandler:start() end
function QuickShopHandler:stop() end
return QuickShopHandler

-- Jangan lupa file Config, Tests, README kosong
```

### 9.2 Client Module (5 Menit Setup)

```lua
-- Source/Modules/Client/SimpleHUD/manifest.lua
return {
    name = "SimpleHUD",
    autoInit = true,
    loadOrder = 10,
    entry = "SimpleHUD"
}

-- Source/Modules/Client/SimpleHUD/SimpleHUD.lua
local CORE_OS_PATH = game:GetService("ReplicatedStorage"):WaitForChild("OVHL_Core", 5)
if not CORE_OS_PATH then return nil end

local SimpleHUD = {}
function SimpleHUD:init(context)
    -- Asumsi UIManager adalah Core Service Client yang di-inject
    self.UIManager = context.UIManager
    print("📱 SimpleHUD [Anti-Crash OK] aktif!")
end
function SimpleHUD:start() end
function SimpleHUD:stop() end
return SimpleHUD

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

> **"Arsitektur modul yang solid adalah fondasi ekosistem OVHL. Dengan standar yang jelas, kita memungkinkan kolaborasi masif tanpa kekacauan."** > _- Hanif Saifudin_

> **"Standardization enables innovation at scale."** > _- Prinsip Arsitektur Modul OVHL_

---

> "Simplicity is the ultimate sophistication." – Leonardo da Vinci

---

**END OF DOCUMENT**

## _Copyright © 2025 - Omniverse Highland Studio_
