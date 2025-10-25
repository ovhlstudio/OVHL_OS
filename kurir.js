// ------------------------------------------------
// 📄 FILE: kurir.js
// 📍 PATH: ./kurir.js
// 🏛️ STUDIO: (N/A - File tool)
// 👨‍💻 AUTHOR: Omniverse Highland Studio
// 🎯 MISI: Buat modul 'pingpong' (Server & Client) untuk tes komunikasi.
// ------------------------------------------------

// Import 'path' bawaan Node.js
import path from "path";

// ==========================================================
// KONTRAK TOOLS WAJIB (IMPORT DARI NPM `ovhl-tools`)
// ==========================================================
// Asumsi 'ovhl-tools' mengekspor fungsi-fungsi ini:
import { 
  logger, 
  getTemplate, 
  ensureDir, 
  writeFile 
} from "ovhl-tools";
// ==========================================================

// --- KONFIGURASI MISI ---
const MISI = "Buat Modul 'PingPong' (Server & Client)";
const NAMA_MODUL_LOWER = "pingpong";
const NAMA_MODUL_PASCAL = "PingPong";

// Path V10 (Ref: 00_CONST 3.2)
const REPLICATED_PATH_REL = `src/replicated/Modules/${NAMA_MODUL_LOWER}`;
const SERVER_PATH_REL = `src/serverstorage/Modules/${NAMA_MODUL_LOWER}`;
const REPLICATED_PATH_ABS = path.resolve(process.cwd(), REPLICATED_PATH_REL);
const SERVER_PATH_ABS = path.resolve(process.cwd(), SERVER_PATH_REL);

// --- LOGIKA SPESIFIK DARI AI (Isian A-Z) ---

const LOGIKA_SERVER = `
    -- Ambil Logger dari context dan buat instance-nya
    local logger = self.Logger:new("PingPongHandler_Server")
    logger:info("Modul PingPong (SERVER) aktif.")

    -- Dengerin event 'C_TO_S_PING' dari client manapun
    self.EventService:Subscribe("C_TO_S_PING", function(player, pingData)
        logger:info("Menerima PING dari " .. player.Name .. " | Data: " .. pingData.message)
        
        -- Balas ke client yang spesifik
        self.EventService:PublishToClient(player, "S_TO_C_PONG", { 
            message = "PONG! Diterima oleh server.",
            serverTimestamp = os.time() 
        })
    end)
`;

const LOGIKA_CLIENT = `
    -- Ambil Logger dari context dan buat instance-nya
    local logger = self.Logger:new("PingPongHandler_Client")
    logger:info("Modul PingPong (CLIENT) aktif.")

    local clientPingTimestamp = 0

    -- 1. Langsung kirim PING saat start
    task.wait(5) -- Kasih jeda 5 detik biar server siap
    logger:info("Mengirim PING ke server...")
    clientPingTimestamp = os.time()
    self.EventService:PublishToServer("C_TO_S_PING", {
        message = "PING! Ini dari client.",
        timestamp = clientPingTimestamp
    })

    -- 2. Dengerin balasan PONG dari server
    self.EventService:Subscribe("S_TO_C_PONG", function(pongData)
        logger:info("Menerima PONG dari SERVER! | Data: " .. pongData.message)
        logger:warn("Total Roundtrip (Client -> Server -> Client): " .. (os.time() - clientPingTimestamp) .. " detik")
    end)
`;
// ---------------------------------------------

async function runMission() {
  logger.info(`🚀 [KURIR MISI] Memulai: ${MISI}`);

  try {
    // --- FASE 1: Buat Folder ---
    logger.startSpinner(`Membuat direktori Client: ${REPLICATED_PATH_REL}`);
    await ensureDir(REPLICATED_PATH_ABS);
    logger.succeedSpinner(`Direktori Client siap.`, REPLICATED_PATH_ABS);

    logger.startSpinner(`Membuat direktori Server: ${SERVER_PATH_REL}`);
    await ensureDir(SERVER_PATH_ABS);
    logger.succeedSpinner(`Direktori Server siap.`, SERVER_PATH_ABS);

    // --- FASE 2: Tulis File REPLICATED (Client/Shared) ---
    logger.info("Memulai penulisan file Replicated...");

    const manifestClientPath = path.join(REPLICATED_PATH_ABS, "manifest.lua");
    const manifestClientContent = await getTemplate("manifest.lua", {
      __PASCAL_NAME__: NAMA_MODUL_PASCAL,
      __LOWER_NAME__: NAMA_MODUL_LOWER,
      __SIDE__: "CLIENT",
      __DEPENDS__: '{"EventService", "Logger"}',
    });
    await writeFile(manifestClientPath, manifestClientContent);
    logger.succeedSpinner(`manifest.lua (Client) berhasil ditulis.`, manifestClientPath);

    const handlerClientPath = path.join(REPLICATED_PATH_ABS, `${NAMA_MODUL_PASCAL}Handler.lua`);
    const handlerClientContent = await getTemplate("handler.lua", {
      __PASCAL_NAME__: NAMA_MODUL_PASCAL,
      __LOGIKA_AI_DI_SINI__: LOGIKA_CLIENT,
    });
    await writeFile(handlerClientPath, handlerClientContent);
    logger.succeedSpinner(`${NAMA_MODUL_PASCAL}Handler.lua (Client) berhasil ditulis.`, handlerClientPath);

    const configClientPath = path.join(REPLICATED_PATH_ABS, `${NAMA_MODUL_PASCAL}Config.lua`);
    const configClientContent = await getTemplate("config.lua", {
      __PASCAL_NAME__: NAMA_MODUL_PASCAL,
    });
    await writeFile(configClientPath, configClientContent);
    logger.succeedSpinner(`${NAMA_MODUL_PASCAL}Config.lua (Client) berhasil ditulis.`, configClientPath);
    
    const readmeClientPath = path.join(REPLICATED_PATH_ABS, `README.md`);
    const readmeClientContent = await getTemplate("readme.md", {
      __PASCAL_NAME__: NAMA_MODUL_PASCAL,
      __LOWER_NAME__: NAMA_MODUL_LOWER,
    });
    await writeFile(readmeClientPath, readmeClientContent);
    logger.succeedSpinner(`README.md (Client) berhasil ditulis.`, readmeClientPath);

    // --- FASE 3: Tulis File SERVERSTORAGE (Server) ---
    logger.info("Memulai penulisan file ServerStorage...");

    const manifestServerPath = path.join(SERVER_PATH_ABS, "manifest.lua");
    const manifestServerContent = await getTemplate("manifest.lua", {
      __PASCAL_NAME__: NAMA_MODUL_PASCAL,
      __LOWER_NAME__: NAMA_MODUL_LOWER,
      __SIDE__: "SERVER",
      __DEPENDS__: '{"EventService", "Logger"}',
    });
    await writeFile(manifestServerPath, manifestServerContent);
    logger.succeedSpinner(`manifest.lua (Server) berhasil ditulis.`, manifestServerPath);

    const handlerServerPath = path.join(SERVER_PATH_ABS, `${NAMA_MODUL_PASCAL}Handler.lua`);
    const handlerServerContent = await getTemplate("handler.lua", {
      __PASCAL_NAME__: NAMA_MODUL_PASCAL,
      __LOGIKA_AI_DI_SINI__: LOGIKA_SERVER,
    });
    await writeFile(handlerServerPath, handlerServerContent);
    logger.succeedSpinner(`${NAMA_MODUL_PASCAL}Handler.lua (Server) berhasil ditulis.`, handlerServerPath);

    const configServerPath = path.join(SERVER_PATH_ABS, `${NAMA_MODUL_PASCAL}Config.lua`);
    const configServerContent = await getTemplate("config.lua", {
      __PASCAL_NAME__: NAMA_MODUL_PASCAL,
    });
    await writeFile(configServerPath, configServerContent);
    logger.succeedSpinner(`${NAMA_MODUL_PASCAL}Config.lua (Server) berhasil ditulis.`, configServerPath);

    const readmeServerPath = path.join(SERVER_PATH_ABS, `README.md`);
    const readmeServerContent = await getTemplate("readme.md", {
      __PASCAL_NAME__: NAMA_MODUL_PASCAL,
      __LOWER_NAME__: NAMA_MODUL_LOWER,
    });
    await writeFile(readmeServerPath, readmeServerContent);
    logger.succeedSpinner(`README.md (Server) berhasil ditulis.`, readmeServerPath);
    

    // --- LAPORAN AKHIR ---
    logger.success("\n✅ [KURIR MISI] Misi Selesai dengan Sukses!");
    logger.info(`Modul '${NAMA_MODUL_LOWER}' (Client & Server) telah dibuat.`);
    logger.info(`Path Client: '${REPLICATED_PATH_REL}'`);
    logger.info(`Path Server: '${SERVER_PATH_REL}'`);
    logger.warn("Jalankan 'rojo serve' dan tes di Studio!");

  } catch (error) {
    logger.failSpinner("Misi GAGAL. Menghentikan proses...");
    logger.error(`❌ [ERROR DETAIL]: ${error.message}`);
    logger.error("Pastikan 'ovhl-tools' sudah terinstal (`npm install ovhl-tools`) dan template (handler.lua, manifest.lua, dll) ada.");
  }
}

// --- JALANKAN MISI ---
runMission();

// ------------------------------------------------
// 🏁 End of: ./kurir.js
// ------------------------------------------------