
-- [src/replicated/Modules/pingpong/PingPong.client.lua]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PingPongClient = {}
function PingPongClient:init(context)
	local UIManager = context.UIManager
	local Logger = context.Logger
	Logger:info("Modul PingPong Client siap.")
	local Events = ReplicatedStorage:WaitForChild("OVHL_Events")
	if not Events then Logger:error("Gagal! Folder 'OVHL_Events' tidak ditemukan."); return end
	local PingEvent = Events:WaitForChild("PingToServer")
	local PongEvent = Events:WaitForChild("PongToClient")
	PongEvent.OnClientEvent:Connect(function(pingTime)
		local roundTrip = (tick() - pingTime) * 1000
		local message = ("PONG diterima! Round trip: %.2f ms"):format(roundTrip)
		Logger:info(message)
		UIManager:ShowToastNotification(message, 5)
	end)
	task.wait(5)
	Logger:info("Mengirim PING ke server...")
	PingEvent:FireServer(tick())
end
return PingPongClient
