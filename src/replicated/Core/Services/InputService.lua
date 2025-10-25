
--!strict
-- [src/replicated/Core/Services/InputService.lua]
local InputService = {}
InputService.__index = InputService
function InputService:new() return setmetatable({}, InputService) end
function InputService:init(context)
    local logger = context.Logger
    logger:info("Service Initialized.")
end
return InputService
