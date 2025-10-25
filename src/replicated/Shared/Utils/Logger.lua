--!strict
-- [src/replicated/Shared/Utils/Logger.lua] (V3 - Synced with SystemMonitor)
local Logger = {}
local LOG_PREFIX = "[OVHL SYS MONITOR v1.0] [CLIENT] "

-- Functional style (sama seperti SystemMonitor)
function Logger:Log(source: string, level: string, code: string, message: string)
	local log = string.format("%s[%s] [%s] [%s] %s", LOG_PREFIX, source, code, level, message)
	if level == "ERROR" or level == "WARN" then
		warn(log)
	else
		print(log)
	end
end

-- Shorthand methods (untuk convenience)
function Logger:Info(source: string, code: string, message: string)
	self:Log(source, "INFO", code, message)
end

function Logger:Warn(source: string, code: string, message: string)
	self:Log(source, "WARN", code, message)
end

function Logger:Error(source: string, code: string, message: string)
	self:Log(source, "ERROR", code, message)
end

function Logger:Debug(source: string, code: string, message: string)
	self:Log(source, "DEBUG", code, message)
end

return Logger
