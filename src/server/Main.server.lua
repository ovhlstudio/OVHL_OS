print("DEBUG: init.server.lua TOP LEVEL") -- <-- DEBUG BARU
-- [src/server/init.server.lua]
print("OVHL OS: [Init.server.lua] Mulai...")

local ServerStorage = game:GetService("ServerStorage")
-- PATH BARU: Ambil dari ServerStorage
local ServerBootstrapper = require(ServerStorage.Core.Kernel.ServerBootstrapper)

local OVHL_Core = ServerBootstrapper:new()
OVHL_Core:init()

print("✅ OVHL OS: [Init.server.lua] Server Core Initialized.")
