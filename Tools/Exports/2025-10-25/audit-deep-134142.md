---
tool: 'ovhl-tools (audit-deep)'
generated_at: '2025-10-25 13:41:42'
mode: 'deep'
base: 'src'
totalFiles: '16'
totalSize: '33.29 KB'
---

# Laporan Audit: DEEP

## 📊 Ringkasan Proyek
- Total File: 16
- Total Ukuran: 33.29 KB

## 📝 File Berdasarkan Tipe
- **.lua**: 16 file


## 🌊 Konten File (Deep Scan)

---
### 📄 client\Main.client.lua
(470 Bytes)
```lua

print("DEBUG: init.client.lua TOP LEVEL") -- <-- DEBUG BARU
-- [src/client/init.client.lua]
print("OVHL OS: [Init.client.lua] Mulai...")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- PATH BARU: Ambil dari ReplicatedStorage
local ClientBootstrapper = require(ReplicatedStorage.Core.Kernel.ClientBootstrapper)

local OVHL_Core = ClientBootstrapper:new()
OVHL_Core:init()

print("✅ OVHL OS: [Init.client.lua] Client Core Initialized.")

```

---
### 📄 server\Main.server.lua
(454 Bytes)
```lua

print("DEBUG: init.server.lua TOP LEVEL") -- <-- DEBUG BARU
-- [src/server/init.server.lua]
print("OVHL OS: [Init.server.lua] Mulai...")

local ServerStorage = game:GetService("ServerStorage")
-- PATH BARU: Ambil dari ServerStorage
local ServerBootstrapper = require(ServerStorage.Core.Kernel.ServerBootstrapper)

local OVHL_Core = ServerBootstrapper:new()
OVHL_Core:init()

print("✅ OVHL OS: [Init.server.lua] Server Core Initialized.")

```

---
### 📄 replicated\Shared\Config.lua
(84 Bytes)
```lua

-- [src/replicated/Shared/Config.lua]
return {
    autosave_interval = 300,
}

```

---
### 📄 replicated\Core\Kernel\ClientBootstrapper.lua
(2.4 KB)
```lua

-- [src/replicated/Core/Kernel/ClientBootstrapper.lua] (V15 Secure + Hotfix)
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- PATH BARU: Ambil semua dari ReplicatedStorage
local Logger = require(ReplicatedStorage.Shared.Utils.Logger)
local UIManager = require(ReplicatedStorage.Core.Services.UIManager)
local InputService = require(ReplicatedStorage.Core.Services.InputService)

local ModulesFolder = ReplicatedStorage.Modules

local ClientBootstrapper = {}
ClientBootstrapper.__index = ClientBootstrapper

function ClientBootstrapper:new()
	local obj = setmetatable({}, ClientBootstrapper)
	self.logger = Logger:new("ClientBootstrapper")
	self.instances = { Logger = Logger }
	return obj
end

function ClientBootstrapper:init()
	self.logger:info("Mulai register services (Client V15)...")
	
	self.logger:info("Registering 'UIManager'...")
	self.instances["UIManager"] = UIManager

	self.logger:info("Registering 'InputService'...")
	self.instances["InputService"] = InputService:new()
	
	self.logger:info("Mulai init services (Client V15)...")
	
	if UIManager.Init then
		self.logger:info("Initializing 'UIManager'...")
		UIManager:Init()
	end

	local inputService = self.instances["InputService"]
	if inputService.init then
		self.logger:info("Initializing 'InputService'...")
		inputService:init(self.instances)
	end
	
	self.logger:info("Client services V15 initialized.")

	self.logger:info("Scanning client modules...")
	local modulesLoaded = 0
	
	-- PATH BARU: Scan ReplicatedStorage.Modules
	for _, moduleFolder in ipairs(ModulesFolder:GetChildren()) do
		if moduleFolder:IsA("Folder") then
			local manifestFile = moduleFolder:FindFirstChild("manifest.lua")
			if manifestFile and manifestFile:IsA("ModuleScript") then
				local success, manifest = pcall(require, manifestFile)
				if success and typeof(manifest) == "table" then
					local clientScriptFile = moduleFolder:FindFirstChild(manifest.client_script)
					if clientScriptFile and clientScriptFile:IsA("ModuleScript") then
						self.logger:info(("Loading client module '%s'..."):format(manifest.name))
						local handler = require(clientScriptFile)
						handler:init(self.instances) -- Inject context
						modulesLoaded = modulesLoaded + 1
					end
				end
			end
		end
	end
	self.logger:info(("Module scan selesai (%d client modul di-load)."):format(modulesLoaded))
end

return ClientBootstrapper

```

---
### 📄 replicated\Core\Services\InputService.lua
(694 Bytes)
```lua
--!strict
-- [src/replicated/Core/Services/InputService.lua]
-- (FIXED)

local InputService = {}
InputService.__index = InputService

function InputService:new()
	return setmetatable({}, InputService)
end

function InputService:init(context)
	-- ===================================
	-- INI DIA FIX-NYA
	-- ===================================
	-- 1. Ambil "Modul" Logger dari context
	local LoggerModule = context.Logger

	-- 2. Buat "Instance" logger baru PAKE NAMA SERVICE INI
	local logger = LoggerModule:new("InputService")
	-- ===================================

	-- 3. Sekarang aman manggil :info()
	logger:info("Service Initialized.")
end

return InputService

```

---
### 📄 replicated\Core\Services\UIManager.lua
(5.7 KB)
```lua
--!strict
-- [src/replicated/Core/Services/UIManager.lua]
-- FULL SCRIPT (Sudah di-fix dan dirapikan)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local UIManager = {}

local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local activeTheme: any
local screens = {}
local EventService

function UIManager:Init()
	local Events = ReplicatedStorage:FindFirstChild("OVHL_Events")
	if Events then
		local getThemeFunc: RemoteFunction = Events:WaitForChild("GetActiveTheme", 10)
		if getThemeFunc then
			activeTheme = getThemeFunc:InvokeServer()
		end
	end
	if not activeTheme then
		warn("[UIManager] Gagal load theme dari server, pakai default.")
		activeTheme = {
			Name = "Fallback",
			Colors = {
				Background = Color3.fromRGB(25, 25, 25),
				BackgroundHUD = Color3.fromRGB(10, 10, 10),
				TextPrimary = Color3.fromRGB(250, 250, 250),
				TextSecondary = Color3.fromRGB(180, 180, 180),
				Accent = Color3.fromRGB(50, 150, 255),
				Confirm = Color3.fromRGB(76, 175, 80),
				Decline = Color3.fromRGB(244, 67, 54),
				Surface = Color3.fromRGB(45, 45, 45),
				Border = Color3.fromRGB(60, 60, 60),
				Success = Color3.fromRGB(76, 175, 80),
				Warning = Color3.fromRGB(255, 193, 7),
				Error = Color3.fromRGB(244, 67, 54),
				Primary = Color3.fromRGB(0, 120, 215),
				Secondary = Color3.fromRGB(100, 100, 100),
			},
			Fonts = {
				Header = Enum.Font.GothamBold,
				Body = Enum.Font.Gotham,
			},
			FontSizes = {
				Body = 16,
				Button = 18,
				HUD = 24,
			},
		}
	end
end

function UIManager:CreateScreen(sn)
	if screens[sn] then
		return screens[sn]
	end
	local sg = Instance.new("ScreenGui")
	sg.Name = sn
	sg.ResetOnSpawn = false
	sg.Parent = playerGui
	screens[sn] = sg
	return sg
end

function UIManager:CreateWindow(o)
	local f = Instance.new("Frame")
	f.Name = o.Name
	f.Size = o.Size
	f.Position = o.Position
	f.AnchorPoint = o.AnchorPoint or Vector2.new(0, 0)
	f.BorderSizePixel = 0
	if o.Style == "HUD" then
		f.BackgroundColor3 = activeTheme.Colors.BackgroundHUD
	else
		f.BackgroundColor3 = activeTheme.Colors.Background
	end
	f.BackgroundTransparency = o.Transparency or 0.2
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 8)
	c.Parent = f
	f.Parent = o.Parent
	return f
end

function UIManager:AddTextLabel(o)
	local l = Instance.new("TextLabel")
	l.Name = o.Name
	l.Text = o.Text
	l.Size = o.Size
	l.Position = o.Position or UDim2.fromScale(0, 0)
	l.AnchorPoint = o.AnchorPoint or Vector2.new(0, 0)
	l.TextXAlignment = o.TextXAlignment or Enum.TextXAlignment.Left
	l.BackgroundTransparency = 1
	if o.Style == "HUD" then
		l.Font = activeTheme.Fonts.Header
		l.TextSize = activeTheme.FontSizes.HUD
	else
		l.Font = activeTheme.Fonts.Body
		l.TextSize = o.TextSize or activeTheme.FontSizes.Body
	end
	l.TextColor3 = o.TextColor or activeTheme.Colors.TextPrimary
	l.Parent = o.Parent
	return l
end

function UIManager:AddButton(o)
	local b = Instance.new("TextButton")
	b.Name = o.Name
	b.Text = o.Text
	b.Size = o.Size
	b.Position = o.Position
	b.AnchorPoint = o.AnchorPoint or Vector2.new(0, 0)
	if o.ColorStyle == "Confirm" then
		b.BackgroundColor3 = activeTheme.Colors.Confirm
	elseif o.ColorStyle == "Decline" then
		b.BackgroundColor3 = activeTheme.Colors.Decline
	else
		b.BackgroundColor3 = o.BackgroundColor or activeTheme.Colors.Accent
	end
	b.Font = activeTheme.Fonts.Body
	b.TextColor3 = activeTheme.Colors.TextPrimary
	b.TextSize = activeTheme.FontSizes.Button
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 6)
	c.Parent = b
	b.Parent = o.Parent
	return b
end

function UIManager:AddTextBox(o)
	local tb = Instance.new("TextBox")
	tb.Name = o.Name
	tb.PlaceholderText = o.Placeholder or ""
	tb.Text = o.Text or ""
	tb.Size = o.Size
	tb.Position = o.Position
	tb.AnchorPoint = o.AnchorPoint or Vector2.new(0, 0)
	tb.BackgroundColor3 = activeTheme.Colors.Surface
	tb.TextColor3 = activeTheme.Colors.TextPrimary
	tb.Font = activeTheme.Fonts.Body
	tb.TextSize = o.TextSize or activeTheme.FontSizes.Body
	tb.ClearTextOnFocus = false
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 4)
	c.Parent = tb
	local p = Instance.new("UIPadding")
	p.PaddingLeft = UDim.new(0, 8)
	p.PaddingRight = UDim.new(0, 8)
	p.Parent = tb
	tb.Parent = o.Parent
	return tb
end

function UIManager:AddImageLabel(o)
	local i = Instance.new("ImageLabel")
	i.Name = o.Name
	i.Image = o.Image
	i.Size = o.Size
	i.Position = o.Position or UDim2.fromScale(0, 0)
	i.AnchorPoint = o.AnchorPoint or Vector2.new(0, 0)
	i.BackgroundTransparency = 1
	i.Parent = o.Parent
	return i
end

function UIManager:ShowToastNotification(m, d)
	local s = self:CreateScreen("NotificationUI")
	local t = self:CreateWindow({
		Parent = s,
		Name = "Toast",
		Size = UDim2.new(0.3, 0, 0.1, 0),
		Position = UDim2.new(0.5, 0, -0.1, 0),
		AnchorPoint = Vector2.new(0.5, 0),
		Style = "HUD",
	})

	-- ===================================
	-- INI BAGIAN YANG DI-FIX (Parent = t)
	-- ===================================
	self:AddTextLabel({
		Parent = t,
		Name = "ToastLabel",
		Text = m,
		Size = UDim2.fromScale(1, 1),
		TextXAlignment = Enum.TextXAlignment.Center,
		Style = "HUD",
	})
	-- ===================================

	local ti = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	local gi = { Position = UDim2.new(0.5, 0, 0.05, 0) }
	local go = { Position = UDim2.new(0.5, 0, -0.1, 0) }

	TweenService:Create(t, ti, gi):Play()
	task.wait(d or 3)
	TweenService:Create(t, ti, go):Play()
	task.wait(0.5)
	t:Destroy()
end

return UIManager

```

---
### 📄 replicated\Shared\Utils\Logger.lua
(724 Bytes)
```lua

-- [src/replicated/Shared/Utils/Logger.lua] (V2 - CLIENT Tag Sync)
local Logger = {}
Logger.__index = Logger
local LOG_PREFIX = "[OVHL SYS MONITOR v1.0] [CLIENT] " 

function Logger:new(serviceName)
	local obj = setmetatable({}, Logger)
	obj.serviceName = serviceName or "ClientCore"
	return obj
end
function Logger:info(message)
	print(string.format("%s[%s] [CLIENT_CODE] [INFO] %s", LOG_PREFIX, self.serviceName, message))
end
function Logger:warn(message)
	print(string.format("%s[%s] [CLIENT_CODE] [WARN] %s", LOG_PREFIX, self.serviceName, message))
end
function Logger:error(message)
	warn(string.format("%s[%s] [CLIENT_CODE] [ERROR] %s", LOG_PREFIX, self.serviceName, message))
end
return Logger

```

---
### 📄 serverstorage\Core\Services\DataService.lua
(3.9 KB)
```lua

--!strict
-- [src/serverstorage/Core/Services/DataService.lua] (v1.1)
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- PATH BARU: Ambil dari ReplicatedStorage.Shared
local Config = require(ReplicatedStorage.Shared.Config) 
local DataService = {}
DataService.__index = DataService
local ProfileTemplate = { Uang = 5000, Level = 1, XP = 0 }
local function deepCopy(t: table) local nt = {} for k, v in pairs(t) do nt[k] = (typeof(v) == "table") and deepCopy(v) or v end return nt end

function DataService.new(sm: any)
	local self = setmetatable({}, DataService)
	self.sm = sm
	self.SystemMonitor = sm:Get("SystemMonitor")
	self.playerDataStore = DataStoreService:GetDataStore("OVHL_PlayerData_v1")
	self.globalDataStore = DataStoreService:GetDataStore("OVHL_GlobalData_v1")
	self.playerDataCache = {}
	self.globalDataCache = {}
	return self
end
function DataService:Init()
	self:_LoadGlobalConfig()
	Players.PlayerAdded:Connect(function(p) self:_onPlayerAdded(p) end)
	Players.PlayerRemoving:Connect(function(p) self:_onPlayerRemoving(p) end)
	game:BindToClose(function() self:_onServerShutdown() end)
	task.spawn(function() self:_autoSaveLoop() end)
	self.SystemMonitor:Log("DataService", "INFO", "INIT_SUCCESS", "DataService siap.")
end
function DataService:GetData(player: Player) return self.playerDataCache[player] end
function DataService:AddUang(player: Player, amount: number) local d = self:GetData(player) if d and d.Uang then d.Uang += amount local es = self.sm:Get("EventService") if es then es:FireClient(player, "UpdatePlayerData", {Uang = d.Uang}) end end end
function DataService:GetGlobal(key: string?) return key and self.globalDataCache[key] or self.globalDataCache end
function DataService:SetGlobal(key: string, value: any) self.globalDataCache[key] = value task.spawn(function() local s,e = pcall(function() self.globalDataStore:SetAsync("OVHL_CONFIG", self.globalDataCache) end) if not s then self.SystemMonitor:Log("DataService", "ERROR", "GLOBAL_SAVE_FAIL", ("Gagal save config: %s"):format(e)) end end) end
function DataService:_LoadGlobalConfig()
	self.SystemMonitor:Log("DataService", "INFO", "GLOBAL_LOAD_START", "Memuat global config (OVHL_CONFIG)...")
	local success, data = pcall(function() return self.globalDataStore:GetAsync("OVHL_CONFIG") end)
	if success and data then
		self.globalDataCache = data
		self.SystemMonitor:Log("DataService", "INFO", "GLOBAL_LOAD_SUCCESS", "Config global di-load dari DataStore.")
	else
		self.globalDataCache = deepCopy(Config)
		self.SystemMonitor:Log("DataService", "INFO", "GLOBAL_LOAD_DEFAULT", "Config global tidak ditemukan, pakai default & save.")
		self:SetGlobal("OVHL_CONFIG", self.globalDataCache)
	end
end
function DataService:_onPlayerAdded(player: Player) self:_loadPlayerData(player) end
function DataService:_onPlayerRemoving(player: Player) self:_savePlayerData(player) self.playerDataCache[player] = nil end
function DataService:_loadPlayerData(player: Player) local id="Player_"..player.UserId local s,d=pcall(function() return self.playerDataStore:GetAsync(id) end) if s then self.playerDataCache[player]=d or deepCopy(ProfileTemplate) task.wait(1) local es=self.sm:Get("EventService") if es then es:FireClient(player, "PlayerDataReady") end else player:Kick("Gagal load data.") end end
function DataService:_savePlayerData(player: Player) if not self.playerDataCache[player] then return end pcall(function() self.playerDataStore:SetAsync("Player_"..player.UserId, self.playerDataCache[player]) end) end
function DataService:_autoSaveLoop() while true do task.wait(Config.autosave_interval or 300) for _, p in ipairs(Players:GetPlayers()) do self:_savePlayerData(p) end end end
function DataService:_onServerShutdown() for _, p in ipairs(Players:GetPlayers()) do self:_savePlayerData(p) end task.wait(2) end
return DataService

```

---
### 📄 serverstorage\Core\Services\EventService.lua
(2.24 KB)
```lua

--!strict
-- [src/serverstorage/Core/Services/EventService.lua] (v1.2 - PingPong)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EventService = {}
EventService.__index = EventService
function EventService.new(sm: any)
	local self = setmetatable({}, EventService)
	self.sm = sm
	self.SystemMonitor = sm:Get("SystemMonitor")
	self.container = Instance.new("Folder") self.container.Name = "OVHL_Events" self.container.Parent = ReplicatedStorage
	self.events = {} self.functions = {}
	return self
end
function EventService:Init()
	self:CreateFunction("RequestPlayerData", function(p) local ds=self.sm:Get("DataService") return ds and ds:GetData(p) end)
	self:CreateEvent("PlayerDataReady")
	self:CreateEvent("UpdatePlayerData")
	self:CreateEvent("NewOrderNotification")
	self:CreateEvent("RespondToOrder")
	self:CreateEvent("UpdateMissionUI")
	self:CreateEvent("MissionCompleted")
	self:CreateFunction("AdminGetConfig") self:CreateFunction("AdminUpdateConfig") self:CreateFunction("AdminReloadModule")
	self:CreateEvent("ConfigUpdated")
	self:CreateEvent("PingToServer")
	self:CreateEvent("PongToClient")
	self.SystemMonitor:Log("EventService", "INFO", "INIT_SUCCESS", "EventService siap.")
end
function EventService:CreateFunction(n, cb) if self.functions[n] then return end local rf = Instance.new("RemoteFunction") rf.Name = n rf.Parent = self.container if cb then rf.OnServerInvoke=cb else rf.OnServerInvoke=function(p,...) self.SystemMonitor:Log("EventService","WARN","NO_HANDLER",("Func '%s' dipanggil tanpa handler"):format(n)) return nil end end self.functions[n]=rf end
function EventService:CreateEvent(n) if self.events[n] then return end local re = Instance.new("RemoteEvent") re.Name = n re.Parent = self.container self.events[n] = re end
function EventService:FireClient(p, n, ...) local e = self.events[n] if e then e:FireClient(p, ...) end end
function EventService:OnClientEvent(n, cb) local e = self.events[n] if e then e.OnServerEvent:Connect(cb) end end
function EventService:FireAllClients(n, ...) local e = self.events[n] if e then e:FireAllClients(...) end end
function EventService:InvokeClient(p, n, ...) local f = self.functions[n] if f then return f:InvokeClient(p, ...) end return nil end
return EventService

```

---
### 📄 serverstorage\Core\Services\ReplicationService.lua
(447 Bytes)
```lua

--!strict
-- [src/serverstorage/Core/Services/ReplicationService.lua]
local ReplicationService = {}
ReplicationService.__index = ReplicationService
function ReplicationService:new(sm: any) return setmetatable({}, ReplicationService) end
function ReplicationService:init(context)
    local logger = context.SystemMonitor
    logger:Log("ReplicationService", "INFO", "INIT_SUCCESS", "Service Initialized.")
end
return ReplicationService

```

---
### 📄 serverstorage\Core\Services\ServiceManager.lua
(3.35 KB)
```lua

--!strict
-- [src/serverstorage/Core/Services/ServiceManager.lua] (v2.0)
local ServiceManager = {}
ServiceManager.__index = ServiceManager
function ServiceManager.new()
	local self = setmetatable({}, ServiceManager)
	self.services = {}
	self.modules = {}
	self.SystemMonitor = nil 
	return self
end
function ServiceManager:Register(name: string, instance: any)
	if self.services[name] then
		self:Get("SystemMonitor"):Log("ServiceManager", "WARN", "DUPLICATE_REGISTER", ("Service '%s' sudah terdaftar."):format(name))
		return
	end
	self.services[name] = instance
end
function ServiceManager:RegisterModule(manifest: table, handlerModule: ModuleScript)
	if self.modules[manifest.name] then
		self:Get("SystemMonitor"):Log("ServiceManager", "WARN", "DUPLICATE_MODULE", ("Modul '%s' sudah terdaftar."):format(manifest.name))
		return
	end
	local moduleInstance = { manifest = manifest, handler = require(handlerModule), isStarted = false }
	self.modules[manifest.name] = moduleInstance
	self:Get("SystemMonitor"):Log("ServiceManager", "DEBUG", "MODULE_REGISTERED", ("Modul '%s' terdaftar"):format(manifest.name))
end
function ServiceManager:Get(name: string)
	local service = self.services[name]
	if not service then
		warn(("[ServiceManager] Peringatan: Service '%s' tidak ditemukan."):format(name))
	end
	return service
end
function ServiceManager:StartAll()
	local SystemMonitor = self:Get("SystemMonitor")
	SystemMonitor:Log("ServiceManager", "INFO", "START_ALL", "Memulai semua service dan modul...")
	local context = {}
	for name, service in pairs(self.services) do
		context[name] = service
	end
	for name, service in pairs(self.services) do
		if typeof(service.Init) == "function" then
			local status, err = pcall(service.Init, service)
			if not status then SystemMonitor:Log("ServiceManager", "ERROR", "SERVICE_INIT_FAIL", ("Gagal Init() service '%s': %s"):format(name, err))
			else SystemMonitor:Log("ServiceManager", "DEBUG", "SERVICE_INIT_SUCCESS", ("Service '%s' di-init"):format(name)) end
		end
	end
	for name, module in pairs(self.modules) do
		SystemMonitor:Log("ServiceManager", "DEBUG", "MODULE_START_ATTEMPT", ("Mencoba memulai modul '%s'"):format(name))
		if typeof(module.handler.init) == "function" then
			local canStart = true
			if module.manifest.depends then
				for _, depName in ipairs(module.manifest.depends) do
					if not self.services[depName] then
						SystemMonitor:Log("ServiceManager", "ERROR", "MODULE_DEP_MISSING", ("Gagal memulai '%s', dependensi '%s' tidak ditemukan."):format(name, depName))
						canStart = false; break
					end
				end
			end
			if canStart then
				SystemMonitor:Log("ServiceManager", "DEBUG", "MODULE_STARTING", ("Memulai modul '%s'..."):format(name))
				local status, err = pcall(module.handler.init, module.handler, context)
				if not status then SystemMonitor:Log("ServiceManager", "ERROR", "MODULE_INIT_FAIL", ("Gagal init() modul '%s': %s"):format(name, err))
				else module.isStarted = true; SystemMonitor:Log("ServiceManager", "INFO", "MODULE_START_SUCCESS", ("Modul '%s' berhasil dimulai"):format(name)) end
			end
		else
			SystemMonitor:Log("ServiceManager", "ERROR", "MODULE_NO_INIT", ("Modul '%s' tidak punya function init()"):format(name))
		end
	end
	SystemMonitor:Log("ServiceManager", "INFO", "START_ALL_COMPLETE", "Proses startup selesai.")
end
return ServiceManager

```

---
### 📄 serverstorage\Core\Services\StyleService.lua
(1.51 KB)
```lua

--!strict
-- [src/serverstorage/Core/Services/StyleService.lua]
local StyleService = {}
StyleService.__index = StyleService

function StyleService.new(sm: any)
	local self = setmetatable({}, StyleService)
	self.sm = sm
	self.SystemMonitor = sm:Get("SystemMonitor")
	self.themes = {}
	self.activeThemeName = "Default"
	self:_LoadThemes()
	return self
end
function StyleService:Init() task.defer(function() local es = self.sm:Get("EventService") if es then es:CreateFunction("GetActiveTheme", function(p) return self:GetTheme(self.activeThemeName) end) end end) self.SystemMonitor:Log("StyleService", "INFO", "INIT_SUCCESS", "StyleService siap.") end
function StyleService:GetTheme(n) return self.themes[n] end
function StyleService:_LoadThemes() self.themes["Default"] = { Name="Default",Colors={Background=Color3.fromRGB(25,25,25),BackgroundHUD=Color3.fromRGB(10,10,10),TextPrimary=Color3.fromRGB(250,250,250),TextSecondary=Color3.fromRGB(180,180,180),Accent=Color3.fromRGB(50,150,255),Confirm=Color3.fromRGB(76,175,80),Decline=Color3.fromRGB(244,67,54),Surface=Color3.fromRGB(45,45,45),Border=Color3.fromRGB(60,60,60),Success=Color3.fromRGB(76,175,80),Warning=Color3.fromRGB(255,193,7),Error=Color3.fromRGB(244,67,54),Primary=Color3.fromRGB(0,120,215),Secondary=Color3.fromRGB(100,100,100)},Fonts={Header=Enum.Font.GothamBold,Body=Enum.Font.Gotham},FontSizes={Body=16,Button=18,HUD=24}} self.SystemMonitor:Log("StyleService","INFO","THEME_LOADED",("Tema '%s' dimuat."):format(self.activeThemeName)) end
return StyleService

```

---
### 📄 serverstorage\Core\Services\SystemMonitor.lua
(717 Bytes)
```lua

--!strict
-- [src/serverstorage/Core/Services/SystemMonitor.lua] (V1.1 - SERVER Tag)
local SystemMonitor = {}
local serviceManager: any
local LOG_PREFIX = "[OVHL SYS MONITOR v1.0] [SERVER] " 

function SystemMonitor:Initialize(sm: any) if serviceManager then return end serviceManager = sm self:Log("SystemMonitor", "INFO", "INIT_SUCCESS", "SystemMonitor siap.") end
function SystemMonitor:Log(source: string, level: string, code: string, message: string)
	local log = string.format("%s[%s] [%s] [%s] %s", LOG_PREFIX, source, code, level, message)
	if level == "ERROR" or level == "WARN" then warn(log) else print(log) end
end
function SystemMonitor.new() return SystemMonitor end
return SystemMonitor

```

---
### 📄 serverstorage\Core\Services\TagService.lua
(3.57 KB)
```lua

--!strict
-- [src/serverstorage/Core/Services/TagService.lua] (v3.0)
local CollectionService = game:GetService("CollectionService")
local TagService = {}
TagService.__index = TagService
TagService.REGISTERED_TAGS = {
	DealerZone = { type = "zone", description = "Vehicle dealer area", requiredAttributes = {}, optionalAttributes = { "DealerName" } },
	CompanyZone = { type = "zone", description = "Company office area", requiredAttributes = { "CompanyID" }, optionalAttributes = { "CompanyName" } },
	MissionDestination = { type = "zone", description = "Drop-off destination", requiredAttributes = {}, optionalAttributes = { "DestinationType", "DisplayName" } },
	SpawnZone_Mall = { type = "spawn", weight = 2.0 },
	SpawnZone_Residential = { type = "spawn", weight = 1.0 },
	SpawnZone_Office = { type = "spawn", weight = 1.5 },
	SpawnZone_Airport = { type = "spawn", weight = 1.0 },
}
function TagService.new(sm: any)
	local self = setmetatable({}, TagService)
	self.sm = sm
	self.SystemMonitor = sm:Get("SystemMonitor")
	self.validationErrors = {}
	return self
end
function TagService:Init()
	self.SystemMonitor:Log("TagService", "INFO", "INIT_START", "Initializing Tag Service v3.0...")
	self:ValidateAllTags()
	for tagName, _ in pairs(self.REGISTERED_TAGS) do
		CollectionService:GetInstanceAddedSignal(tagName):Connect(function(instance)
			self:ValidateTaggedInstance(tagName, instance)
		end)
	end
	self.SystemMonitor:Log("TagService", "INFO", "INIT_SUCCESS", "TagService ready.")
end
function TagService:ValidateAllTags()
	local totalChecked, totalValid, totalInvalid = 0, 0, 0
	for tagName, tagSpec in pairs(self.REGISTERED_TAGS) do
		local instances = CollectionService:GetTagged(tagName)
		for _, instance in ipairs(instances) do
			totalChecked += 1
			if self:ValidateTaggedInstance(tagName, instance, true) then totalValid += 1 else totalInvalid += 1 end
		end
	end
	self.SystemMonitor:Log("TagService", "INFO", "VALIDATION_COMPLETE", ("Validated %d tagged instances: %d valid, %d invalid"):format(totalChecked, totalValid, totalInvalid))
	if #self.validationErrors > 0 then
		warn("[TagService] ⚠️ VALIDATION ERRORS FOUND:")
		for _, err in ipairs(self.validationErrors) do warn("  • " .. err) end
	end
end
function TagService:ValidateTaggedInstance(tagName: string, instance: Instance, silent: boolean?): boolean
	local tagSpec = self.REGISTERED_TAGS[tagName]
	if not tagSpec then self:LogError(("Unknown tag '%s' on %s"):format(tagName, instance:GetFullName()), silent); return false end
	if tagSpec.type == "zone" and not instance:IsA("BasePart") then self:LogError(("Tag '%s' requires BasePart, got %s on %s"):format(tagName, instance.ClassName, instance:GetFullName()), silent); return false end
	if tagSpec.requiredAttributes then
		for _, attrName in ipairs(tagSpec.requiredAttributes) do
			if instance:GetAttribute(attrName) == nil then self:LogError(("Missing required attribute '%s' on %s (tag: %s)"):format(attrName, instance:GetFullName(), tagName), silent); return false end
		end
	end
	return true
end
function TagService:LogError(message: string, silent: boolean?) table.insert(self.validationErrors, message); if not silent then self.SystemMonitor:Log("TagService", "WARN", "VALIDATION_ERROR", message) end end
function TagService:GetTaggedZones(tagName: string): {Instance} if not self.REGISTERED_TAGS[tagName] then warn(("[TagService] Unknown tag '%s'"):format(tagName)); return {} end; return CollectionService:GetTagged(tagName) end
function TagService:IsValidTag(tagName: string): boolean return self.REGISTERED_TAGS[tagName] ~= nil end
return TagService

```

---
### 📄 serverstorage\Core\Services\ZoneService.lua
(4.02 KB)
```lua

--!strict
-- [src/serverstorage/Core/Services/ZoneService.lua]
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ZoneService = {}
ZoneService.__index = ZoneService
local activeZones = {}
local taggedZoneHandlers = {}

function ZoneService.new(sm: any)
	local self = setmetatable({}, ZoneService)
	self.sm = sm
	self.SystemMonitor = sm:Get("SystemMonitor")
	self:_SetupTaggedZoneListeners()
	return self
end
function ZoneService:Init() self.SystemMonitor:Log("ZoneService", "INFO", "INIT_SUCCESS", "ZoneService siap.") end
function ZoneService:CreateZoneForPlayer(p, pos, cb) self:DestroyZoneForPlayer(p) local z = Instance.new("Part") z.Name="MissionZone_"..p.Name z.Size=Vector3.new(15,1,15) z.Position=pos z.Anchored=true z.CanCollide=false z.Transparency=0.7 z.Color=Color3.fromRGB(76,175,80) z.Shape=Enum.PartType.Cylinder z.Parent=Workspace local c=z.Touched:Connect(function(op) local char=op.Parent if not char then return end local h=char:FindFirstChildOfClass("Humanoid") if not h then return end local tp=Players:GetPlayerFromCharacter(char) if tp==p then cb() self:DestroyZoneForPlayer(p) end end) activeZones[p]={part=z,connection=c} self.SystemMonitor:Log("ZoneService","INFO","ZONE_CREATED",("Zona misi '%s' dibuat"):format(p.Name)) end
function ZoneService:DestroyZoneForPlayer(p) local zd=activeZones[p] if zd then zd.connection:Disconnect() zd.part:Destroy() activeZones[p]=nil end end
function ZoneService:RegisterTaggedZoneHandler(tag, enterCb, exitCb) taggedZoneHandlers[tag] = {enter = enterCb, exit = exitCb} self.SystemMonitor:Log("ZoneService", "INFO", "HANDLER_REGISTERED", ("Handler untuk Tag '%s' didaftarkan."):format(tag)) end
function ZoneService:_SetupTaggedZoneListeners()
    local playerStates = {}
    local function onPartTouched(tag, player, part)
        local handler = taggedZoneHandlers[tag]
        local playerTagState = playerStates[player.UserId] and playerStates[player.UserId][tag]
        if handler and handler.enter and not playerTagState then handler.enter(player, part); if not playerStates[player.UserId] then playerStates[player.UserId] = {} end; playerStates[player.UserId][tag] = true end
    end
    local function onPartTouchEnded(tag, player, part)
        local handler = taggedZoneHandlers[tag]
        local playerTagState = playerStates[player.UserId] and playerStates[player.UserId][tag]
        if handler and handler.exit and playerTagState then handler.exit(player, part); if playerStates[player.UserId] then playerStates[player.UserId][tag] = nil end; if playerStates[player.UserId] and next(playerStates[player.UserId]) == nil then playerStates[player.UserId] = nil end end
    end
    for tag, _ in pairs(taggedZoneHandlers) do
        for _, part in ipairs(CollectionService:GetTagged(tag)) do
            if part:IsA("BasePart") then
                part.Touched:Connect(function(op) local char = op.Parent if not char then return end; local p = Players:GetPlayerFromCharacter(char) if p then onPartTouched(tag, p, part) end end)
                part.TouchEnded:Connect(function(op) local char = op.Parent if not char then return end; local p = Players:GetPlayerFromCharacter(char) if p then onPartTouchEnded(tag, p, part) end end)
            end
        end
    end
    for tag, _ in pairs(taggedZoneHandlers) do
        CollectionService:GetInstanceAddedSignal(tag):Connect(function(part)
            if part:IsA("BasePart") then
                part.Touched:Connect(function(op) local char = op.Parent if not char then return end; local p = Players:GetPlayerFromCharacter(char) if p then onPartTouched(tag, p, part) end end)
                part.TouchEnded:Connect(function(op) local char = op.Parent if not char then return end; local p = Players:GetPlayerFromCharacter(char) if p then onPartTouchEnded(tag, p, part) end end)
            end
        end)
    end
    Players.PlayerRemoving:Connect(function(player) playerStates[player.UserId] = nil end)
end
return ZoneService

```

---
### 📄 serverstorage\Core\Kernel\ServerBootstrapper.lua
(3.1 KB)
```lua

-- [src/serverstorage/Core/Kernel/ServerBootstrapper.lua] (V15 Secure)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- PATH BARU: Ambil semua dari ServerStorage
local ServiceManager = require(ServerStorage.Core.Services.ServiceManager)
local SystemMonitor = require(ServerStorage.Core.Services.SystemMonitor)
local EventService = require(ServerStorage.Core.Services.EventService)
local DataService = require(ServerStorage.Core.Services.DataService)
local TagService = require(ServerStorage.Core.Services.TagService)
local ZoneService = require(ServerStorage.Core.Services.ZoneService)
local StyleService = require(ServerStorage.Core.Services.StyleService)
local ReplicationService = require(ServerStorage.Core.Services.ReplicationService)

-- PATH BARU: Ambil modul server dari ServerStorage
local ModulesFolder = ServerStorage.Modules

local ServerBootstrapper = {}
ServerBootstrapper.__index = ServerBootstrapper

function ServerBootstrapper:new()
	local obj = setmetatable({}, ServerBootstrapper)
	obj.sm = ServiceManager.new()
	obj.sm.SystemMonitor = SystemMonitor 
	SystemMonitor:Initialize(obj.sm)
	return obj
end

function ServerBootstrapper:init()
	local sm = self.sm
	
	sm.SystemMonitor:Log("ServerBootstrapper", "INFO", "REGISTER_START", "Mulai mendaftarkan service...")
	sm:Register("SystemMonitor", SystemMonitor)
	sm:Register("EventService", EventService.new(sm))
	sm:Register("DataService", DataService.new(sm))
	sm:Register("TagService", TagService.new(sm))
	sm:Register("ZoneService", ZoneService.new(sm))
	sm:Register("StyleService", StyleService.new(sm))
	sm:Register("ReplicationService", ReplicationService.new(sm))
	sm.SystemMonitor:Log("ServerBootstrapper", "INFO", "REGISTER_COMPLETE", "Semua service terdaftar.")

	sm.SystemMonitor:Log("ServerBootstrapper", "INFO", "MODULE_LOAD_START", "Scanning modules...")
	local modulesLoaded = 0
	
	-- PATH BARU: Scan ServerStorage.Modules
	for _, moduleFolder in ipairs(ModulesFolder:GetChildren()) do
		if moduleFolder:IsA("Folder") then
			-- PATH BARU: Ambil manifest dari ReplicatedStorage
			local manifestFile = ReplicatedStorage.Modules:FindFirstChild(moduleFolder.Name, true)
			if manifestFile and manifestFile:FindFirstChild("manifest.lua") then
				manifestFile = manifestFile:FindFirstChild("manifest.lua")
				
				local success, manifest = pcall(require, manifestFile)
				if success and typeof(manifest) == "table" then
					local serverScriptFile = moduleFolder:FindFirstChild(manifest.server_script)
					if serverScriptFile and serverScriptFile:IsA("ModuleScript") then
						sm:RegisterModule(manifest, serverScriptFile)
						modulesLoaded = modulesLoaded + 1
					end
				else
					sm.SystemMonitor:Log("ServerBootstrapper", "WARN", "MODULE_LOAD_FAIL", ("Gagal load manifest.lua dari %s"):format(moduleFolder.Name))
				end
			end
		end
	end
	sm.SystemMonitor:Log("ServerBootstrapper", "INFO", "MODULE_LOAD_COMPLETE", ("Module scan selesai (%d server modul di-load)."):format(modulesLoaded))
	
	sm:StartAll()
end

return ServerBootstrapper

```


## 🌲 Struktur Folder
```
📁 src
├── 📁 client
│   └── 🔷 Main.client.lua
├── 📁 replicated
│   ├── 📁 Core
│   │   ├── 📁 Kernel
│   │   │   └── 🔷 ClientBootstrapper.lua
│   │   └── 📁 Services
│   │       ├── 🔷 InputService.lua
│   │       └── 🔷 UIManager.lua
│   ├── 📁 Modules
│   │   └── 📁 pingpong
│   └── 📁 Shared
│       ├── 📁 Utils
│       │   └── 🔷 Logger.lua
│       └── 🔷 Config.lua
├── 📁 server
│   └── 🔷 Main.server.lua
└── 📁 serverstorage
    ├── 📁 Core
    │   ├── 📁 Kernel
    │   │   └── 🔷 ServerBootstrapper.lua
    │   └── 📁 Services
    │       ├── 🔷 DataService.lua
    │       ├── 🔷 EventService.lua
    │       ├── 🔷 ReplicationService.lua
    │       ├── 🔷 ServiceManager.lua
    │       ├── 🔷 StyleService.lua
    │       ├── 🔷 SystemMonitor.lua
    │       ├── 🔷 TagService.lua
    │       └── 🔷 ZoneService.lua
    └── 📁 Modules
        └── 📁 pingpong

```
