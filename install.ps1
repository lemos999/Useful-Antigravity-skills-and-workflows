# Antisingularity - Gemini Antigravity Global Config Installer
# Run: Right-click > Run with PowerShell

$ErrorActionPreference = "Stop"

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Antisingularity - Global Installer" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

$GeminiDir = "$env:USERPROFILE\.gemini"
$AntigravityDir = "$GeminiDir\antigravity"
$GlobalWorkflowsDir = "$AntigravityDir\global_workflows"
$GlobalSkillsDir = "$AntigravityDir\skills"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# 1. 디렉토리 생성
Write-Host "[1/5] Creating global directories..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path $GeminiDir | Out-Null
New-Item -ItemType Directory -Force -Path $AntigravityDir | Out-Null
New-Item -ItemType Directory -Force -Path $GlobalWorkflowsDir | Out-Null
New-Item -ItemType Directory -Force -Path $GlobalSkillsDir | Out-Null

# 2. 글로벌 룰 (GEMINI.md) 복사
Write-Host "[2/5] Installing global rules (GEMINI.md)..." -ForegroundColor Yellow
Copy-Item -Path "$ScriptDir\GEMINI.md" -Destination "$GeminiDir\GEMINI.md" -Force

# 3. 글로벌 워크플로우 복사
Write-Host "[3/5] Installing global workflows..." -ForegroundColor Yellow
Copy-Item -Path "$ScriptDir\workflows\*" -Destination $GlobalWorkflowsDir -Force

# 4. 글로벌 스킬 복사
Write-Host "[4/5] Installing global skills..." -ForegroundColor Yellow
Copy-Item -Path "$ScriptDir\skills\*" -Destination $GlobalSkillsDir -Force

$WorkflowCount = (Get-ChildItem -Path "$ScriptDir\workflows").Count
$SkillCount = (Get-ChildItem -Path "$ScriptDir\skills").Count

# 5. 프로젝트용 init 명령어 등록 (워크스페이스 초기화용)
Write-Host "[5/5] Registering 'antisingularity-init' command for workspace setup..." -ForegroundColor Yellow

$ProfileDir = Split-Path -Parent $PROFILE
if (-not (Test-Path $ProfileDir)) {
    New-Item -ItemType Directory -Force -Path $ProfileDir | Out-Null
}

$InitFunction = @"

# Antisingularity Init Function (Workspace Setup)
function antisingularity-init {
    param([string]`$Path = ".")
    `$TargetAgent = Join-Path `$Path ".agent"
    `$TargetWorkflows = Join-Path `$TargetAgent "workflows"
    `$TargetSkills = Join-Path `$TargetAgent "skills"
    `$TargetGeminiMd = Join-Path `$Path "GEMINI.md"
    `$GlobalGemini = "`$env:USERPROFILE\.gemini"
    `$GlobalAntigravity = "`$GlobalGemini\antigravity"

    # .agent 디렉토리 생성
    if (-not (Test-Path `$TargetAgent)) {
        New-Item -ItemType Directory -Force -Path `$TargetAgent | Out-Null
    }

    # 워크플로우 심볼릭 링크 (글로벌에서)
    if (Test-Path `$TargetWorkflows) {
        Write-Warning "'workflows' already exists. Skipping..."
    } else {
        try {
            New-Item -ItemType SymbolicLink -Path `$TargetWorkflows -Target "`$GlobalAntigravity\global_workflows" -ErrorAction Stop | Out-Null
            Write-Host "Linked workflows from global" -ForegroundColor Green
        } catch {
            Write-Warning "Failed to create symlink. Copying instead..."
            New-Item -ItemType Directory -Force -Path `$TargetWorkflows | Out-Null
            Copy-Item -Path "`$GlobalAntigravity\global_workflows\*" -Destination `$TargetWorkflows -Force
        }
    }

    # 스킬 심볼릭 링크 (글로벌에서)
    if (Test-Path `$TargetSkills) {
        Write-Warning "'skills' already exists. Skipping..."
    } else {
        try {
            New-Item -ItemType SymbolicLink -Path `$TargetSkills -Target "`$GlobalAntigravity\skills" -ErrorAction Stop | Out-Null
            Write-Host "Linked skills from global" -ForegroundColor Green
        } catch {
            Write-Warning "Failed to create symlink. Copying instead..."
            New-Item -ItemType Directory -Force -Path `$TargetSkills | Out-Null
            Copy-Item -Path "`$GlobalAntigravity\skills\*" -Destination `$TargetSkills -Force
        }
    }

    # GEMINI.md 연결 (글로벌에서 심볼릭 링크)
    if (Test-Path `$TargetGeminiMd) {
        Write-Warning "'GEMINI.md' already exists. Skipping..."
    } else {
        try {
            New-Item -ItemType SymbolicLink -Path `$TargetGeminiMd -Target "`$GlobalGemini\GEMINI.md" -ErrorAction Stop | Out-Null
            Write-Host "Linked GEMINI.md from global" -ForegroundColor Green
        } catch {
            Write-Warning "Failed to create symlink. Copying instead..."
            Copy-Item -Path "`$GlobalGemini\GEMINI.md" -Destination `$TargetGeminiMd -Force
        }
    }

    Write-Host "Successfully initialized Antisingularity workspace in `$Path" -ForegroundColor Green
}
"@

if (Test-Path $PROFILE) {
    $CurrentContent = Get-Content $PROFILE -Raw
    if ($CurrentContent -notlike "*function antisingularity-init*") {
        Add-Content -Path $PROFILE -Value $InitFunction
        Write-Host "Added 'antisingularity-init' to your PowerShell profile." -ForegroundColor Green
    }
    else {
        Write-Host "'antisingularity-init' is already registered in your profile." -ForegroundColor Gray
    }
}
else {
    New-Item -ItemType File -Path $PROFILE -Value $InitFunction -Force | Out-Null
    Write-Host "Created PowerShell profile and added 'antisingularity-init'." -ForegroundColor Green
}

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "  Installation Complete!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "Global Locations:" -ForegroundColor Cyan
Write-Host "  Rules:     $GeminiDir\GEMINI.md" -ForegroundColor White
Write-Host "  Workflows: $GlobalWorkflowsDir" -ForegroundColor White
Write-Host "  Skills:    $GlobalSkillsDir" -ForegroundColor White
Write-Host ""
Write-Host "Total Installed:" -ForegroundColor White
Write-Host "  Workflows: $WorkflowCount" -ForegroundColor White
Write-Host "  Skills:    $SkillCount" -ForegroundColor White
Write-Host ""
Write-Host "IMPORTANT: Global rules/workflows/skills are now active in ALL projects!" -ForegroundColor Yellow
Write-Host ""
Write-Host "Optional - Workspace setup (for project-specific overrides):" -ForegroundColor Cyan
Write-Host "  1. Restart your PowerShell"
Write-Host "  2. Go to any project folder"
Write-Host "  3. Type 'antisingularity-init' to link global config"
Write-Host ""
Write-Host "Available slash commands (globally):" -ForegroundColor Cyan
Write-Host "  /tdd, /plan, /code-review, /e2e, /build-fix, etc."
Write-Host ""
Read-Host "Press Enter to exit"
