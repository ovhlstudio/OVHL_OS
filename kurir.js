// ------------------------------------------------
// 📄 FILE: kurir.js
// 📍 PATH: ./kurir.js
// 🏛️ STUDIO: (N/A - File tool)
// 👨‍💻 AUTHOR: Omniverse Highland Studio
// 🎯 MISI: Buat Modul PingPong Test Communication
// ------------------------------------------------

import path from "path";
import { logger, getTemplate, ensureDir, writeFile } from "ovhl-tools";

const MISI = "Buat Modul PingPong Test Communication";
const NAMA_MODUL_LOWER = "pingpong";
const NAMA_MODUL_PASCAL = "PingPong";

// Path V10 Structure
const REPLICATED_PATH_REL = `src/replicated/Modules/${NAMA_MODUL_LOWER}`;
const SERVER_PATH_REL = `src/serverstorage/Modules/${NAMA_MODUL_LOWER}`;
const REPLICATED_PATH_ABS = path.resolve(process.cwd(), REPLICATED_PATH_REL);
const SERVER_PATH_ABS = path.resolve(process.cwd(), SERVER_PATH_REL);

// Logika AI untuk SERVER
const LOGIKA_SERVER = `
local logger = self.Logger:new("PingPong_Server")
logger:info("🚀 Modul PingPong (SERVER) aktif!")

-- Subscribe event PING dari client
self.EventService:Subscribe("PING_PONG_PING", function(player, pingData)
    logger:info("📨 Menerima PING dari " .. player.Name)
    logger:info("📊 Data PING: " .. tostring(pingData.message))
    
    -- Simulasi processing
    task.wait(1)
    
    -- Kirim PONG balik ke client
    self.EventService:PublishToClient(player, "PING_PONG_PONG", {
        message = "PONG dari SERVER!",
        original_message = pingData.message,
        server_time = os.time(),
        processed_by = "OVHL_OS_Server"
    })
    
    logger:info("📤 Mengirim PONG ke " .. player.Name)
end)

logger:info("✅ PingPong Server siap menerima PING!")
`;

// Logika AI untuk CLIENT  
const LOGIKA_CLIENT = `
local logger = self.Logger:new("PingPong_Client")
logger:info("🚀 Modul PingPong (CLIENT) aktif!")

-- Subscribe event PONG dari server
self.EventService:Subscribe("PING_PONG_PONG", function(pongData)
    logger:info("🎯 Menerima PONG dari SERVER!")
    logger:info("📊 Data PONG: " .. tostring(pongData.message))
    logger:info("⏰ Server Time: " .. tostring(pongData.server_time))
    logger:info("🔧 Processed by: " .. tostring(pongData.processed_by))
end)

-- Auto test setelah 3 detik
task.spawn(function()
    task.wait(3)
    
    logger:info("🎯 Mengirim PING test ke Server...")
    
    -- Kirim PING ke server
    self.EventService:PublishToServer("PING_PONG_PING", {
        message = "PING dari CLIENT OVHL!",
        client_time = os.time(),
        version = "1.0.0"
    })
    
    logger:info("📤 PING terkirim, menunggu PONG...")
end)

logger:info("✅ PingPong Client siap!")
`;

async function runMission() {
    logger.info(`🚀 [KURIR] Memulai: ${MISI}`);
    logger.info(`🌿 Branch: feature/modul-pingpong`);

    try {
        // --- FASE 1: Buat Folder Structure ---
        logger.startSpinner("Membuat struktur folder modul...");
        await ensureDir(REPLICATED_PATH_ABS);
        await ensureDir(SERVER_PATH_ABS);
        logger.succeedSpinner("Struktur folder siap!");

        // --- FASE 2: CLIENT FILES (ReplicatedStorage) ---
        
        // 2.1 manifest.lua (Client)
        logger.startSpinner("Memproses manifest.lua (Client)...");
        const manifestClient = await getTemplate("ai/manifest-ai.lua", {
            __PASCAL_NAME__: NAMA_MODUL_PASCAL,
            __DESCRIPTION__: "Modul test komunikasi Client-Server PingPong",
            __AUTHOR__: "OVHL Developer",
            __SIDE__: "CLIENT",
            __DEPENDS__: '{"EventService", "Logger"}',
            __GENERATED_DATE__: new Date().toISOString(),
            __VERSION__: "1.0.0"
        });
        await writeFile(path.join(REPLICATED_PATH_ABS, "manifest.lua"), manifestClient);
        logger.succeedSpinner("manifest.lua (Client) selesai!");

        // 2.2 Handler Client
        logger.startSpinner("Memproses PingPong.client.lua...");
        const handlerClient = await getTemplate("ai/handler-ai.lua", {
            __PASCAL_NAME__: NAMA_MODUL_PASCAL,
            __DESCRIPTION__: "Client handler untuk modul PingPong",
            __AUTHOR__: "OVHL Developer", 
            __SIDE__: "CLIENT",
            __LOGIKA_AI_DI_SINI__: LOGIKA_CLIENT,
            __GENERATED_DATE__: new Date().toISOString(),
            __VERSION__: "1.0.0"
        });
        await writeFile(path.join(REPLICATED_PATH_ABS, "PingPong.client.lua"), handlerClient);
        logger.succeedSpinner("PingPong.client.lua selesai!");

        // --- FASE 3: SERVER FILES (ServerStorage) ---
        
        // 3.1 manifest.lua (Server)
        logger.startSpinner("Memproses manifest.lua (Server)...");
        const manifestServer = await getTemplate("ai/manifest-ai.lua", {
            __PASCAL_NAME__: NAMA_MODUL_PASCAL,
            __DESCRIPTION__: "Modul test komunikasi Client-Server PingPong", 
            __AUTHOR__: "OVHL Developer",
            __SIDE__: "SERVER",
            __DEPENDS__: '{"EventService", "Logger"}',
            __GENERATED_DATE__: new Date().toISOString(),
            __VERSION__: "1.0.0"
        });
        await writeFile(path.join(SERVER_PATH_ABS, "manifest.lua"), manifestServer);
        logger.succeedSpinner("manifest.lua (Server) selesai!");

        // 3.2 Handler Server
        logger.startSpinner("Memproses PingPong.server.lua...");
        const handlerServer = await getTemplate("ai/handler-ai.lua", {
            __PASCAL_NAME__: NAMA_MODUL_PASCAL,
            __DESCRIPTION__: "Server handler untuk modul PingPong",
            __AUTHOR__: "OVHL Developer",
            __SIDE__: "SERVER", 
            __LOGIKA_AI_DI_SINI__: LOGIKA_SERVER,
            __GENERATED_DATE__: new Date().toISOString(),
            __VERSION__: "1.0.0"
        });
        await writeFile(path.join(SERVER_PATH_ABS, "PingPong.server.lua"), handlerServer);
        logger.succeedSpinner("PingPong.server.lua selesai!");

        // --- LAPORAN FINAL ---
        logger.success("\n✅ [KURIR MISI] MODUL PINGPONG BERHASIL DIBUAT!");
        logger.info(`📁 Client: ${REPLICATED_PATH_REL}`);
        logger.info(`📁 Server: ${SERVER_PATH_REL}`);
        logger.info("\n🎯 TEST INSTRUKSI:");
        logger.info("1. Jalankan 'rojo serve'");
        logger.info("2. Play game di Roblox Studio");
        logger.info("3. Lihat Output - harusnya ada log PING/PONG!");
        logger.info("4. Client auto kirim PING setelah 3 detik");
        logger.info("5. Server balas PONG, client terima & log!");

    } catch (error) {
        logger.failSpinner("❌ MISI GAGAL!");
        logger.error(`Detail Error: ${error.message}`);
    }
}

// --- JALANKAN MISI ---
runMission();

// ------------------------------------------------
// 🏁 End of: ./kurir.js
// ------------------------------------------------