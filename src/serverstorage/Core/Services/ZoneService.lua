
--!strict
-- [src/serverstorage/Core/Services/ZoneService.lua]
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ZoneService = {}
ZoneService.__index = ZoneService
local activeZones = {}
local taggedZoneHandlers = {}

function ZoneService.new(sm: any)
	local self = setmetatable({}, ZoneService)
	self.sm = sm
	self.SystemMonitor = sm:Get("SystemMonitor")
	self:_SetupTaggedZoneListeners()
	return self
end
function ZoneService:Init() self.SystemMonitor:Log("ZoneService", "INFO", "INIT_SUCCESS", "ZoneService siap.") end
function ZoneService:CreateZoneForPlayer(p, pos, cb) self:DestroyZoneForPlayer(p) local z = Instance.new("Part") z.Name="MissionZone_"..p.Name z.Size=Vector3.new(15,1,15) z.Position=pos z.Anchored=true z.CanCollide=false z.Transparency=0.7 z.Color=Color3.fromRGB(76,175,80) z.Shape=Enum.PartType.Cylinder z.Parent=Workspace local c=z.Touched:Connect(function(op) local char=op.Parent if not char then return end local h=char:FindFirstChildOfClass("Humanoid") if not h then return end local tp=Players:GetPlayerFromCharacter(char) if tp==p then cb() self:DestroyZoneForPlayer(p) end end) activeZones[p]={part=z,connection=c} self.SystemMonitor:Log("ZoneService","INFO","ZONE_CREATED",("Zona misi '%s' dibuat"):format(p.Name)) end
function ZoneService:DestroyZoneForPlayer(p) local zd=activeZones[p] if zd then zd.connection:Disconnect() zd.part:Destroy() activeZones[p]=nil end end
function ZoneService:RegisterTaggedZoneHandler(tag, enterCb, exitCb) taggedZoneHandlers[tag] = {enter = enterCb, exit = exitCb} self.SystemMonitor:Log("ZoneService", "INFO", "HANDLER_REGISTERED", ("Handler untuk Tag '%s' didaftarkan."):format(tag)) end
function ZoneService:_SetupTaggedZoneListeners()
    local playerStates = {}
    local function onPartTouched(tag, player, part)
        local handler = taggedZoneHandlers[tag]
        local playerTagState = playerStates[player.UserId] and playerStates[player.UserId][tag]
        if handler and handler.enter and not playerTagState then handler.enter(player, part); if not playerStates[player.UserId] then playerStates[player.UserId] = {} end; playerStates[player.UserId][tag] = true end
    end
    local function onPartTouchEnded(tag, player, part)
        local handler = taggedZoneHandlers[tag]
        local playerTagState = playerStates[player.UserId] and playerStates[player.UserId][tag]
        if handler and handler.exit and playerTagState then handler.exit(player, part); if playerStates[player.UserId] then playerStates[player.UserId][tag] = nil end; if playerStates[player.UserId] and next(playerStates[player.UserId]) == nil then playerStates[player.UserId] = nil end end
    end
    for tag, _ in pairs(taggedZoneHandlers) do
        for _, part in ipairs(CollectionService:GetTagged(tag)) do
            if part:IsA("BasePart") then
                part.Touched:Connect(function(op) local char = op.Parent if not char then return end; local p = Players:GetPlayerFromCharacter(char) if p then onPartTouched(tag, p, part) end end)
                part.TouchEnded:Connect(function(op) local char = op.Parent if not char then return end; local p = Players:GetPlayerFromCharacter(char) if p then onPartTouchEnded(tag, p, part) end end)
            end
        end
    end
    for tag, _ in pairs(taggedZoneHandlers) do
        CollectionService:GetInstanceAddedSignal(tag):Connect(function(part)
            if part:IsA("BasePart") then
                part.Touched:Connect(function(op) local char = op.Parent if not char then return end; local p = Players:GetPlayerFromCharacter(char) if p then onPartTouched(tag, p, part) end end)
                part.TouchEnded:Connect(function(op) local char = op.Parent if not char then return end; local p = Players:GetPlayerFromCharacter(char) if p then onPartTouchEnded(tag, p, part) end end)
            end
        end)
    end
    Players.PlayerRemoving:Connect(function(player) playerStates[player.UserId] = nil end)
end
return ZoneService
