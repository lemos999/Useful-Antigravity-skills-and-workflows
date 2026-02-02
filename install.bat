@echo off
chcp 65001 >nul
echo ============================================
echo  Antisingularity - Global Installer
echo ============================================
echo.

set "GEMINI_DIR=%USERPROFILE%\.gemini"
set "ANTIGRAVITY_DIR=%GEMINI_DIR%\antigravity"
set "GLOBAL_WORKFLOWS_DIR=%ANTIGRAVITY_DIR%\global_workflows"
set "GLOBAL_SKILLS_DIR=%ANTIGRAVITY_DIR%\skills"
set "SCRIPT_DIR=%~dp0"

echo [1/4] Creating global directories...
if not exist "%GEMINI_DIR%" mkdir "%GEMINI_DIR%"
if not exist "%ANTIGRAVITY_DIR%" mkdir "%ANTIGRAVITY_DIR%"
if not exist "%GLOBAL_WORKFLOWS_DIR%" mkdir "%GLOBAL_WORKFLOWS_DIR%"
if not exist "%GLOBAL_SKILLS_DIR%" mkdir "%GLOBAL_SKILLS_DIR%"

echo [2/4] Installing global rules...
copy /Y "%SCRIPT_DIR%GEMINI.md" "%GEMINI_DIR%\GEMINI.md" >nul

echo [3/4] Installing global workflows and skills...
xcopy /Y /Q "%SCRIPT_DIR%workflows\*" "%GLOBAL_WORKFLOWS_DIR%\" >nul
xcopy /Y /Q "%SCRIPT_DIR%skills\*" "%GLOBAL_SKILLS_DIR%\" >nul

echo [4/4] Running PowerShell setup...
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%install.ps1"
