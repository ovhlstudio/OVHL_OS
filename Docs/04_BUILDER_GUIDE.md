# 🏗️ 04_BUILDER_GUIDE.md - Panduan Visual Membangun Dunia

> **Project:** Omniverse Highland - Multi-Game Engine  
> **Dokumen:** Panduan Builder untuk Non-Koder  
> **Versi:** 1.0.0  
> **Founder:** Hanif Saifudin  
> **Dibuat:** 2024-12-19 21:30:00  
> **Status:** AKTIF & SIAP UNTUK BUILDER  

---

## 🎯 SELAMAT DATANG, BUILDERS!

### 🧭 Filosofi Panduan
**"Kamu arsiteknya - kami yang urus mesinnya!"** Panduan ini dibuat untuk **non-koder** (kamu yang nggak ngoding) yang mau bikin dunia game keren pake tools visual OVHL.

### 🎪 Apa yang BISA Kamu Lakukan:
- ✅ Desain dan bangun dunia game
- ✅ Taruh zona interaktif dan titik spawn  
- ✅ Atur mekanik game lewat tools visual
- ✅ Tes dan ubah-ubah game tanpa ngoding
- ✅ Bikin game komplit pakai modul yang sudah jadi

### 🚫 Apa yang NGGAK Perlu Kamu Lakukan:
- ❌ Nulis kode Lua sama sekali
- ❌ Ngedit file `.lua`
- ❌ Paham konsep pemrograman
- ❌ Nyentuh sistem OVHL Core

---

## 🚀 MEMULAI - KILAT 5 MENIT

### 📋 Checklist Persiapan
```bash
1. 🎯 Buka Roblox Studio
2. 🗂️ Load Template Project OVHL
3. 🛠️ Aktifkan Builder Tools (View → OVHL Builder Panel)
4. 🎮 Masuk ke Mode Build (F8)
5. 🏗️ Mulai Membangun!
```

### 🎯 Pengaturan Pertama Kali
1. **Buka Template OVHL**
    - File → Open from File
    - Pilih `OVHL_Builder_Template.rbxl`

2. **Aktifkan Panel Builder**
    - View → Toolbars → OVHL Builder Tools
    - Atau tekan `Ctrl+Shift+B`

3. **Masuk Mode Build**
    - Tekan `F8` atau klik "Build Mode" di Panel OVHL
    - Dunia game jadi bisa diedit dengan panduan visual

---

## 🎨 TOOLS BUILDER VISUAL

### 🏗️ PENJELASAN PANEL BUILDER OVHL
```
PANEL BUILDER OVHL (Ctrl+Shift+B)
├── 🎯 ZONE PAINTER (Pelukis Zona)
│   ├── Zona Dealer
│   ├── Zona Perusahaan  
│   ├── Zona Spawn
│   └── Zona Tujuan Misi
├── 🎪 SPAWN EDITOR (Editor Titik Spawn)
│   ├── Titik Spawn NPC
│   ├── Titik Spawn Kendaraan
│   └── Titik Spawn Item
├── ⚙️ CONFIG MANAGER (Manajer Konfigurasi)
│   ├── Pengaturan Game
│   ├── Keseimbangan Ekonomi
│   └── Aturan Dunia
└── 🧪 TESTING TOOLS (Tools untuk Tes)
    ├── Tes Cepat
    ├── Cek Performa
    └── Visualisasi Zona
```

### 🎯 ZONE PAINTER TOOL (Pelukis Zona)

#### Membuat Zona Pertamamu
1. **Pilih Tipe Zona**
    - Klik "Zone Painter" di Panel OVHL
    - Pilih tipe zona (Dealer, Perusahaan, Spawn, dll.)

2. **Lukis di Terrain**
    - Klik dan geser (drag) untuk membuat area zona
    - Zona akan muncul dengan garis berwarna
    - Beda warna untuk beda tipe zona

3. **Atur Properti Zona**
    - Pilih zona yang sudah dibuat
    - Buka panel Properties (F4)
    - Atur atribut khusus zona (misal: nama dealer)

#### Tipe Zona & Warnanya
| Tipe Zona | Warna | Kegunaan | Atribut Wajib |
|-----------|-------|---------|---------------------|
| **DealerZone** | 🟦 Biru | Toko kendaraan/item | `DealerName` |
| **CompanyZone**| 🟩 Hijau | Pendaftaran kerja | `CompanyID` |
| **SpawnZone** | 🟨 Kuning | Tempat muncul NPC/Player | `SpawnWeight` |
| **MissionZone**| 🟪 Ungu | Target misi/quest | `MissionType` |
| **RestrictedZone**| 🟥 Merah | Area terlarang | `RestrictionLevel` |

### 🎪 SPAWN EDITOR TOOL (Editor Titik Spawn)

#### Menaruh Titik Spawn
1. **Buka Spawn Editor**
    - Klik "Spawn Editor" di Panel OVHL
    - Pilih tipe spawn (NPC, Kendaraan, Item)

2. **Taruh Titik Spawn**
    - Klik di mana saja di dalam dunia game untuk menaruh spawner
    - Atur kepadatan (density) pakai slider
    - Atur bobot (weight) spawn secara visual

3. **Atur Perilaku Spawn**
    - Pilih titik spawn
    - Atur waktu respawn, batas jumlah
    - Tentukan kondisi spawn (misal: hanya malam hari)

#### Contoh Konfigurasi Spawn
```lua
-- Contoh Spawn NPC (Diatur lewat Tools Visual)
{
    spawn_type = "npc_passenger",
    spawn_weight = 2.5,       -- Makin tinggi = makin sering muncul
    respawn_time = 60,        -- Detik antar respawn
    max_active = 10,          -- Maksimal NPC di area ini
    conditions = {
        time_of_day = "day",  -- "day" (siang), "night" (malam), "any" (bebas)
        weather = "clear"     -- "clear" (cerah), "rain" (hujan), "any" (bebas)
    }
}
```

---

## 🏷️ SISTEM TAG - SAHABAT BUILDER

### 🎯 Apa itu Tag?
**Tag** adalah label yang kamu tempel ke Part (objek) di duniamu. OVHL akan otomatis mendeteksinya dan membuat area itu berfungsi.

### 📋 REFERENSI CEPAT TAG YANG TERSEDIA

#### 🚗 TAG KENDARAAN & DEALER
| Tag | Kegunaan | Atribut Wajib | Contoh |
|-----|---------|---------------------|---------|
| **DealerZone** | Toko kendaraan | `DealerName` | "Premium Motors" |
| **VehicleSpawn** | Tempat spawn kendaraan player | `VehicleType` | "motorcycle" |
| **GarageZone** | Penyimpanan kendaraan | `GarageCapacity` | 5 |

#### 🏢 TAG PERUSAHAAN & PEKERJAAN  
| Tag | Kegunaan | Atribut Wajib | Contoh |
|-----|---------|---------------------|---------|
| **CompanyZone** | Pendaftaran kerja | `CompanyID` | "gojek" |
| **WorkStation** | Aktivitas kerja | `WorkType` | "delivery" |
| **PaycheckZone** | Pengambilan gaji | `PayInterval` | 3600 (1 jam) |

#### 🎯 TAG MISI & QUEST
| Tag | Kegunaan | Atribut Wajib | Contoh |
|-----|---------|---------------------|---------|
| **MissionDestination** | Lokasi antar barang | `DestinationType` | "restaurant" |
| **QuestGiverZone** | NPC pemberi quest | `QuestType` | "delivery" |
| **ObjectiveZone** | Target misi | `ObjectiveID` | "collect_package" |

#### 👥 TAG NPC & SPAWN
| Tag | Kegunaan | Atribut Wajib | Contoh |
|-----|---------|---------------------|---------|
| **SpawnZone_Mall** | Spawn NPC di mall | `SpawnWeight` | 2.0 |
| **SpawnZone_Residential** | Spawn di area rumah | `SpawnWeight` | 1.5 |
| **NPCSpawn_Pedestrian** | NPC pejalan kaki | `NPCType` | "pedestrian" |

---

## 🛠️ CONTOH MEMBANGUN (LANGKAH DEMI LANGKAH)

### 🏪 MEMBANGUN DEALER KENDARAAN
```
1. 🎯 BUAT ZONA DEALER
    ├── Buka Zone Painter → DealerZone
    ├── Lukis area zona warna biru
    └── Atur DealerName = "City Motors"

2. 🚗 TAMBAH SPAWN KENDARAAN
    ├── Buka Spawn Editor → VehicleSpawn
    ├── Taruh titik spawn di dalam zona
    └── Atur VehicleType = "motorcycle"

3. ⚙️ ATUR HARGA
    ├── Buka Config Manager → Economy
    ├── Atur harga kendaraan
    └── Atur opsi pembayaran

4. 🧪 TES DEALER
    ├── Masuk Mode Tes (F9)
    ├── Coba beli kendaraan
    └── Pastikan lokasi spawn benar
```

### 🏢 MEMBANGUN KANTOR PERUSAHAAN
```
1. 🎯 BUAT ZONA PERUSAHAAN
    ├── Zone Painter → CompanyZone (Hijau)
    ├── Lukis area kantor
    └── Atur CompanyID = "gojek"

2. 👥 TAMBAH STASIUN KERJA
    ├── Zone Painter → WorkStation
    ├── Taruh di dalam zona perusahaan
    └── Atur WorkType = "delivery"

3. 💰 ATUR SISTEM GAJIAN
    ├── Zone Painter → PaycheckZone
    ├── Taruh di area ruang istirahat
    └── Atur PayInterval = 3600

4. 🧪 TES SISTEM KERJA
    ├── Masuk Mode Tes (F9)
    ├── Daftar kerja
    ├── Selesaikan tugas kerja
    └── Ambil gaji
```

### 🏙️ MEMBANGUN DISTRIK KOTA
```
1. 🎯 RENCANAKAN TATA LETAK DISTRIK
    ├── Area perumahan (Spawn Kuning)
    ├── Area komersial (Dealer Biru)
    ├── Area industri (Perusahaan Hijau)
    └── Ruang publik (Misi Ungu)

2. 🏗️ LUKIS ZONA-ZONA
    ├── Pakai Zone Painter untuk tiap tipe area
    ├── Sesuaikan ukuran berdasarkan kepadatan populasi
    └── Atur atribut yang sesuai

3. 👥 ISI DENGAN NPC
    ├── Pakai Spawn Editor untuk penempatan NPC
    ├── Atur bobot spawn untuk kepadatan lalu lintas
    └── Atur tipe perilaku NPC

4. 🎯 TAMBAH MISI & AKTIVITAS
    ├── Taruh zona MissionDestination
    ├── Siapkan area QuestGiver
    └── Atur lokasi objektif
```

---

## ⚙️ CONFIGURATION MANAGER (Manajer Konfigurasi)

### 🎮 KONFIGURASI PENGATURAN GAME
```lua
-- Atur lewat Config Manager Visual (Nggak perlu ngoding!)
{
    game_settings = {
        game_name = "Kota Keren Saya",
        starting_cash = 1000,
        max_players = 50,
        day_night_cycle = true,
        weather_system = true
    },
    
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
    
    world_rules = {
        traffic_density = "medium",  -- rendah, sedang, tinggi
        police_strictness = 0.5,     -- 0.0 sampai 1.0
        civilian_aggression = 0.2    -- 0.0 sampai 1.0
    }
}
```

### 🔧 MENGEDIT KONFIGURASI REAL-TIME
1. **Buka Config Manager**
    - Klik "Config Manager" di Panel OVHL
    - Navigasi lewat kategori

2. **Edit Nilai**
    - Pakai slider untuk angka
    - Pakai dropdown untuk pilihan
    - Pakai kolom teks untuk nama/deskripsi

3. **Terapkan Perubahan**
    - Klik "Apply" (Terapkan) untuk tes perubahan
    - Perubahan terjadi instan (nggak perlu restart!)
    - Pakai "Revert" (Kembalikan) jika ada yang rusak

---

## 🧪 TOOLS TES & DEBUGGING

### 🎯 SUITE TES UNTUK BUILDER
```bash
TOOLS TES OVHL:
├── 🎮 TES CEPAT (F9)
│   ├── Masuk dari sudut pandang player
│   ├── Tes semua elemen interaktif
│   └── Cek pemicu (trigger) zona
├── 📊 CEK PERFORMA
│   ├── Pantau FPS di area berbeda
│   ├── Cek penggunaan memori
│   └── Cari zona yang bikin lag
├── 👁️ VISUALISASI ZONA
│   ├── Lihat semua zona yang aktif
│   ├── Cek batasan zona
│   └── Pastikan tag sudah benar
└── 🐛 DEBUG OVERLAY
    ├── Tampilkan info spawn NPC
    ├── Tampilkan status misi
    └── Lacak interaksi player
```

### 🎯 CHECKLIST PENGETESAN
```lua
-- Jalankan checklist ini sebelum publish
TEST_CHECKLIST = {
    zones = {
        "Semua zona punya tag yang benar",
        "Atribut zona sudah di-set dengan benar",
        "Tidak ada zona tumpang tindih (tipe sama)",
        "Zona bisa diakses oleh player"
    },
    
    spawns = {
        "NPC muncul di lokasi yang benar",
        "Bobot spawn terasa seimbang",
        "Tidak ada titik spawn di dalam objek",
        "Waktu respawn sudah pas"
    },
    
    gameplay = {
        "Semua misi bisa diselesaikan",
        "Ekonomi terasa seimbang",
        "Tidak ada bug yang merusak game",
        "Performa lancar di mana-mana"
    }
}
```

---

## 🎨 TEKNIK MEMBANGUN TINGKAT LANJUT

### 🏗️ MENUMPUK ZONA UNTUK PERILAKU KOMPLEKS
```
Contoh: Gedung Serba Guna
─────────────────────────────────────
Lantai Dasar: CompanyZone (Hijau)
├── CompanyID = "gojek"
├── WorkType = "delivery"
└── PaycheckZone di dalamnya

Lantai Dua: MissionDestination (Ungu)
├── DestinationType = "office"
└── MissionType = "package_delivery"

Atap: SpawnZone (Kuning)
├── SpawnType = "helicopter"
└── SpawnWeight = 0.5 (spawn langka)
```

### 🎯 MENGGUNAKAN ATRIBUT UNTUK KUSTOMISASI
```lua
-- DealerZone dengan atribut kustom
{
    DealerName = "Luxury Auto",
    -- Pilihan kendaraan kustom
    AvailableVehicles = {"sports_car", "luxury_sedan", "suv"},
    -- Jam buka
    OpenTime = 8,    -- 8 PAGI
    CloseTime = 22,  -- 10 MALAM
    -- Fitur spesial
    TestDriveAllowed = true,
    TradeInBonus = 0.1   -- Bonus 10%
}

-- MissionDestination dengan elemen cerita
{
    DestinationType = "restaurant",
    StoryImportance = "high",  -- mempengaruhi frekuensi misi
    RequiredLevel = 5,         -- syarat level player
    SpecialReward = "recipe"   -- tipe hadiah unik
}
```

### 🌆 PRAKTIK TERBAIK TATA KOTA

#### 🏙️ DISTRIBUSI ZONA
```lua
-- Rekomendasi distribusi zona untuk kota seimbang
ZONE_BALANCE = {
    residential = 40,    -- 40% area perumahan
    commercial = 25,     -- 25% toko/dealer
    industrial = 15,     -- 15% perusahaan/kerja
    public = 10,         -- 10% taman/area publik
    special = 10         -- 10% misi/area unik
}
```

#### 🚦 DESAIN ARUS LALU LINTAS
```lua
-- Buat pola lalu lintas realistis
TRAFFIC_DESIGN = {
    main_roads = {
        spawn_weight = 3.0,      -- Lalu lintas NPC tinggi
        npc_types = {"car", "bus", "truck"}
    },
    residential_roads = {
        spawn_weight = 1.5,      -- Lalu lintas sedang
        npc_types = {"car", "pedestrian"}
    },
    highways = {
        spawn_weight = 4.0,      -- Lalu lintas sangat tinggi
        npc_types = {"car", "truck"}, 
        speed_multiplier = 2.0   -- Gerakan lebih cepat
    }
}
```

---

## 🚀 MEMPUBLIKASIKAN KARYAMU

### 📋 CHECKLIST SEBELUM PUBLISH
```bash
1. 🧪 TES MENYELURUH
    ├── Tes semua tipe zona
    ├── Pastikan misi bisa selesai
    ├── Cek metrik performa
    └── Validasi keseimbangan ekonomi

2. 📊 OPTIMASI PERFORMA
    ├── Jalankan tool Cek Performa
    ├── Perbaiki area yang lag
    ├── Optimalkan kepadatan spawn
    └── Pastikan penggunaan memori aman

3. 🎮 REVIEW PENGALAMAN PLAYER
    ├── Coba main sebagai player baru
    ├── Cek tutorial/panduan
    ├── Pastikan progres kesulitan pas
    └── Tes fungsionalitas multiplayer

4. 📝 DOKUMENTASI
    ├── Update deskripsi duniamu
    ├── Catat fitur-fitur spesial
    ├── Buat daftar lokasi penting
    └── Berikan tips memulai
```

### 🎯 LANGKAH-LANGKAH PUBLISH
1. **Tes Final**
    - Gunakan "Tes Menyeluruh" di Tools Tes
    - Perbaiki semua masalah yang ditemukan

2. **Ekspor Dunia**
    - File → Publish to Roblox
    - Tambahkan deskripsi dan thumbnail

3. **Atur Pengaturan Game**
    - Atur batas player
    - Atur perizinan (permissions)
    - Tambahkan tag agar mudah ditemukan

4. **Publish!**
    - Klik "Publish" dan bagikan karyamu!

---

## 🆘 PEMECAHAN MASALAH (TROUBLESHOOTING)

### 🐛 MASALAH UMUM & SOLUSINYA

#### ❌ Zona Tidak Berfungsi
**Masalah**: Player tidak bisa berinteraksi dengan zona  
**Solusi**:  
- Cek ejaan tag zona sudah benar
- Pastikan atribut wajib sudah di-set
- Pastikan zona tidak berada di dalam objek lain

#### ❌ NPC Tidak Muncul  
**Masalah**: Area terasa kosong, tidak ada NPC
**Solusi**:
- Naikkan bobot spawn (spawn weight) di area sepi
- Cek titik spawn tidak terhalang
- Pastikan tipe NPC sudah diatur

#### ❌ Masalah Performa
**Masalah**: Game terasa lag/patah-patah di area tertentu
**Solusi**:
- Kurangi kepadatan spawn di area bermasalah
- Gunakan Cek Performa untuk cari biang keroknya
- Sederhanakan tumpukan zona yang kompleks

#### ❌ Misi Tidak Terpicu
**Masalah**: Player tidak bisa memulai misi
**Solusi**:
- Cek atribut zona misi
- Pastikan kondisi prasyarat (misal: level) terpenuhi
- Tes alur misi dari awal sampai akhir

### 📞 MENCARI BANTUAN

#### 🔧 Kapan Harus Tanya Developer:
- Butuh tipe tag baru
- Butuh mekanik game kustom
- Ada bug teknis di sistem OVHL
- Masalah performa yang tidak bisa kamu perbaiki

#### 🎯 Kapan Harus Cek Panduan Ini:
- Pertanyaan konfigurasi zona
- Masalah keseimbangan spawn
- Praktik terbaik desain dunia
- Tes dan optimasi

#### 💬 Dukungan Komunitas:
- Channel Discord OVHL Builder
- Tutorial video dan contoh
- Template dunia untuk dipelajari
- Pameran karya builder (Builder showcase)

---

## 🎉 KISAH SUKSES & INSPIRASI

### 🏆 APA YANG MEMBUAT DUNIA OVHL HEBAT

#### 🌟 Contoh Hall of Fame
```lua
GREAT_WORLD_EXAMPLES = {
    {
        name = "Metro City Deluxe",
        features = {
            "Pola lalu lintas yang realistis",
            "Zona perumahan/komersial seimbang", 
            "Kesulitan misi yang progresif",
            "Ada rahasia (easter egg) tersembunyi"
        },
        stats = {
            players = "500+ harian",
            rating = "4.9/5.0",
            development_time = "2 minggu"
        }
    },
    
    {
        name = "Countryside Adventures", 
        features = {
            "Dunia terbuka luas dengan medan bervariasi",
            "Tipe misi pedesaan yang unik",
            "Efek cuaca musiman",
            "Perilaku NPC hewan"
        },
        stats = {
            players = "300+ harian", 
            rating = "4.8/5.0",
            development_time = "3 minggu"
        }
    }
}
```

### 🚀 DARI BUILDER MENJADI PENCIPTA DUNIA

#### 💪 Perjalanan Development Kamu
```
MINGGU 1: BELAJAR DASAR
├── Kuasai tool Zone Painter
├── Pahami sistem tag
├── Bangun area tes sederhana
└── Selesaikan kota mini pertama

MINGGU 2: SKILL MENENGAH
├── Buat bangunan multi-zona yang kompleks
├── Seimbangkan ekonomi dan gameplay
├── Terapkan sistem misi
└── Bangun distrik bertema

MINGGU 3: TEKNIK LANJUTAN
├── Desain kota skala besar
├── Buat mode game kustom
├── Optimalkan performa
└── Poles pengalaman player

MINGGU 4: MASTER BUILDER
├── Kembangkan konsep game unik
├── Jadi mentor builder lain
├── Buat template dunia
└── Gabung Program OVHL Builder
```

---

## 🔮 APA SELANJUTNYA UNTUK BUILDER OVHL

### 🎯 FITUR YANG AKAN DATANG
```lua
OVHL_BUILDER_ROADMAP = {
    quarter_1 = {
        "Tools editing terrain canggih",
        "Template bangunan siap pakai", 
        "Pembuat kota otomatis",
        "Editor visual sistem cuaca"
    },
    
    quarter_2 = {
        "Pembuat quest dengan alur cerita",
        "Tools pembuatan cutscene",
        "Integrasi voice-over",
        "Editor perilaku NPC canggih"
    },
    
    quarter_3 = {
        "Manajemen multi-dunia",
        "Berbagi aset antar game",
        "Tools kolaborasi builder",
        "Marketplace untuk aset buatan builder"
    }
}
```

---

**🎯 PESAN PENUTUP:** "Kamu punya kekuatan untuk menciptakan dunia game luar biasa tanpa nulis satu baris kode pun.  
OVHL yang urus kerumitan teknis - kamu fokus pada visi kreatif!"

> **"Builder hebat tidak ngoding - mereka menciptakan pengalaman"** > *- Filosofi Builder OVHL*

---
**END OF 04_BUILDER_GUIDE.md**