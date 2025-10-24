-- 🚀 OVHL Bootstrapper
local CoreInit = require(script:WaitForChild("CoreInit"))
local DataService = require(script:WaitForChild("DataService"))
local EventService = require(script:WaitForChild("EventService"))
local NetworkService = require(script:WaitForChild("NetworkService"))

print("[OVHL BOOTSTRAPPER] Initializing core services...")

CoreInit:Init()
DataService:Init()
EventService:Init()
NetworkService:Init()

print("[OVHL BOOTSTRAPPER] ✅ All systems online.")