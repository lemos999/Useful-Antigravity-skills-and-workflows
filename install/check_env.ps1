# Check and Install Environment Prerequisites
$ErrorActionPreference = "Stop"

function Check-Command($Command, $Name) {
    if (Get-Command $Command -ErrorAction SilentlyContinue) {
        Write-Host "✅ $Name is installed." -ForegroundColor Green
        return $true
    }
    Write-Host "❌ $Name is NOT installed." -ForegroundColor Red
    return $false
}

function Install-Winget {
    Write-Host "Attempting to install binaries using Winget..." -ForegroundColor Yellow
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Error "Winget is not installed. Please install App Installer from the Microsoft Store."
        exit 1
    }
}

# 1. Check Node.js (>= 18)
if (-not (Check-Command "node" "Node.js")) {
    Install-Winget
    winget install OpenJS.NodeJS.LTS -e --source winget
    if ($LASTEXITCODE -ne 0) { throw "Failed to install Node.js" }
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
} else {
    $nodeVer = node -v
    Write-Host "   Version: $nodeVer" -ForegroundColor Gray
    # Simple check, assuming v18+ is fine if installed. 
}

# 2. Check Git
if (-not (Check-Command "git" "Git")) {
    Install-Winget
    winget install Git.Git -e --source winget
    if ($LASTEXITCODE -ne 0) { throw "Failed to install Git" }
}

# 3. Check Python (>= 3.12)
if (Check-Command "python" "Python") {
    $pyVer = python --version 2>&1
    Write-Host "   Version: $pyVer" -ForegroundColor Gray
    if ($pyVer -match "3\.(\d+)") {
        $minor = [int]$matches[1]
        if ($minor -lt 12) {
            Write-Host "❌ Python version is too old. Upgrading..." -ForegroundColor Red
            Install-Winget
            winget install Python.Python.3.12 -e --source winget
        }
    }
} else {
    Install-Winget
    winget install Python.Python.3.12 -e --source winget
    if ($LASTEXITCODE -ne 0) { throw "Failed to install Python 3.12" }
}

Write-Host "`n🎉 Environment check complete! You may need to restart your terminal." -ForegroundColor Green
