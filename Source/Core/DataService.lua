-- 💾 DataService
local DataService = {}
local data = {}

function DataService:Init()
  print("[OVHL] DataService initialized.")
end

function DataService:Set(id, key, value)
  data[id] = data[id] or {}
  data[id][key] = value
end

function DataService:Get(id, key)
  return data[id] and data[id][key]
end

return DataService