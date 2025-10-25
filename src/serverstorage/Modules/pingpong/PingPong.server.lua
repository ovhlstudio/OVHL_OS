
-- [src/serverstorage/Modules/pingpong/PingPong.server.lua]
local PingPongServer = {}
function PingPongServer:init(context)
	local EventService = context.EventService
	local SystemMonitor = context.SystemMonitor
	SystemMonitor:Log("PingPong", "INFO", "INIT", "Modul PingPong Server siap.")
	EventService:OnClientEvent("PingToServer", function(player, pingTime)
		local latency = (tick() - pingTime) * 1000
		SystemMonitor:Log("PingPong", "INFO", "PING", ("PING diterima dari %s! Latency: %.2f ms"):format(player.Name, latency))
		task.wait(0.5)
		EventService:FireClient(player, "PongToClient", pingTime)
	end)
end
return PingPongServer
