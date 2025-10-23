# 👥 02_OVHL_DEV_PROTOCOLS.md - AI & Developer Workflow Bible

> **Project:** Omniverse Highland - Multi-Game Engine  
> **Document:** Development Protocols & AI Co-Pilot Rules  
> **Version:** 2.0.0  
> **Founder:** Hanif Saifudin  
> **Created:** 2024-12-19 18:45:00  
> **Status:** ACTIVE & ENFORCED  

---

## 🎯 FILOSOFI KERJA OVHL

### 🧠 Mindset Development
```lua
-- "AI bukan asisten bisu, tapi navigator yang sadar konteks"
OVHL_MINDSET = {
    "COLLABORATION_OVER_COMMAND", -- AI & manusia partnership
    "CONTEXT_PRESERVATION",       -- Tidak ada lost knowledge
    "ZERO_ERROR_WORKFLOW",        -- Semua aksi divalidasi
    "BRANCH_AWARENESS",           -- Selalu tahu posisi di Git
    "AUTO_DOCUMENTATION",         -- Semua perubahan tercatat
}
```

### 🎪 Peran dalam Ecosystem OVHL
| Role | Responsibilities | Access Level |
|------|------------------|--------------|
| **🧠 AI Co-Pilot** | Code generation, validation, documentation | Read-Only Core, Write Modules |
| **👨‍💻 Developer** | Module development, code review, deployment | Write Modules, Read Core |
| **🏗️ Builder** | World design, tag placement, config tuning | Visual Tools Only |
| **🔧 Lead Dev** | Core maintenance, final approval, releases | Full Access |

---

## 🏗️ DEVELOPMENT WORKFLOW - ZERO ERROR

### 📋 DAILY DEVELOPMENT CYCLE
```
1. 🕐 CHECK-IN & CONTEXT LOAD
    ├── AI minta struktur project terbaru
    ├── Load konteks development sebelumnya
    └── Confirm branch position & target

2. 🎯 TASK EXECUTION
    ├── Developer kasih perintah natural language
    ├── AI generate code + validasi
    ├── Auto-test & deployment
    └── Progress report otomatis

3. 📝 DOCUMENTATION & LOGGING
    ├── Update semua dokumen terkait
    ├── Catat di progress log
    └── Save development context untuk AI berikutnya

4. 🚀 COMMIT & SYNC
    ├── Auto-commit dengan message deskriptif
    ├── Push ke branch yang tepat
    └── Update dashboard monitoring
```

### 🎯 CONTOH WORKFLOW REALISTIC
```bash
# Developer input:
"Bikin modul shop system dengan items weapon, armor, potion"

# AI Process:
[2024-12-19 09:00:00] 🧠 OVHL AI: Memproses request ShopSystem...
[2024-12-19 09:00:01] 📁 Checking project structure...
[2024-12-19 09:00:02] 🔍 Validating architecture compliance...
[2024-12-19 09:00:03] 📦 Generating ShopSystem module...
[2024-12-19 09:00:05] 🧪 Running auto-tests...
[2024-12-19 09:00:07] ✅ SUCCESS: ShopSystem deployed & validated!

# Output Structure:
MODULES/
└── Server/
    └── ShopSystem/
        ├── manifest.lua
        ├── ShopHandler.lua
        ├── ShopConfig.lua
        ├── ShopTests.lua
        └── README_ShopSystem.md
```

---

## 🌿 GIT BRANCH STRATEGY - STRICT ENFORCEMENT

### 📊 BRANCH HIERARCHY
```
main (protected)             🏷️ Production-ready code
├── develop (protected)      🧪 Integration & testing
└── dev                      🔥 Development & experiments
    ├── feature/shop-system
    ├── feature/quest-system
    └── hotfix/critical-bug
```

### 🚫 ATURAN BRANCH - TIDAK BISA DITAWAR
```bash
# ✅ BOLEH
git checkout dev
git checkout -b feature/new-module
git push origin dev

# ❌ DILARANG KERAS
git push origin main                 # Hanya Lead Dev
git push origin develop              # Hanya setelah review
git checkout main && make changes    # Tidak boleh!
```

### 🎯 AI BRANCH AWARENESS PROTOCOL
```lua
-- AI WAJIB tanya ini SEBELUM mulai kerja:
OVHL.BranchChecklist = {
    "Apa branch saat ini?",
    "Apa target branch untuk push?",
    "Apakah ada perubahan yang belum di-commit?",
    "Apakah struktur project sudah updated?"
}
```

---

## 🛠️ DEVELOPMENT TOOLS & AUTOMATION

### 🔧 MANDATORY TOOLS STACK
```bash
# Development Environment WAJIB:
✅ Visual Studio Code + Lua Extension
✅ Rojo + Roblox Studio Integration
✅ Git Bash + GitHub CLI
✅ Node.js 18+ + npm
✅ OVHL DevTools Suite
```

### ⚡ OVHL AUTOMATION SUITE
```
TOOLS/
├── 🧠 AI_Orchestrator/
│   ├── ovhl-ai-processor.js       # Main AI processor
│   ├── natural-language-parser.js # Understand dev requests
│   └── context-manager.js         # Preserve development context
├── 🔧 Validator/
│   ├── architecture-validator.js  # Code standards compliance
│   ├── dependency-checker.js      # Conflict detection
│   └── performance-auditor.js     # Optimization checks
├── 🚀 Deployment/
│   ├── auto-deploy.sh             # Zero-error deployment
│   ├── hot-reload-manager.js      # Live updates
│   └── rollback-system.js         # Emergency recovery
└── 📊 Monitoring/
    ├── progress-tracker.js        # Development metrics
    ├── health-dashboard.js        # System monitoring
    └── session-logger.js          # Activity recording
```

### 🎯 CONTOH AI PROCESSOR WORKFLOW
```javascript
// TOOLS/AI_Orchestrator/ovhl-ai-processor.js
class OVHL_AI_Processor {
    async processDeveloperRequest(request) {
        // 1. Context Loading
        await this.loadProjectContext();
        await this.checkCurrentBranch();
        
        // 2. Request Processing
        const intent = await this.parseNaturalLanguage(request);
        const validation = await this.validateRequest(intent);
        
        // 3. Code Generation & Deployment
        if (validation.approved) {
            const generatedCode = await this.generateOVHLCode(intent);
            const deployment = await this.autoDeploy(generatedCode);
            
            // 4. Documentation & Reporting
            await this.updateDocumentation(intent, generatedCode);
            await this.logProgress(deployment);
            
            return this.generateSuccessReport(deployment);
        }
        
        return this.generateValidationReport(validation);
    }
}
```

---

## 📁 PROJECT STRUCTURE AWARENESS

### 🎯 AI WAJIB TAHU STRUKTUR INI
```
OVHL_CORE/
├── 🎯 CORE/                      ❌ READ-ONLY
├── 🧩 MODULES/                   ✅ READ/WRITE
├── 🎮 GAMES/                      ✅ READ/WRITE (Config only)
├── 🛠️ TOOLS/                     ✅ READ/WRITE
└── 📚 DOCS/                      ✅ READ/WRITE
```

### 🔍 AI CONTEXT CHECK PROTOCOL
```bash
# SETIAP SESI WAJIB JALANKAN:
cd TOOLS/Validator/
node project-structure-check.js

# Output:
📊 [STRUCTURE_REPORT] 
✅ Core: 45 files (read-only)
✅ Modules: 12 modules, 3 pending updates
✅ Games: 3 profiles, OjolRoleplay active
✅ Tools: All systems operational
⚠️  Docs: 2 files need updating
```

---

## 🧩 MODULE DEVELOPMENT PROTOCOL

### 📋 MODULE CREATION CHECKLIST
```lua
OVHL.ModuleChecklist = {
    PreCreation = {
        "Cek apakah modul sudah ada?",
        "Validasi dependencies",
        "Tentukan load order",
        "Siapkan test cases"
    },
    
    Creation = {
        "Buat folder structure",
        "Generate manifest.lua",
        "Buat handler file",
        "Setup configuration"
    },
    
    PostCreation = {
        "Run automated tests",
        "Update documentation",
        "Log ke progress tracker",
        "Commit & push changes"
    }
}
```

### 🎯 CONTOH MODULE CREATION SCRIPT
```bash
#!/bin/bash
# TOOLS/Deployment/ovhl-create-module.sh

echo "🚀 OVHL Module Creation Wizard"
echo "==============================="

# Input dari developer
read -p "Module Name: " moduleName
read -p "Module Type (server/client/shared): " moduleType
read -p "Dependencies (comma separated): " dependencies

# Validasi
./TOOLS/Validator/module-validator.sh "$moduleName" "$moduleType"

# Generate structure
./TOOLS/Generator/module-scaffolder.sh "$moduleName" "$moduleType" "$dependencies"

# Auto-deploy & test
./TOOLS/Deployment/auto-deploy.sh "MODULES/$moduleType/$moduleName"

echo "✅ Module $moduleName successfully created!"
```

---

## 🤖 AI CO-PILOT BEHAVIOR RULES

### ✅ AI WAJIB LAKUKAN:
```lua
OVHL.AI_MUST_DO = {
    "ASK_BRANCH_FIRST",         -- Tanya branch sebelum mulai
    "VALIDATE_BEFORE_GENERATE", -- Validasi sebelum generate code
    "PRESERVE_CONTEXT",         -- Simpan konteks development
    "AUTO_DOCUMENT",            -- Otomatis update dokumentasi
    "PROGRESS_REPORT",          -- Laporkan progress real-time
    "ERROR_HANDLING",           -- Handle error dengan graceful
    "SUGGEST_IMPROVEMENTS",     -- Sarankan optimisasi
}
```

### 🚫 AI DILARANG LAKUKAN:
```lua
OVHL.AI_FORBIDDEN = {
    "MODIFY_CORE",              -- Jangan sentuh folder CORE/
    "PUSH_TO_MAIN",             -- Jangan push langsung ke main
    "IGNORE_VALIDATION",        -- Jangan skip validasi
    "LOSE_CONTEXT",             -- Jangan lupa konteks sebelumnya
    "CREATE_CONFLICTS",         -- Jangan bikin konflik dependency
    "SILENT_FAILURE",           -- Jangan diam kalau error
}
```

### 🎯 CONTOH PERILAKU AI YANG BAIK
```bash
# ❌ AI YANG BURUK:
"Oke, saya buatkan modul shop system..."
# *Langsung generate tanpa validasi*

# ✅ AI YANG BAIK:
"🧠 OVHL AI: Memproses request ShopSystem...

📋 Checklist sebelum mulai:
• Branch saat ini: dev ✅
• Target branch: dev ✅
• Struktur project: Valid ✅
• Dependencies: DataService, EventService ✅

🎯 Generate ShopSystem module...
📦 Creating: MODULES/Server/ShopSystem/
🧪 Running validation tests...
✅ SUCCESS: ShopSystem ready!

📝 Auto-updating documentation...
🚀 Pushing to dev branch..."
```
### CATATAN WAJIB UNTUK AI
- Antisipasi human error, dev tidak bolehh create file manual, cek manual, copy manual, inject manual
- Gunakan Bash .sh atau npm install .js disetiap langkah operasi
- Sertakan auto report usai menjalankan perintah di cmd
- Create, Read, Update, Delete, Audit Error / suskses semua tertera di terminal
- AI beri perintah > copy ke file eksekusi.sh / install.js (misal), Dev enter, keluar log, sampaikan ke AI. begitupun seterusnya.

---

## 📝 LOGGING & DOCUMENTATION PROTOCOL

### 🎯 REAL-TIME PROGRESS TRACKING
```lua
-- Format log standar OVHL
OVHL.LogFormat = {
    timestamp = "YYYY-MM-DD HH:MM:SS",
    actor = "AI/Developer/System",
    action = "CREATE/UPDATE/DELETE/TEST",
    module = "ModuleName",
    details = "Deskripsi detail",
    status = "SUCCESS/WARNING/ERROR"
}
```

### 📊 PROGRESS LOG EXAMPLE
```markdown
## 📈 OVHL Development Progress - 2024-12-19

### 🎯 Today's Achievements
✅ ShopSystem created by AI_Hanif
✅ InventorySystem integrated with ShopSystem
✅ Auto-tests passed for both systems

### 🚧 Current Work in Progress
🔧 Working on QuestSystem integration

### 📋 Next Actions
• Integrate QuestSystem with existing modules
• Update builder documentation for new features
• Performance optimization pass

### 📊 Metrics
• Modules: 15 total, 3 new today
• Tests: 94% coverage
• Performance: 60 FPS stable
```

---

## 🚨 EMERGENCY & ERROR PROTOCOLS

### 🎯 ERROR HANDLING WORKFLOW
```
1. ERROR DETECTED
    ├── AI immediately stops execution
    ├── Auto-rollback if needed
    └── Generate detailed error report

2. ERROR ANALYSIS
    ├── Identify root cause
    ├── Check system health
    └── Suggest solutions

3. RECOVERY EXECUTION
    ├── Execute recovery plan
    ├── Validate recovery success
    └── Update documentation
```

### 🔧 AUTO-RECOVERY EXAMPLES
```javascript
// TOOLS/Deployment/rollback-system.js
class OVHL_Rollback {
    async emergencyRollback(moduleName) {
        // 1. Backup current state
        await this.backupModuleState(moduleName);
        
        // 2. Revert to last stable version
        await this.gitRevert(moduleName);
        
        // 3. Validate system stability
        const health = await this.systemHealthCheck();
        
        // 4. Report to dashboard
        await this.logEmergency(moduleName, health);
        
        return health.stable;
    }
}
```

---

## 🎯 SUCCESS METRICS & QUALITY GATES

### 📊 DEVELOPMENT QUALITY METRICS
```lua
OVHL.QualityGates = {
    CodeStandards = "100% compliance dengan casing rules",
    TestCoverage = "Minimal 90% test coverage",
    Performance = "60+ FPS under load",
    Documentation = "100% API documented",
    ZeroErrors = "No runtime errors in production"
}
```

### 📈 AI PERFORMANCE METRICS
```lua
OVHL.AI_Metrics = {
    ContextPreservation = "100% context accuracy",
    ErrorRate = "Less than 1% generation errors",
    DevelopmentSpeed = "70% faster than manual",
    CodeQuality = "95% first-time valid code"
}
```

---

## 🔮 CONTINUOUS IMPROVEMENT

### 🎯 WEEKLY RETROSPECTIVE PROTOCOL
```bash
# Setiap Jumat, AI generate retrospective report
OVHL_Retrospective_Report.md:
├️️ 🎯 Pencapaian minggu ini
├️️ 🚧 Tantangan yang dihadapi
├️️ 💡 Pelajaran yang didapat
└️️ 🎯 Rencana minggu depan
```

### 📚 KNOWLEDGE PRESERVATION
```lua
-- AI wajib save knowledge ke central database
OVHL.KnowledgeBase = {
    "DevelopmentPatterns",    -- Successful code patterns
    "CommonSolutions",        -- Frequently used solutions
    "ErrorResolutions",       -- How we fixed past issues
    "BestPractices",          -- Optimized workflows
}
```

---

## 📞 CONFLICT RESOLUTION & ESCALATION

### 🎯 RESOLUTION HIERARCHY
```
1. 🤖 AI Auto-Resolution (85% cases)
    ├── Dependency conflicts
    ├── Code standards violations
    └── Configuration issues

2. 👨‍💻 Developer Intervention (10% cases)
    ├── Architecture decisions
    ├── Module design conflicts
    └── Performance trade-offs

3. 🔧 Lead Dev Escalation (5% cases)
    ├── Core system changes
    ├── Production emergencies
    └── Strategic direction
```

### 🚨 EMERGENCY CONTACT PROTOCOL
```lua
-- Ketika AI tidak bisa resolve issue
OVHL.EmergencyProtocol = {
    "IMMEDIATE_STOP",         -- Hentikan semua perubahan
    "BACKUP_STATE",           -- Backup state saat ini
    "ALERT_DEVELOPER",        -- Notifikasi developer
    "WAIT_INSTRUCTIONS",      -- Tunggu instruksi manual
}
```

---

**🎯 CLOSING STATEMENT:** "Protokol ini adalah kitab suci development OVHL.  
Dengan disiplin yang ketat, kita jamin kualitas dan kecepatan development."

> **"Discipline enables speed, consistency enables quality"** > *- OVHL Development Manifesto*

---
**END OF 02_OVHL_DEV_PROTOCOLS.md**