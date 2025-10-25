
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
