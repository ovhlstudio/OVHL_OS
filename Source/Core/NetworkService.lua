-- 🌐 NetworkService
local NetworkService = {}

function NetworkService:Init()
  print("[OVHL] NetworkService initialized.")
end

function NetworkService:Send(player, msg)
  print("[OVHL] Network ->", player, msg)
end

return NetworkService