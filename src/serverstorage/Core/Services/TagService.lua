
--!strict
-- [src/serverstorage/Core/Services/TagService.lua] (v3.0)
local CollectionService = game:GetService("CollectionService")
local TagService = {}
TagService.__index = TagService
TagService.REGISTERED_TAGS = {
	DealerZone = { type = "zone", description = "Vehicle dealer area", requiredAttributes = {}, optionalAttributes = { "DealerName" } },
	CompanyZone = { type = "zone", description = "Company office area", requiredAttributes = { "CompanyID" }, optionalAttributes = { "CompanyName" } },
	MissionDestination = { type = "zone", description = "Drop-off destination", requiredAttributes = {}, optionalAttributes = { "DestinationType", "DisplayName" } },
	SpawnZone_Mall = { type = "spawn", weight = 2.0 },
	SpawnZone_Residential = { type = "spawn", weight = 1.0 },
	SpawnZone_Office = { type = "spawn", weight = 1.5 },
	SpawnZone_Airport = { type = "spawn", weight = 1.0 },
}
function TagService.new(sm: any)
	local self = setmetatable({}, TagService)
	self.sm = sm
	self.SystemMonitor = sm:Get("SystemMonitor")
	self.validationErrors = {}
	return self
end
function TagService:Init()
	self.SystemMonitor:Log("TagService", "INFO", "INIT_START", "Initializing Tag Service v3.0...")
	self:ValidateAllTags()
	for tagName, _ in pairs(self.REGISTERED_TAGS) do
		CollectionService:GetInstanceAddedSignal(tagName):Connect(function(instance)
			self:ValidateTaggedInstance(tagName, instance)
		end)
	end
	self.SystemMonitor:Log("TagService", "INFO", "INIT_SUCCESS", "TagService ready.")
end
function TagService:ValidateAllTags()
	local totalChecked, totalValid, totalInvalid = 0, 0, 0
	for tagName, tagSpec in pairs(self.REGISTERED_TAGS) do
		local instances = CollectionService:GetTagged(tagName)
		for _, instance in ipairs(instances) do
			totalChecked += 1
			if self:ValidateTaggedInstance(tagName, instance, true) then totalValid += 1 else totalInvalid += 1 end
		end
	end
	self.SystemMonitor:Log("TagService", "INFO", "VALIDATION_COMPLETE", ("Validated %d tagged instances: %d valid, %d invalid"):format(totalChecked, totalValid, totalInvalid))
	if #self.validationErrors > 0 then
		warn("[TagService] ⚠️ VALIDATION ERRORS FOUND:")
		for _, err in ipairs(self.validationErrors) do warn("  • " .. err) end
	end
end
function TagService:ValidateTaggedInstance(tagName: string, instance: Instance, silent: boolean?): boolean
	local tagSpec = self.REGISTERED_TAGS[tagName]
	if not tagSpec then self:LogError(("Unknown tag '%s' on %s"):format(tagName, instance:GetFullName()), silent); return false end
	if tagSpec.type == "zone" and not instance:IsA("BasePart") then self:LogError(("Tag '%s' requires BasePart, got %s on %s"):format(tagName, instance.ClassName, instance:GetFullName()), silent); return false end
	if tagSpec.requiredAttributes then
		for _, attrName in ipairs(tagSpec.requiredAttributes) do
			if instance:GetAttribute(attrName) == nil then self:LogError(("Missing required attribute '%s' on %s (tag: %s)"):format(attrName, instance:GetFullName(), tagName), silent); return false end
		end
	end
	return true
end
function TagService:LogError(message: string, silent: boolean?) table.insert(self.validationErrors, message); if not silent then self.SystemMonitor:Log("TagService", "WARN", "VALIDATION_ERROR", message) end end
function TagService:GetTaggedZones(tagName: string): {Instance} if not self.REGISTERED_TAGS[tagName] then warn(("[TagService] Unknown tag '%s'"):format(tagName)); return {} end; return CollectionService:GetTagged(tagName) end
function TagService:IsValidTag(tagName: string): boolean return self.REGISTERED_TAGS[tagName] ~= nil end
return TagService
