# 🎨 03_OVHL_BUILDER_GUIDE.MD - Panduan Visual Membangun Dunia

| 🏛️ **Project** | Omniverse Highland (OVHL)            |
| :------------- | :----------------------------------- |
| 📄 **Dokumen** | Panduan Builder untuk Non-Koder      |
| 🏷️ **Versi**   | **3.0.0 (Revisi V10.2 Compliance)**  |
| 👑 **Founder** | Hanif Saifudin                       |
| 🗓️ **Update**  | 25 Oktober 2025                      |
| 🚨 **Status**  | **AKTIF (Sesuai Konstitusi \`00\`)** |

---

## 👋 1.0 SELAMAT DATANG, BUILDERS!

### 1.1 💡 Filosofi Panduan

**"Kamu arsiteknya - kami yang urus mesinnya!"** (Ref: `01_SPEC 1.1`).
Panduan ini dibuat untuk **non-koder** (kamu yang nggak ngoding) yang mau bikin dunia game keren pake tools visual OVHL (Ref: `01_SPEC 3.3`).

### 1.2 ✅ Apa yang BISA Kamu Lakukan:

- ✅ Desain dan bangun dunia game
- ✅ Taruh zona interaktif dan titik spawn
- ✅ Atur mekanik game lewat tools visual
- ✅ Tes dan ubah-ubah game tanpa ngoding
- ✅ Bikin game komplit pakai modul yang sudah jadi

### 1.3 ❌ Apa yang NGGAK Perlu Kamu Lakukan:

- ❌ Nulis kode Lua sama sekali
- ❌ Ngedit file `.lua`
- ❌ Paham konsep pemrograman
- ❌ Ngoding di dalam `src/core/` (Itu tugas Core-Dev, Ref: `00_CONST 1.1.3`)

---

## 🚀 2.0 MEMULAI - KILAT 5 MENIT

### 2.1 📋 Checklist Persiapan

```bash
1. 🎯 Buka Roblox Studio
2. 🗂️ Load Template Project OVHL
3. 🛠️ Aktifkan Builder Tools (View → OVHL Builder Panel)
4. 🎮 Masuk ke Mode Build (F8)
5. 🏗️ Mulai Membangun!
```

### 2.2 ⚙️ Pengaturan Pertama Kali

1.  **Buka Template OVHL**

    - File → Open from File
    - Pilih `OVHL_Builder_Template.rbxl`

2.  **Aktifkan Panel Builder**

    - View → Toolbars → OVHL Builder Tools
    - Atau tekan `Ctrl+Shift+B`

3.  **Masuk Mode Build**
    - Tekan `F8` atau klik "Build Mode" di Panel OVHL
    - Dunia game jadi bisa diedit dengan panduan visual

---

## 🛠️ 3.0 TOOLS BUILDER VISUAL

### 3.1 🖥️ Penjelasan Panel Builder OVHL

```bash
PANEL BUILDER OVHL (Ctrl+Shift+B)
├── 🎯 ZONE PAINTER (Pelukis Zona)
│   ├── 🔵 Zona Dealer
│   ├── 🟢 Zona Perusahaan
│   ├── 🟡 Zona Spawn
│   └── 🟣 Zona Tujuan Misi
├── 🎪 SPAWN EDITOR (Editor Titik Spawn)
│   ├── 👤 Titik Spawn NPC
│   ├── 🚗 Titik Spawn Kendaraan
│   └── 📦 Titik Spawn Item
├── ⚙️ CONFIG MANAGER (Manajer Konfigurasi)
│   ├── 🎮 Pengaturan Game
│   ├── 💰 Keseimbangan Ekonomi
│   └── 🌍 Aturan Dunia
└── 🧪 TESTING TOOLS (Tools untuk Tes)
    ├── ⚡ Tes Cepat
    ├── 📊 Cek Performa
    └── 👁️ Visualisasi Zona
```

> ⚠️ **(NOTA DINAMIS (PENTING!): Daftar ini adalah CONTOH.)** > _Opsi yang Anda lihat di sini (misal: "Zona Dealer" atau "Titik Spawn NPC") BUKAN hardcode dari OS. Opsi ini muncul secara **dinamis** karena Modul (seperti `DealerModule` atau `NPCModule`) sedang aktif dan **mendaftarkannya** ke OS. Jika modul dimatikan, opsi ini akan hilang dari Tools Anda._

### 3.2 🖌️ Zone Painter Tool (Pelukis Zona)

#### 3.2.1 Membuat Zona Pertamamu

1.  **Pilih Tipe Zona**

    - Klik "Zone Painter" di Panel OVHL
    - Pilih tipe zona dari dropdown (Dealer, Perusahaan, Spawn, dll.)

2.  **Lukis di Terrain**

    - Klik dan geser (drag) di atas terrain atau part untuk membuat area zona.
    - Zona akan muncul sebagai visualisasi (misal: garis berwarna).
    - Beda warna biasanya menandakan beda tipe zona (dikonfigurasi oleh Modul).

3.  **Atur Properti Zona**
    - Pilih zona yang sudah dibuat (visualisasi atau part di Explorer).
    - Buka panel Properties Roblox Studio (biasanya `Alt+P` atau `F4`).
    - Cari bagian "Attributes".
    - Atur atribut khusus zona di situ (misal: `DealerName` = "Toko Mobil Keren"). Nama atribut dan tipenya ditentukan oleh Modul yang mendaftarkan zona ini.

#### 3.2.2 Tipe Zona & Warnanya (Contoh)

| Tipe Zona (Tag)  | Warna (Contoh) | Kegunaan (Contoh)        | Atribut Wajib (Contoh)      | Modul Pendaftar (Contoh)   |
| :--------------- | :------------- | :----------------------- | :-------------------------- | :------------------------- |
| `DealerZone`     | 🟦 Biru        | Toko kendaraan/item      | `DealerName` (String)       | `DealerModule`             |
| `CompanyZone`    | 🟩 Hijau       | Pendaftaran kerja        | `CompanyID` (String)        | `CompanyModule`            |
| `SpawnZone`      | 🟨 Kuning      | Tempat muncul NPC/Player | `SpawnWeight` (Number)      | `NPCModule`/`PlayerModule` |
| `MissionZone`    | 🟪 Ungu        | Target misi/quest        | `MissionType` (String)      | `MissionModule`            |
| `RestrictedZone` | 🟥 Merah       | Area terlarang           | `RestrictionLevel` (Number) | `SecurityModule`           |

> ⚠️ **(NOTA DINAMIS (PENTING!): Daftar ini adalah CONTOH.)** > _Tipe Zona (Tag), Warna, Atribut, dan Modul Pendaftar ini muncul karena Modul yang relevan sedang **aktif** di Game Profile Anda. Jika Anda membuat Modul baru (misal: `FishingModule`), Anda bisa mendaftarkan Tag "FishingZone" baru dengan warna dan atributnya sendiri, dan itu akan **otomatis muncul** di tool ini._

### 3.3 📍 Spawn Editor Tool (Editor Titik Spawn)

_(Prinsipnya sama seperti 3.2. Opsi tipe spawn di dalam Spawn Editor juga bersifat dinamis, didaftarkan oleh modul seperti `NPCModule`, `VehicleModule`, `ItemModule`)_

#### 3.3.1 Menaruh Titik Spawn

1.  **Buka Spawn Editor**

    - Klik "Spawn Editor" di Panel OVHL.
    - Pilih tipe spawn dari dropdown (NPC Penumpang, Mobil Sedan, Kotak Amunisi, dll.).

2.  **Taruh Titik Spawn**

    - Klik di mana saja di dalam dunia game (biasanya di atas terrain atau part) untuk menaruh visualisasi spawner.
    - Beberapa tools mungkin memungkinkan Anda "melukis" area spawn.
    - Atur properti seperti kepadatan (density) atau frekuensi (weight) menggunakan slider atau input di panel tool.

3.  **Atur Perilaku Spawn (via Atribut)**
    - Pilih titik/area spawn yang sudah dibuat.
    - Buka panel Properties Roblox Studio (`Alt+P`/`F4`).
    - Cari bagian "Attributes".
    - Atur atribut seperti `RespawnTime` (Number, detik), `MaxActive` (Number, jumlah maks), `SpawnConditionTime` (String, misal: "day", "night", "any"), `SpawnConditionWeather` (String, misal: "clear", "rain", "any"). Nama atribut ini ditentukan oleh Modul yang menangani spawn tersebut.

#### 3.3.2 Contoh Konfigurasi Spawn (Hasil Atribut)

(CATATAN: Ini adalah representasi _data_ dari atribut yang Anda set di Properties, Builder tidak mengetik ini)

```lua
-- Contoh Atribut pada Part Spawner NPC (Diatur lewat Properties Panel)
Attributes = {
    OVHL_SpawnType = "npc_passenger", -- Tipe spawn (didaftarkan NPCModule)
    OVHL_SpawnWeight = 2.5,           -- Bobot/Frekuensi
    OVHL_RespawnTime = 60,            -- Waktu respawn (detik)
    OVHL_MaxActive = 10,              -- Jumlah maks di area
    OVHL_SpawnConditionTime = "day",  -- Kondisi waktu
    OVHL_SpawnConditionWeather = "clear" -- Kondisi cuaca
}
```

---

## 🏷️ 4.0 SISTEM TAG & ATRIBUT - SAHABAT BUILDER

### 4.1 📌 Apa itu Tag & Atribut?

- **Tag:** Label teks sederhana yang ditempel ke Part/Model untuk menandai _tipe_ atau _peran_-nya (Contoh: `DealerZone`, `RoadNode`). Dideteksi otomatis oleh Modul yang mendengarkan.
- **Atribut:** Pasangan _Nama_ dan _Nilai_ (seperti `DealerName` = "Toko Mobil") yang ditempel ke Part/Model untuk menyimpan _data konfigurasi_ spesifik. Diatur lewat panel Properties.

### 4.2 📚 Referensi Cepat Tag & Atribut (Contoh)

> ⚠️ **(NOTA DINAMIS (PENTING!): Daftar ini adalah CONTOH.)** > _Tag dan Atribut ini (misal: `DealerZone`, `DealerName`) BUKAN hardcode dari OS. Mereka hanya akan **berfungsi** jika ada Modul (seperti `DealerModule`) yang sedang aktif, **mendengarkan** Tag tersebut, dan **membaca** Atribut tersebut. Tanpa modul yang relevan, Tag/Atribut ini tidak akan melakukan apa-apa._

#### 4.2.1 🚗 Tag & Atribut Kendaraan & Dealer

| Tag                 | Atribut Utama       | Tipe Nilai               | Kegunaan           | Modul Pendengar (Contoh) |
| :------------------ | :------------------ | :----------------------- | :----------------- | :----------------------- |
| `DealerZone`        | `DealerName`        | String                   | Nama toko          | `DealerModule`           |
| `DealerZone`        | `AvailableVehicles` | String (Comma-separated) | ID Mobil yg dijual | `DealerModule`           |
| `VehicleSpawnPoint` | `VehicleID`         | String                   | ID Mobil yg spawn  | `VehicleModule`          |
| `GarageZone`        | `Capacity`          | Number                   | Maks mobil         | `GarageModule`           |

#### 4.2.2 🏢 Tag & Atribut Perusahaan & Pekerjaan

| Tag            | Atribut Utama | Tipe Nilai | Kegunaan                       | Modul Pendengar (Contoh) |
| :------------- | :------------ | :--------- | :----------------------------- | :----------------------- |
| `CompanyZone`  | `CompanyID`   | String     | ID Perusahaan (gojek, grab)    | `CompanyModule`          |
| `WorkStation`  | `WorkType`    | String     | Jenis kerja (delivery, pickup) | `CompanyModule`          |
| `PaycheckZone` | `PayInterval` | Number     | Detik antar gaji               | `CompanyModule`          |

#### 4.2.3 🎯 Tag & Atribut Misi & Quest

| Tag                  | Atribut Utama     | Tipe Nilai | Kegunaan                         | Modul Pendengar (Contoh) |
| :------------------- | :---------------- | :--------- | :------------------------------- | :----------------------- |
| `MissionDestination` | `DestinationType` | String     | Tipe lokasi (restaurant, office) | `MissionModule`          |
| `QuestGiver`         | `QuestID`         | String     | ID Quest yg diberikan            | `QuestModule`            |
| `ObjectiveArea`      | `ObjectiveID`     | String     | ID Target Misi                   | `MissionModule`          |

#### 4.2.4 👤 Tag & Atribut NPC & Spawn

| Tag         | Atribut Utama | Tipe Nilai               | Kegunaan              | Modul Pendengar (Contoh) |
| :---------- | :------------ | :----------------------- | :-------------------- | :----------------------- |
| `SpawnArea` | `SpawnWeight` | Number                   | Frekuensi spawn       | `NPCModule`              |
| `SpawnArea` | `NPCTypes`    | String (Comma-separated) | Tipe NPC yg spawn     | `NPCModule`              |
| `RoadNode`  | `NextNode`    | Object (Instance)        | Node jalan berikutnya | `TrafficModule`          |

---

## 🏗️ 5.0 CONTOH MEMBANGUN (LANGKAH DEMI LANGKAH)

### 5.1 🚗 Membangun Dealer Kendaraan

1.  **Buat Part / Area:** Buat Part (misal: Blok transparan) yang mencakup area dealer.
2.  **Tambahkan Tag:** Pilih Part, buka panel Properties, klik "+ Add Tag", ketik `DealerZone` (Ref: `4.2.1`).
3.  **Tambahkan Atribut:** Masih di Properties, klik "+ Add Attribute", beri nama `DealerName`, tipe `String`, isi nilainya (misal: "City Motors"). Tambahkan atribut lain jika perlu (misal: `AvailableVehicles`).
4.  **Tambahkan Titik Spawn (Opsional):** Buat Part kecil di mana mobil akan muncul, beri tag `VehicleSpawnPoint`, tambahkan atribut `VehicleID` (misal: "sedan01").
5.  **Atur Harga (via Config Manager):** Buka Config Manager (Ref: `3.1`), cari bagian Ekonomi (didaftarkan `DealerModule`), atur harga untuk "sedan01".
6.  **Tes:** Masuk Mode Tes (Ref: `7.1`), dekati area `DealerZone`, lihat apakah UI pembelian muncul.

### 5.2 🏢 Membangun Kantor Perusahaan

1.  **Buat Area Kantor:** Buat Part/Model area kantor.
2.  **Tag & Atribut Kantor:** Beri tag `CompanyZone`, tambahkan atribut `CompanyID` (misal: "gojek").
3.  **Buat Stasiun Kerja:** Buat Part di dalam kantor (misal: meja), beri tag `WorkStation`, tambahkan atribut `WorkType` (misal: "delivery").
4.  **Buat Area Gaji:** Buat Part lain (misal: ATM), beri tag `PaycheckZone`, tambahkan atribut `PayInterval` (misal: 3600).
5.  **Atur Gaji (via Config Manager):** Buka Config Manager (Ref: `6.1`), cari bagian Gaji Pekerjaan (didaftarkan `CompanyModule`), atur gaji untuk "delivery".
6.  **Tes:** Masuk Mode Tes (Ref: `7.1`), dekati `CompanyZone` untuk daftar, dekati `WorkStation` untuk kerja, dekati `PaycheckZone` untuk ambil gaji.

### 5.3 🏙️ Membangun Distrik Kota

1.  **Rencanakan Tata Letak:** Tentukan area perumahan, komersial, industri.
2.  **Buat Zona Utama:** Gunakan `Zone Painter` (Ref: `3.2`) atau buat Part besar dan beri tag (`SpawnArea`, `CompanyZone`, dll.) sesuai fungsi area.
3.  **Atur Atribut Area:** Set atribut di zona/area utama (misal: `SpawnWeight` tinggi di pusat kota, rendah di pinggiran; `NPCTypes` berbeda untuk tiap area).
4.  **Isi Detail:** Tambahkan Part/Model bangunan, jalan, dll.
5.  **Tambahkan Interaksi:** Taruh `DealerZone`, `MissionDestination`, `QuestGiver` (dengan Tag & Atribut yang benar) di lokasi yang sesuai.
6.  **Atur Lalu Lintas (Jika ada `TrafficModule`):** Taruh Part kecil di sepanjang jalan, beri tag `RoadNode`, hubungkan dengan atribut `NextNode`.
7.  **Tes & Iterasi:** Masuk Mode Tes (Ref: `7.1`), lihat kepadatan NPC, coba interaksi, cek performa.

---

## ⚙️ 6.0 CONFIGURATION MANAGER (Manajer Konfigurasi)

### 6.1 🎮 Konfigurasi Pengaturan Game

> ⚠️ **(NOTA DINAMIS (PENTING!): Daftar ini adalah CONTOH.)** > _Opsi konfigurasi ini (misal: "economy.vehicle_prices") BUKAN hardcode dari OS. Opsi ini muncul secara **dinamis** karena Modul (seperti `DealerModule`) mendaftarkan **skema konfigurasinya** ke OS. GUI ini akan otomatis bertambah/berkurang sesuai modul yang aktif._

(CATATAN: Diatur lewat Config Manager Visual, Builder tidak mengetik ini)

```lua
-- Contoh data konfigurasi yang di-load oleh OS (hasil gabungan dari banyak modul)
{
    -- Didaftarkan oleh Core OS atau Modul Global
    game_settings = {
        game_name = "Kota Keren Saya",
        starting_cash = 1000,
        max_players = 50,
        day_night_cycle = true,
        weather_system = true
    },

    -- Didaftarkan oleh DealerModule & CompanyModule
    economy = {
        vehicle_prices = {
            motorcycle = 5000,
            car = 15000,
            truck = 30000
        },
        job_salaries = {
            delivery = 100,
            taxi = 150,
            trucker = 200
        }
    },

    -- Didaftarkan oleh TrafficModule
    world_rules = {
        traffic_density = "medium",   -- rendah, sedang, tinggi
        police_strictness = 0.5,      -- 0.0 sampai 1.0
        civilian_aggression = 0.2     -- 0.0 sampai 1.0
    },

    -- Mungkin didaftarkan oleh FuelModule (jika ada)
    -- fuel_system = {
    --    price_per_liter = 10
    -- }
}
```

### 6.2 ✏️ Mengedit Konfigurasi Real-Time

1.  **Buka Config Manager**

    - Klik "Config Manager" di Panel Builder OVHL (Ref: `3.1`).
    - Navigasi lewat kategori yang muncul (misal: "Game Settings", "Economy", "World Rules"). Kategori ini dibuat berdasarkan skema yang didaftarkan Modul.

2.  **Edit Nilai**

    - Gunakan elemen UI yang otomatis dibuat (slider, dropdown, text box) sesuai tipe data yang didaftarkan Modul.
    - Beberapa nilai mungkin memerlukan restart server (akan ada notifikasi).

3.  **Terapkan Perubahan**
    - Klik "Apply" atau "Save".
    - Perubahan akan langsung dibaca oleh Modul yang relevan (jika Modul mendukung _hot-config_).
    - Gunakan "Revert" jika ingin membatalkan perubahan sesi ini.

---

## 🧪 7.0 TOOLS TES & DEBUGGING

### 7.1 🔬 Suite Tes untuk Builder

```bash
TOOLS TES OVHL (Akses via Panel Builder, Ref: 3.1):
├── 🎮 TES CEPAT (F9 / Tombol Play di Studio)
│   ├── Masuk ke game sebagai player biasa.
│   ├── Langsung coba semua interaksi (beli, kerja, misi).
│   └── Cek apakah zona/tag berfungsi sesuai harapan.
├── 📊 CEK PERFORMA (Tombol di Panel / Command Chat)
│   ├── Aktifkan overlay FPS (Frames Per Second).
│   ├── Pantau penggunaan memori (Script/Total).
│   └── Identifikasi area/objek yang menyebabkan lag.
├── 👁️ VISUALISASI ZONA (Tombol di Panel)
│   ├── Tampilkan semua area Tag Zone secara visual (warna/batas).
│   ├── Bantu cek apakah zona sudah benar posisinya.
│   └── Pastikan tidak ada zona tumpang tindih yang tidak diinginkan.
└── 🐛 DEBUG OVERLAY (Tombol di Panel / Command Chat)
    ├── Tampilkan info real-time NPC (state, tujuan).
    ├── Tampilkan status misi aktif player.
    └── Lacak event interaksi player (masuk zona, klik tombol).
```

### 7.2 📋 Checklist Pengetesan Mandiri

```lua
-- Jalankan checklist ini secara berkala saat membangun
TEST_CHECKLIST_BUILDER = {
    zones_tags_attributes = {
        "Apakah semua Part/Area penting sudah diberi Tag yang benar? (Ref: 4.0)",
        "Apakah semua Atribut wajib sudah diisi nilainya? (Ref: 4.0)",
        "Apakah nilai Atribut masuk akal (tidak typo, angka tidak negatif)?",
        "Apakah visualisasi Zona (jika ada) sudah pas ukurannya?"
    },

    spawns = {
        "Apakah NPC/Kendaraan muncul di tempat yang benar? (Ref: 3.3)",
        "Apakah frekuensi (Weight) spawn terasa pas (tidak terlalu ramai/sepi)?",
        "Apakah ada spawner yang 'nyangkut' di dalam objek/tembok?",
        "Apakah kondisi spawn (waktu/cuaca) berfungsi?"
    },

    gameplay_flow = {
        "Apakah alur interaksi utama (beli, kerja, misi) bisa diselesaikan dari awal sampai akhir?",
        "Apakah ada langkah yang membingungkan atau tidak jelas?",
        "Apakah ekonomi terasa seimbang (harga vs gaji)? (Ref: 6.0)",
        "Apakah ada bug visual (UI salah, objek aneh)?"
    },

    performance = {
       "Apakah FPS stabil (di atas 30-45 FPS) di semua area?",
       "Apakah ada area tertentu yang terasa sangat lag?",
       "Apakah game terasa responsif?"
    }
}
```

---

## 🎓 8.0 TEKNIK MEMBANGUN TINGKAT LANJUT

### 8.1 📚 Menumpuk & Menggabungkan Fungsi via Tag/Atribut

```
Contoh: Gedung Kantor + Kafe
─────────────────────────────────────
Part Gedung Utama:
  Tag: CompanyZone (Ref: 4.2.2)
  Atribut: CompanyID = "startup_keren"

Part Meja Resepsionis (di dalam Gedung):
  Tag: WorkStation (Ref: 4.2.2)
  Atribut: WorkType = "receptionist"

Part Pintu Masuk Kafe (di Lantai Dasar Gedung):
  Tag: MissionDestination (Ref: 4.2.3)
  Atribut: DestinationType = "cafe"

Part Mesin Kopi (di dalam Kafe):
  Tag: QuestGiver (Ref: 4.2.3)
  Atribut: QuestID = "kopi_pagi"
```

_Satu gedung bisa melayani banyak fungsi hanya dengan menempelkan Tag & Atribut yang benar pada Part yang berbeda._

### 8.2 💎 Kustomisasi Perilaku via Atribut Tambahan

(CATATAN: Atribut tambahan ini harus _dibaca_ dan _diinterpretasikan_ oleh Modul yang relevan agar berfungsi)

```lua
-- Part DealerZone dengan Atribut Kustom
Attributes = {
    DealerName = "Luxury Auto",
    AvailableVehicles = "sports_car,luxury_sedan,suv",
    -- Atribut Kustom (harus didukung DealerModule):
    OpenHour = 8,    -- Jam buka (angka 0-23)
    CloseHour = 22,   -- Jam tutup
    RequiresVIP = true -- Hanya bisa diakses member VIP? (boolean)
}

-- Part MissionDestination dengan Atribut Kustom
Attributes = {
    DestinationType = "restaurant",
    -- Atribut Kustom (harus didukung MissionModule):
    StoryImportance = "high",  -- Mempengaruhi frekuensi misi ke sini
    RequiredLevel = 5,         -- Syarat level player untuk misi ke sini
    SpecialReward = "recipe_burger" -- ID hadiah unik jika misi selesai di sini
}
```

_Anda bisa menambahkan Atribut kustom apa saja. Agar berfungsi, Developer harus mengupdate Modul terkait untuk membaca dan menggunakan nilai Atribut tersebut._

### 8.3 🏙️ Praktik Terbaik Tata Kota

#### 8.3.1 Distribusi Zona Fungsional

- **Kelompokkan Fungsi:** Tempatkan `DealerZone` di area komersial, `CompanyZone` di area industri/perkantoran, `SpawnArea` perumahan di distrik residensial.
- **Alur Player:** Pikirkan bagaimana player bergerak. Tempatkan `QuestGiver` dekat `SpawnArea` awal, `MissionDestination` di lokasi yang logis.
- **Kepadatan:** Gunakan `SpawnWeight` pada `SpawnArea` untuk mengontrol kepadatan NPC/Player di area berbeda (pusat kota lebih padat).

#### 8.3.2 Desain Arus Lalu Lintas (jika menggunakan `TrafficModule`)

- **Gunakan `RoadNode`:** Tandai titik-titik penting di jalan (persimpangan, belokan) dengan Part bertag `RoadNode`.
- **Hubungkan Node:** Gunakan atribut `NextNode` (tipe Instance/Object) untuk menghubungkan satu `RoadNode` ke node berikutnya, membentuk jalur.
- **Atribut Jalan:** Tambahkan atribut pada `RoadNode` atau segmen jalan (jika jalan adalah Part) untuk mengontrol perilaku NPC di jalan itu (misal: `SpeedLimit` (Number), `LaneCount` (Number), `IsHighway` (Boolean)).

---

## 📤 9.0 MEMPUBLIKASIKAN KARYAMU

### 9.1 📋 Checklist Sebelum Publish

```bash
1. 🧪 TES MENYELURUH (Ref: 7.2)
    ├── Coba semua alur gameplay utama.
    ├── Tes di kondisi ekstrem (banyak player, inventori penuh).
    ├── Minta teman (atau player lain) untuk tes & beri masukan.

2. 📊 OPTIMASI PERFORMA (Ref: 7.1)
    ├── Gunakan Cek Performa, cari area lag.
    ├── Kurangi jumlah Part/NPC di area lag jika perlu.
    ├── Pastikan tidak ada script error di console (F9).

3. 🎮 REVIEW PENGALAMAN PLAYER
    ├── Apakah tujuan game jelas?
    ├── Apakah ada tutorial atau panduan awal?
    ├── Apakah game terasa adil dan menyenangkan?
    ├── Apakah ada cukup konten untuk dimainkan?

4. 📝 FINALISASI INFO GAME
    ├── Tulis deskripsi game yang menarik.
    ├── Buat thumbnail dan ikon yang bagus.
    ├── Siapkan daftar update / fitur masa depan (jika ada).
```

### 9.2 🚀 Langkah-langkah Publish

1.  **Tes Final & Perbaikan:** Jalankan Checklist `9.1`. Perbaiki semua isu.
2.  **Simpan & Publish ke Roblox:**
    - `File` → `Save to Roblox As...` (jika game baru) atau `Publish to Roblox As...` (jika update).
    - Isi detail game (Nama, Deskripsi, Genre).
    - Atur Pengaturan Akses (Siapa yang bisa main? Gratis/Berbayar?).
3.  **Konfigurasi Game di Website Roblox:**
    - Buka halaman game di website Roblox.
    - Masuk ke "Configure Experience".
    - Atur detail tambahan (Ikon, Thumbnail, Genre, Server Size, dll).
    - Aktifkan game (`Public`).
4.  **Promosikan!** Bagikan link game ke teman atau komunitas!

---

## 🚑 10.0 PEMECAHAN MASALAH (TROUBLESHOOTING)

### 10.1 🛠️ Masalah Umum & Solusinya

#### 10.1.1 🚫 Zona / Tag / Atribut Tidak Berfungsi

- **Masalah**: Interaksi tidak terjadi, UI tidak muncul, NPC tidak spawn.
- **Solusi**:
  - **Cek Ejaan TAG:** Pastikan 100% sama persis (case-sensitive!) dengan yang diharapkan Modul (Ref: `4.2`).
  - **Cek NAMA & TIPE ATRIBUT:** Pastikan nama atribut (`DealerName`, `SpawnWeight`) dan tipe datanya (`String`, `Number`, `Boolean`) sesuai dengan yang dibaca Modul.
  - **Cek NILAI ATRIBUT:** Pastikan nilainya valid (angka tidak negatif, string tidak kosong jika wajib).
  - **Pastikan MODUL AKTIF:** Tanyakan Developer apakah Modul yang relevan (misal: `DealerModule`) sudah diaktifkan di Game Profile saat ini. Tag/Atribut tidak berfungsi tanpa Modul pendengar.
  - **Cek Console (F9):** Lihat apakah ada pesan error dari Modul terkait.

#### 10.1.2 👤 NPC / Objek Spawn Aneh

- **Masalah**: NPC muncul di dalam tembok, mobil spawn terbalik.
- **Solusi**:
  - **Periksa Posisi Spawner:** Pastikan Part Spawner (atau titik di Spawn Editor) tidak terlalu dekat/di dalam objek lain. Beri ruang yang cukup di atasnya.
  - **Periksa Orientasi Spawner:** Pastikan bagian depan (Front) Part Spawner menghadap ke arah yang benar.
  - **Cek Ukuran Objek Spawn:** Pastikan ada cukup ruang untuk objek yang akan di-spawn.

#### 10.1.3 📉 Performa Lag / Patah-patah

- **Masalah**: Game terasa berat di area tertentu.
- **Solusi**:
  - **Kurangi Kepadatan:** Turunkan `SpawnWeight` atau `MaxActive` pada `SpawnArea` / Spawner di area tersebut (Ref: `3.3.1`).
  - **Sederhanakan Geometri:** Kurangi jumlah Part yang terlalu detail atau tumpang tindih di area lag. Gunakan Union atau Mesh jika memungkinkan.
  - **Optimalkan Visual:** Kurangi penggunaan Material kompleks, texture besar, atau efek partikel berlebihan.
  - **Gunakan StreamingEnabled:** (Pengaturan Game) Jika dunia sangat besar, aktifkan ini agar Roblox hanya me-load bagian dunia di sekitar player.
  - **Laporkan ke Developer:** Jika lag disebabkan oleh script Modul, laporkan temuan Anda.

### 10.2 🆘 Mencari Bantuan

#### 10.2.1 Kapan Harus Tanya Developer:

- Butuh **Tag / Atribut / Tipe Zona baru** yang belum ada (Ref: `4.0`).
- Butuh **mekanik gameplay kustom** yang tidak bisa dicapai dengan Tag/Atribut standar.
- Menemukan **bug** yang jelas berasal dari **script Modul** (bukan salah konfigurasi Builder).
- Masalah **performa parah** yang tidak bisa diatasi dengan optimasi Builder (Ref: `10.1.3`).
- Perlu **mengaktifkan/menonaktifkan Modul** di Game Profile.

#### 10.2.2 Kapan Harus Cek Panduan Ini:

- Lupa cara pakai **Tools Visual** (Zone Painter, Spawn Editor) (Ref: `3.0`).
- Lupa **nama Tag atau Atribut** yang benar (Ref: `4.0`).
- Butuh **contoh konfigurasi** Tag/Atribut (Ref: `4.0`, `5.0`).
- Mencari **solusi masalah umum** (Ref: `10.1`).
- Butuh **praktik terbaik** desain (Ref: `8.3`).

#### 10.2.3 Dukungan Komunitas:

- **Channel Discord OVHL Builder:** Tempat bertanya sesama Builder & Developer.
- **Forum / Wiki OVHL (jika ada):** Sumber dokumentasi tambahan & tutorial.
- **Showcase / Pameran Karya:** Lihat contoh dunia yang dibuat Builder lain untuk inspirasi.

---

## 🏆 11.0 KISAH SUKSES & INSPIRASI

_(Bagian ini akan diisi nanti berdasarkan karya Builder)_

### 11.1 🌟 Apa yang Membuat Dunia OVHL Hebat

_(Contoh target kualitas)_

- Desain dunia yang imersif dan detail.
- Gameplay loop yang menarik dan seimbang.
- Penggunaan Tag & Atribut yang kreatif untuk menciptakan interaksi unik.
- Performa yang lancar meskipun dunia kompleks.

#### 11.1.1 Contoh Hall of Fame (Target)

```lua
-- Akan diisi nanti
```

### 11.2 📈 Dari Builder Menjadi Pencipta Dunia

#### 11.2.1 Perjalanan Development Kamu (Contoh)

```
FASE 1: 👶 PEMULA
├── Fokus belajar Tools Visual (Ref: 3.0)
├── Coba buat area kecil dengan 1-2 fungsi (misal: Toko Roti) (Ref: 5.0)
└── Banyak bertanya & bereksperimen.

FASE 2: 🧑‍🎓 MENENGAH
├── Mulai merancang distrik/kota kecil (Ref: 5.3)
├── Menggabungkan beberapa fungsi Modul (Toko + Misi + NPC) (Ref: 8.1)
└── Mulai memperhatikan keseimbangan & alur gameplay.

FASE 3: 👨‍🏫 MAHIR
├── Merancang dunia skala besar dengan tata kota kompleks (Ref: 8.3)
├── Menggunakan Atribut kustom untuk detail unik (Ref: 8.2)
└── Fokus pada optimasi performa & pengalaman player (Ref: 9.1)

FASE 4: 👑 MASTER BUILDER
├── Menciptakan konsep gameplay original menggunakan sistem OVHL.
├── Berkontribusi ide fitur baru untuk Tools/Modul.
└── Membantu Builder lain & berbagi template/aset.
```

---

## 🗺️ 12.0 APA SELANJUTNYA UNTUK BUILDER OVHL

### 12.1 🛣️ Fitur Tools Builder yang Akan Datang (Contoh Roadmap)

```lua
OVHL_BUILDER_ROADMAP = {
    Q1_2026 = {
        "Visual Path Editor (untuk NPC/Traffic)",
        "Prefab Placer (menempatkan grup objek siap pakai)",
        "Terrain Painter V2 (lebih banyak brush & material)"
    },
    Q2_2026 = {
        "Visual Quest Editor (membuat alur misi tanpa script)",
        "Cutscene Editor Sederhana",
        "Integrasi Marketplace Aset Builder"
    },
    Q3_2026 = {
        "Real-time Collaboration Mode (multi-builder edit bareng)",
        "Versioning & Rollback Dunia"
    }
}
```

---

**🎯 PESAN PENUTUP:** "Kamu punya kekuatan untuk menciptakan dunia game luar biasa tanpa nulis satu baris kode pun. OVHL yang urus kerumitan teknis - kamu fokus pada visi kreatif!"

> **"Builder hebat tidak ngoding - mereka menciptakan pengalaman"** > _- Filosofi Builder OVHL_

---

> "The world is but a canvas to the imagination." – Henry David Thoreau

---

**END OF DOCUMENT**

## _Copyright © 2025 - Omniverse Highland Studio_
