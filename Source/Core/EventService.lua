-- ⚡ EventService
local EventService = {}
local events = {}

function EventService:Init()
  print("[OVHL] EventService online.")
end

function EventService:Bind(name, fn)
  events[name] = fn
end

function EventService:Fire(name, ...)
  if events[name] then
    events[name](...)
  end
end

return EventService