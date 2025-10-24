export class ProjectAnalyzer {
  constructor() {
    this.thresholds = {
      excellent: { files: 50, modules: 10, score: 150 },
      good: { files: 20, modules: 5, score: 100 },
      fair: { files: 10, modules: 2, score: 50 }
    };
  }

  analyzeHealth(data) {
    const { stats, modules } = data;
    
    const totalModules = modules.client.length + modules.server.length;
    const score = (stats.totalFiles * 2) + (totalModules * 10);
    
    let health = 'PERLU PERBAIKAN';
    let emoji = '⚠️';
    let message = 'Struktur masih minimal';
    
    if (score >= this.thresholds.excellent.score) {
      health = 'LUAR BIASA';
      emoji = '🏆';
      message = 'Proyek terstruktur baik dan kaya fitur';
    } else if (score >= this.thresholds.good.score) {
      health = 'BAGUS';
      emoji = '✅';
      message = 'Fondasi solid, masih bisa dikembangkan';
    } else if (score >= this.thresholds.fair.score) {
      health = 'CUKUP';
      emoji = '⚠️';
      message = 'Struktur dasar sudah ada';
    }
    
    return {
      score,
      health,
      emoji,
      message
    };
  }

  generateRecommendations(data, mode) {
    const recommendations = [];
    const { stats, modules } = data;
    
    if (stats.totalFiles < 10) {
      recommendations.push('📝 Tambah file Lua untuk kembangkan fungsionalitas');
    }
    
    if (modules.client.length === 0) {
      recommendations.push('💤 Buat modul sisi klien untuk UI/UX');
    }
    
    if (modules.server.length === 0) {
      recommendations.push('🖥️ Tambah modul sisi server untuk logika game');
    }
    
    if (mode === 'quick') {
      recommendations.push('🔎 Jalankan Audit Mendalam untuk analisis komprehensif');
    }
    
    if (recommendations.length === 0) {
      recommendations.push('🎉 Tidak ada masalah besar! Pertahankan, bro!');
    }
    
    return recommendations;
  }
}
