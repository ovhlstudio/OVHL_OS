--!strict
-- [src/replicated/Core/Services/InputService.lua]
-- (FIXED)

local InputService = {}
InputService.__index = InputService

function InputService:new()
	return setmetatable({}, InputService)
end

function InputService:init(context)
	-- ===================================
	-- INI DIA FIX-NYA
	-- ===================================
	-- 1. Ambil "Modul" Logger dari context
	local LoggerModule = context.Logger

	-- 2. Buat "Instance" logger baru PAKE NAMA SERVICE INI
	local logger = LoggerModule:new("InputService")
	-- ===================================

	-- 3. Sekarang aman manggil :info()
	logger:info("Service Initialized.")
end

return InputService
