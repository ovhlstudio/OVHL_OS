
-- [src/replicated/Modules/pingpong/manifest.lua]
return {
	name = "PingPong",
	version = "1.0.0",
	description = "Modul tes komunikasi server-client.",
	server_script = "PingPong.server.lua",
	client_script = "PingPong.client.lua",
	depends = { "EventService", "SystemMonitor" }
}
