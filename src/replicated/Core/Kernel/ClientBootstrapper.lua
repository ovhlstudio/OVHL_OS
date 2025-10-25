
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
