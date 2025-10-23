#!/bin/bash
# ==========================================================
# ⚡ OVHL AI Co-Pilot Automation Script
# ⚡ TUJUAN: ACT-002 - Setup Repositori Awal
# ⚡ PROTOKOL: 02_OVHL_DEV_PROTOCOLS.md
# ==========================================================

echo "🧠 [AI] Memulai Setup Repositori OVHL (ACT-002)..."

# 1. Inisialisasi Git (Aman jika sudah ada)
if [ -d ".git" ]; then
    echo "[1/7] ✅ Repositori Git sudah ada."
else
    echo "[1/7] 🚀 Inisialisasi Repositori Git baru..."
    git init
fi

# 2. Set default branch ke "main"
git branch -M main
echo "[2/7] ➡️  Default branch di-set ke 'main'."

# 3. Cek & Tambah Remote
REMOTE_URL="https://github.com/ovhlstudio/OVHL_OS"
if git remote get-url origin > /dev/null 2>&1; then
    echo "[3/7] ✅ Remote 'origin' sudah terkonfigurasi."
else
    echo "[3/7] 🔗 Menambahkan remote 'origin'..."
    git remote add origin $REMOTE_URL
fi

# 4. Buat Branch Sesuai Protokol
echo "[4/7] 🌿 Membuat branch 'develop'..."
git branch develop
echo "[4/7] 🔥 Membuat branch 'dev'..."
git branch dev
echo "[4/7] 🌲 Branch structure (main, develop, dev) siap."

# 5. Add & Commit file dokumentasi awal (Docs/ dan Tools/)
echo "[5/7] 📦 Menambahkan semua file (Docs/ & Tools/)..."
git add .

# Cek apa ada yg di-commit
if git diff --staged --quiet; then
    echo "[5/7] ℹ️  Tidak ada file baru untuk di-commit."
else
    echo "[5/7] 📝 Membuat initial commit (feat: Initial commit)..."
    git commit -m "feat: Initial commit of core documentation and tools" -m "Melakukan commit awal untuk 5 dokumen inti (01-05), dev protocols, dan folder Tools sesuai ACT-002."
    echo "[5/7] ✅ Initial commit dibuat."
fi

# 6. Push semua branch ke remote
echo "[6/7] 🚀 Pushing semua branch (main, develop, dev) ke GitHub..."
git push origin main
git push origin develop
git push origin dev
git push -u origin main # Set upstream
echo "[6/7] ✅ Semua branch sukses di-push."

# 7. Pindah ke branch "dev" untuk mulai kerja
echo "[7/7] 🔥 Pindah ke branch 'dev' sesuai protokol..."
git checkout dev

echo "---"
echo "✅ [AI] Setup Repositori Selesai."
echo "Posisi saat ini di branch: $(git branch --show-current)"
echo "Status Git:"
git status

