
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
