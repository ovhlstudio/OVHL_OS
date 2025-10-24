
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
