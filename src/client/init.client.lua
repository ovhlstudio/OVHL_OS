
print("DEBUG: init.client.lua TOP LEVEL") -- <-- DEBUG BARU
-- [src/client/init.client.lua]
print("OVHL OS: [Init.client.lua] Mulai...")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- PATH BARU: Ambil dari ReplicatedStorage
local ClientBootstrapper = require(ReplicatedStorage.Core.Kernel.ClientBootstrapper)

local OVHL_Core = ClientBootstrapper:new()
OVHL_Core:init()

print("✅ OVHL OS: [Init.client.lua] Client Core Initialized.")
