# 🧩 03_OVHL_MODULE_ARCHITECTURE.md - Module Development Bible

> **Project:** Omniverse Highland - Multi-Game Engine  
> **Document:** Module Architecture & Development Standards  
> **Version:** 1.0.0  
> **Founder:** Hanif Saifudin  
> **Created:** 2024-12-19 20:15:00  
> **Status:** DRAFT (Will be refined after prototype testing)  

---

## 🎯 MODULE PHILOSOPHY & DESIGN PRINCIPLES

### 🧠 Core Module Mindset
```lua
-- "Setiap modul adalah kota mandiri dalam negara OVHL"
OVHL_MODULE_PRINCIPLES = {
    "SINGLE_RESPONSIBILITY",  -- Satu modul, satu tanggung jawab
    "PLUG_AND_PLAY",          -- Bisa ditambah/hapus tanpa efek samping
    "CONFIG_DRIVEN",          -- Behavior dikontrol via config, bukan code
    "EVENT_BASED",            -- Komunikasi via events, bukan direct calls
    "AUTO_DISCOVERABLE",      -- System otomatis detect tanpa registration manual
    "HOT_RELOAD_READY",       -- Support live updates tanpa restart
}
```

### 🏗️ Module Architecture Types
| Type | Purpose | Location | Example |
|------|---------|----------|---------|
| **Server Module** | Game logic, data processing | `MODULES/Server/` | `ShopSystem`, `QuestManager` |
| **Client Module** | UI, controls, visual effects | `MODULES/Client/` | `MainHUD`, `VehicleController` |
| **Shared Module** | Cross-platform utilities | `MODULES/Shared/` | `MathUtils`, `GameConstants` |

---

## 📁 MODULE STRUCTURE STANDARDS

### 🎯 STANDARD MODULE TEMPLATE
```
MODULES/
└── 🎯 [ModuleType]/
    └── 🧩 [ModuleName]/
        ├── 📄 manifest.lua             -- REQUIRED: Module metadata
        ├── ⚙️ [ModuleName]Handler.lua    -- Main logic handler
        ├── 🎨 [ModuleName]Config.lua    -- Configuration values
        ├── 🧪 [ModuleName]Tests.lua     -- Automated tests
        ├── 📖 README_[ModuleName].md    -- Documentation
        └── 🎯 [ModuleName]Utils.lua     -- Helper functions (optional)
```

### 📋 FILE CONTENT TEMPLATES

#### 🎯 manifest.lua (REQUIRED)
```lua
-- ============================================
-- OVHL RBLX Framework v1.0.0
-- Studio: Omniverse Highland Studio
-- Founder: Hanif Saifudin
-- Created: 2024-12-19 20:15:00
-- Modified: 2024-12-19 20:15:00
-- Version: 1.0.0
-- Module: [ModuleName]
-- Purpose: [Brief description of module purpose]
-- ============================================

return {
    -- === IDENTITY ===
    name = "[ModuleName]",                -- PascalCase, e.g., "ShopSystem"
    version = "1.0.0",                    -- Semantic versioning
    description = "[Detailed module description]",
    
    -- === DEPENDENCIES ===
    depends = {                           -- Other modules this module needs
        "DataService",                    -- Core services
        "EventService",
        -- "OtherModule"                  -- Other gameplay modules
    },
    
    -- === LOADING CONFIG ===
    loadOrder = 10,                       -- Lower = loaded first (1-100)
    autoInit = true,                      -- true = auto start, false = manual
    
    -- === ENTRY POINT ===
    entry = "Handler",                    -- Main handler file (without .lua)
    
    -- === EVENT CONTRACT ===
    subscribesTo = {                      -- Events this module LISTENS to
        "player_joined",
        "player_data_loaded",
        -- "other_module_event"
    },
    
    publishes = {                         -- Events this module EMITS
        "shop_item_purchased",
        "inventory_updated",
        -- "module_specific_event"
    },
    
    -- === CONFIGURATION ===
    configSchema = {                      -- Expected configuration structure
        enabled = "boolean",
        maxItems = "number",
        currencyType = "string"
    }
}
```

#### ⚙️ Handler Template (Server/Client)
```lua
-- ============================================
-- OVHL RBLX Framework v1.0.0
-- Studio: Omniverse Highland Studio
-- Founder: Hanif Saifudin
-- Created: 2024-12-19 20:15:00
-- Modified: 2024-12-19 20:15:00
-- Version: 1.0.0
-- Module: [ModuleName] Handler
-- Purpose: Main logic handler for [ModuleName]
-- ============================================

local [ModuleName]Handler = {}
[ModuleName]Handler.__index = [ModuleName]Handler

-- Private variables (use snake_case for private)
local _isInitialized = false
local _moduleConfig = nil

-- === PUBLIC METHODS ===

function [ModuleName]Handler:init(context)
    if _isInitialized then
        warn("[ModuleName] already initialized!")
        return
    end
    
    -- Store dependencies
    self.DataService = context.DataService
    self.EventService = context.EventService
    
    -- Load configuration
    _moduleConfig = self:_loadConfiguration()
    
    -- Initialize module systems
    self:_setupEventListeners()
    self:_initializeSystems()
    
    _isInitialized = true
    print("[ModuleName] successfully initialized!")
end

function [ModuleName]Handler:start()
    if not _isInitialized then
        error("[ModuleName] must be initialized before start!")
    end
    
    -- Start active systems
    self:_startBackgroundProcesses()
    
    print("[ModuleName] is now running!")
end

function [ModuleName]Handler:stop()
    -- Cleanup resources
    self:_cleanupEventListeners()
    self:_stopBackgroundProcesses()
    
    _isInitialized = false
    print("[ModuleName] has been stopped.")
end

-- === PRIVATE METHODS (use underscore prefix) ===

function [ModuleName]Handler:_loadConfiguration()
    -- Load from DataService or fallback to defaults
    local config = self.DataService:GetModuleConfig("[ModuleName]") or {}
    
    -- Apply defaults for missing values
    return {
        enabled = config.enabled or true,
        maxItems = config.maxItems or 100,
        currencyType = config.currencyType or "gold"
    }
end

function [ModuleName]Handler:_setupEventListeners()
    -- Subscribe to required events
    self.EventService:Subscribe("player_joined", function(player)
        self:_onPlayerJoined(player)
    end)
    
    self.EventService:Subscribe("player_data_loaded", function(playerData)
        self:_onPlayerDataLoaded(playerData)
    end)
end

function [ModuleName]Handler:_initializeSystems()
    -- Initialize any internal systems
    self._internalState = {
        activePlayers = {},
        systemReady = true
    }
end

function [ModuleName]Handler:_onPlayerJoined(player)
    -- Handle new player joining
    print("Player joined:", player.Name)
    
    -- Emit module-specific event
    self.EventService:Publish("shop_player_ready", {
        player = player,
        timestamp = os.time()
    })
end

return [ModuleName]Handler
```

#### 🎨 Config Template
```lua
-- ============================================
-- OVHL RBLX Framework v1.0.0
-- Studio: Omniverse Highland Studio
-- Founder: Hanif Saifudin
-- Created: 2024-12-19 20:15:00
-- Modified: 2024-12-19 20:15:00
-- Version: 1.0.0
-- Module: [ModuleName] Configuration
-- ============================================

return {
    -- === MODULE SETTINGS ===
    enabled = true,
    debugMode = false,
    
    -- === GAMEPLAY CONFIG ===
    gameplay = {
        maxInventorySize = 50,
        defaultCurrency = "gold",
        transactionTimeout = 30, -- seconds
    },
    
    -- === ECONOMY BALANCE ===
    economy = {
        itemPrices = {
            sword = 100,
            potion = 50,
            armor = 200
        },
        sellMultiplier = 0.7, -- 70% of purchase price
    },
    
    -- === UI CONFIG ===
    ui = {
        showItemIcons = true,
        confirmPurchases = true,
        animationDuration = 0.5, -- seconds
    },
    
    -- === VALIDATION RULES ===
    validation = {
        minItemPrice = 1,
        maxItemPrice = 10000,
        allowedItemTypes = {"weapon", "armor", "consumable"}
    }
}
```

---

## 🎯 MODULE DEVELOPMENT STANDARDS

### 📛 NAMING CONVENTIONS (STRICT ENFORCEMENT)

#### 🎯 File Naming
```lua
-- ✅ CORRECT
"ShopSystemHandler.lua"     -- PascalCase for handlers
"shop_config.lua"         -- snake_case for config files
"ShopUtils.lua"             -- PascalCase for utility files

-- ❌ INCORRECT
"shop_handler.lua"          -- snake_case for class files
"ShopConfig.lua"            -- PascalCase for config files
"utils.lua"                 -- Generic names not allowed
```

#### 🎯 Variable & Function Naming
```lua
-- ✅ CORRECT
local playerHealth = 100                -- camelCase variables
local MAX_INVENTORY_SIZE = 50           -- UPPER_SNAKE_CASE constants

function calculateTotalPrice() end        -- camelCase functions
function PlayerController:onDamageTaken() end -- camelCase methods

-- ❌ INCORRECT
local player_health = 100               -- snake_case variables
local maxInventorySize = 50             -- camelCase constants
function Calculate_Total_Price() end      -- Mixed case functions
```

### 🏗️ CODE PATTERNS & BEST PRACTICES

#### 🎯 Event-Driven Communication
```lua
-- ✅ CORRECT: Use events for inter-module communication
function ShopHandler:playerBuyItem(player, itemId)
    -- Validate purchase
    local success = self:_validatePurchase(player, itemId)
    
    if success then
        -- Emit event for other modules
        self.EventService:Publish("item_purchased", {
            player = player,
            itemId = itemId,
            price = itemPrice,
            timestamp = os.time()
        })
    end
end

-- ❌ INCORRECT: Direct module calls
function ShopHandler:playerBuyItem(player, itemId)
    -- DON'T do this!
    local inventory = require("InventorySystem") -- Direct dependency
    inventory:addItem(player, itemId)            -- Direct call
end
```

#### 🎯 Configuration-Driven Behavior
```lua
-- ✅ CORRECT: Use config for tunable values
function ShopHandler:getItemPrice(itemId)
    local price = self.config.economy.itemPrices[itemId]
    
    if not price then
        warn("No price configured for item:", itemId)
        return self.config.economy.defaultPrice or 10
    end
    
    return price
end

-- ❌ INCORRECT: Hardcoded values
function ShopHandler:getItemPrice(itemId)
    -- DON'T do this!
    if itemId == "sword" then return 100 end   -- Hardcoded!
    if itemId == "potion" then return 50 end   -- Hardcoded!
end
```

#### 🎯 Error Handling & Validation
```lua
-- ✅ CORRECT: Comprehensive error handling
function ShopHandler:processTransaction(player, itemId, quantity)
    -- Input validation
    if not self:_isValidPlayer(player) then
        error("Invalid player provided to processTransaction")
    end
    
    if not self:_isValidItem(itemId) then
        warn("Attempted to purchase invalid item:", itemId)
        return false, "Invalid item"
    end
    
    -- Safe execution with pcall
    local success, result = pcall(function()
        return self:_executeTransaction(player, itemId, quantity)
    end)
    
    if not success then
        self.EventService:Publish("transaction_failed", {
            player = player,
            itemId = itemId,
            error = result
        })
        return false, result
    end
    
    return true, result
end
```

---

## 🔄 MODULE LIFECYCLE MANAGEMENT

### 🎯 LOADING SEQUENCE
```
1. 🕐 BOOTSTRAP DISCOVERY
    ├── Scan MODULES/ folder
    ├── Read manifest.lua files
    ├── Validate dependencies
    └── Sort by loadOrder

2. 🚀 INITIALIZATION PHASE
    ├── Create module instances
    ├── Inject dependencies (context/DI)
    ├── Call init() methods
    └── Validate initialization

3. 🎯 STARTUP PHASE
    ├── Call start() on autoInit modules
    ├── Start background processes
    └── Emit "module_ready" events

4. 🔄 RUNTIME PHASE
    ├── Handle events and requests
    ├── Process background tasks
    └── Monitor module health

5. 🛑 SHUTDOWN PHASE
    ├── Call stop() methods
    ├── Cleanup resources
    └── Persist module state
```

### 🎯 HOT-RELOAD COMPATIBILITY
```lua
-- Modules MUST support hot-reload
function ShopHandler:hotReload(newHandler)
    -- 1. Backup current state
    local currentState = self:_exportState()
    
    -- 2. Stop current operations
    self:stop()
    
    -- 3. Update with new code
    self = newHandler
    
    -- 4. Restore state and restart
    self:_importState(currentState)
    self:start()
    
    print("[ShopHandler] Hot-reload completed successfully!")
end
```

---

## 🧪 TESTING & QUALITY ASSURANCE

### 🎯 TEST TEMPLATE
```lua
-- [ModuleName]Tests.lua
local [ModuleName]Tests = {}

function [ModuleName]Tests:runAllTests()
    print("🧪 Running [ModuleName] Tests...")
    
    self:testInitialization()
    self:testBusinessLogic()
    self:testErrorConditions()
    self:testPerformance()
    
    print("✅ All tests passed!")
end

function [ModuleName]Tests:testInitialization()
    -- Test module initialization
    local handler = require("[ModuleName]Handler")
    local mockContext = {
        DataService = MockDataService,
        EventService = MockEventService
    }
    
    handler:init(mockContext)
    assert(handler._isInitialized, "Module should be initialized")
end

function [ModuleName]Tests:testBusinessLogic()
    -- Test core business logic
    local result = handler:calculatePrice("sword", 2)
    assert(result == 200, "Price calculation should be correct")
end

return [ModuleName]Tests
```

### 🎯 QUALITY GATES
```lua
OVHL.QualityGates = {
    CodeCoverage = "Minimum 90% test coverage",
    Performance = "No operations > 16ms per frame",
    MemoryUsage = "No memory leaks in 1-hour stress test",
    ErrorHandling = "All public methods must have error handling",
    Documentation = "100% of public APIs documented"
}
```

---

## 🔗 MODULE INTEGRATION PATTERNS

### 🎯 DEPENDENCY MANAGEMENT
```lua
-- ✅ CORRECT: Declare dependencies in manifest
-- manifest.lua
depends = {"DataService", "InventorySystem", "EconomyService"}

-- ❌ INCORRECT: Hard require other modules
-- DON'T do this in your handler!
local InventorySystem = require("InventorySystem")  -- Creates tight coupling
```

### 🎯 EVENT-BASED INTEGRATION
```lua
-- Module A (Publisher)
function QuestSystem:completeQuest(player, questId)
    -- Process completion logic...
    
    -- Emit event for other modules
    self.EventService:Publish("quest_completed", {
        player = player,
        questId = questId,
        reward = questReward
    })
end

-- Module B (Subscriber)
function AchievementSystem:init(context)
    self.EventService = context.EventService
    
    self.EventService:Subscribe("quest_completed", function(data)
        self:checkQuestAchievements(data.player, data.questId)
    end)
end
```

---

## 🚀 ADVANCED MODULE PATTERNS

### 🎯 FACTORY PATTERN FOR FLEXIBLE INSTANCES
```lua
local VehicleFactory = {}

function VehicleFactory:createVehicle(vehicleType, config)
    local vehicleClass = self._vehicleClasses[vehicleType]
    
    if not vehicleClass then
        error("Unknown vehicle type: " .. tostring(vehicleType))
    end
    
    return vehicleClass.new(config)
end

function VehicleFactory:registerVehicleType(vehicleType, vehicleClass)
    self._vehicleClasses[vehicleType] = vehicleClass
end

return VehicleFactory
```

### 🎯 SERVICE LOCATOR FOR DEPENDENCY INJECTION
```lua
function ModuleHandler:init(serviceLocator)
    -- Safe dependency access with fallbacks
    self.DataService = serviceLocator:getService("DataService")
    self.EventService = serviceLocator:getService("EventService")
    
    -- Optional dependencies
    self.AnalyticsService = serviceLocator:getService("AnalyticsService", true)
end
```

---

## 📊 MODULE HEALTH MONITORING

### 🎯 HEALTH CHECK TEMPLATE
```lua
function ModuleHandler:healthCheck()
    return {
        module = self.config.name,
        status = self._isInitialized and "healthy" or "initializing",
        performance = {
            lastOperationTime = self._lastOpTime,
            memoryUsage = self._memoryUsage,
            activeConnections = #self._activeConnections
        },
        errors = {
            recentErrors = self._errorCount,
            lastError = self._lastError,
            errorRate = self._errorRate
        }
    }
end
```

---

## 🎯 QUICK START TEMPLATES

### 🚀 SERVER MODULE - 5 MINUTE SETUP
```lua
-- manifest.lua
return {
    name = "QuickShop",
    depends = {"DataService", "EventService"},
    loadOrder = 50,
    autoInit = true,
    entry = "QuickShopHandler"
}

-- QuickShopHandler.lua
local QuickShopHandler = {}

function QuickShopHandler:init(context)
    self.DataService = context.DataService
    self.EventService = context.EventService
    print("🛒 QuickShop ready!")
end

return QuickShopHandler
```

### 🎮 CLIENT MODULE - 5 MINUTE SETUP
```lua
-- ClientManifest.lua
return {
    name = "SimpleHUD",
    autoInit = true,
    loadOrder = 10,
    entry = "SimpleHUD"
}

-- SimpleHUD.lua
local SimpleHUD = {}

function SimpleHUD:Init(DI)
    self.UIManager = DI.UIManager
    print("📱 SimpleHUD activated!")
end

return SimpleHUD
```

---

## 🔮 FUTURE ENHANCEMENTS (POST-PROTOTYPE)

### 🎯 PLANNED FEATURES
```lua
OVHL.FutureModuleFeatures = {
    "MODULE_MARKETPLACE",     -- Share/reuse modules
    "AUTO_SCALING",           -- Dynamic resource management
    "MACHINE_LEARNING",       -- Predictive module optimization
    "CROSS_GAME_MODULES",     -- Modules that work across different games
    "VISUAL_MODULE_BUILDER"   -- Drag-and-drop module creation
}
```

---

**🎯 CLOSING STATEMENT:** "Module architecture yang solid adalah pondasi ecosystem OVHL.  
Dengan standar yang jelas, kita enable kolaborasi massive tanpa chaos."

> **"Standardization enables innovation at scale"** > *- OVHL Module Architecture Principle*

---
**END OF 03_OVHL_MODULE_ARCHITECTURE.md**