// 🤖 AI Smart Script (MISI: V19 - Revert ke Rojo JSON V16 ($className))

import path from "path";
// ==========================================================
// KONTRAK TOOLS WAJIB
// ==========================================================
import { writeFile } from "./Tools/ovhl-tools/utils/fileSystem.js";
import { logger } from "./Tools/ovhl-tools/core/logger.js";
// ==========================================================

// --- KONFIGURASI MISI ---
const MISI = "V19 - Revert ke Rojo JSON V16 ($className)";
const ROOT_PATH_ABSOLUT = path.resolve(process.cwd());
const ROJO_CONFIG_PATH = "default.project.json";

// --- KONTEN FILE (VERSI V16) ---
const ROJO_CONFIG_CONTENT = `{
  "name": "OVHL_OS_V16_SECURE_CLEANEST_FIXED",
  "tree": {
    "$className": "DataModel",

    "ReplicatedStorage": {
      "$path": "src/replicated"
    },
    "ServerStorage": {
      "$path": "src/serverstorage"
    },
    "ServerScriptService": {
      "init": {
        "$path": "src/server/init.server.lua",
        "$className": "Script"
      }
    },
    "StarterPlayer": {
      "StarterPlayerScripts": {
        "init": {
          "$path": "src/client/init.client.lua",
          "$className": "LocalScript"
        }
      }
    }
  }
}
`;

// --- DAFTAR FILE ---
const FILES_TO_WRITE = [
  {
    path: path.join(ROOT_PATH_ABSOLUT, ROJO_CONFIG_PATH),
    content: ROJO_CONFIG_CONTENT,
    name: "default.project.json (V16 Reverted)",
  },
];

// --- FUNGSI EKSEKUSI MISI ---
async function runMission() {
  logger.info(`🚀 [KURIR MISI] Memulai: ${MISI}`);

  try {
    // --- FASE 1: Tulis Ulang Rojo Config ---
    for (const file of FILES_TO_WRITE) {
      logger.startSpinner(`Mengembalikan: ${file.name}...`);
      await writeFile(file.path, file.content);
      logger.succeedSpinner(`File ${file.name} berhasil dikembalikan.`, file.path);
    }

    // --- LAPORAN AKHIR ---
    logger.success("\n✅ [KURIR MISI] Misi Revert Rojo Selesai!");
    logger.info(
      "'default.project.json' dikembalikan ke versi V16 ($className)."
    );
    logger.info(
      "Coba 'rojo serve' lagi. Harusnya TIDAK ADA error Rojo."
    );
    logger.info(
      "Setelah itu, 'Play' dan kita lihat apakah output muncul (setelah fix V12 & V15)."
    );
  } catch (error) {
    logger.failSpinner("Misi GAGAL. Menghentikan proses...");
    logger.error(`❌ [ERROR DETAIL]: ${error.message}`);
  }
}

// --- JALANKAN MISI ---
runMission();