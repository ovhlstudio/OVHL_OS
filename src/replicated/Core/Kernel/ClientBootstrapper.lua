--!strict
-- [src/replicated/Core/Kernel/ClientBootstrapper.lua] (V16 - Functional Logger)
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- PATH: Ambil semua dari ReplicatedStorage
local Logger = require(ReplicatedStorage.Shared.Utils.Logger)
local UIManager = require(ReplicatedStorage.Core.Services.UIManager)
local InputService = require(ReplicatedStorage.Core.Services.InputService)

local ModulesFolder = ReplicatedStorage.Modules

local ClientBootstrapper = {}

function ClientBootstrapper:Init()
	Logger:Info("ClientBootstrapper", "INIT_START", "Mulai register services (Client V16)...")

	-- Store instances
	local instances = { Logger = Logger }

	Logger:Info("ClientBootstrapper", "REGISTER", "Registering 'UIManager'...")
	instances["UIManager"] = UIManager

	Logger:Info("ClientBootstrapper", "REGISTER", "Registering 'InputService'...")
	instances["InputService"] = InputService

	Logger:Info("ClientBootstrapper", "SERVICE_INIT_START", "Mulai init services...")

	-- Initialize UIManager
	if UIManager.Init then
		Logger:Info("ClientBootstrapper", "SERVICE_INIT", "Initializing 'UIManager'...")
		UIManager:Init()
	end

	-- Initialize InputService
	if InputService.Init then
		Logger:Info("ClientBootstrapper", "SERVICE_INIT", "Initializing 'InputService'...")
		InputService:Init(instances)
	end

	Logger:Info("ClientBootstrapper", "SERVICE_INIT_COMPLETE", "Client services initialized.")

	Logger:Info("ClientBootstrapper", "MODULE_SCAN_START", "Scanning client modules...")
	local modulesLoaded = 0

	-- Scan ReplicatedStorage.Modules
	for _, moduleFolder in ipairs(ModulesFolder:GetChildren()) do
		if moduleFolder:IsA("Folder") then
			local manifestFile = moduleFolder:FindFirstChild("manifest.lua")
			if manifestFile and manifestFile:IsA("ModuleScript") then
				local success, manifest = pcall(require, manifestFile)
				if success and typeof(manifest) == "table" then
					local clientScriptFile = moduleFolder:FindFirstChild(manifest.client_script)
					if clientScriptFile and clientScriptFile:IsA("ModuleScript") then
						Logger:Info(
							"ClientBootstrapper",
							"MODULE_LOAD",
							string.format("Loading client module '%s'...", manifest.name)
						)
						local loadSuccess, handler = pcall(require, clientScriptFile)
						if loadSuccess and handler and handler.Init then
							pcall(handler.Init, handler, instances) -- Inject context with error handling
							modulesLoaded = modulesLoaded + 1
						else
							Logger:Warn(
								"ClientBootstrapper",
								"MODULE_LOAD_FAIL",
								string.format("Failed to load module '%s'", manifest.name)
							)
						end
					end
				end
			end
		end
	end

	Logger:Info(
		"ClientBootstrapper",
		"MODULE_SCAN_COMPLETE",
		string.format("Module scan selesai (%d client modul di-load).", modulesLoaded)
	)
end

return ClientBootstrapper
