# =========================================
# 🧭 PATHLOGIC MODULE: DYNAMIC FILE WALKER
# =========================================

$RootPath = "C:\EVONATION.ps1"
$LogFilePath = "$RootPath\EQ\LOGS\pathlogic_map.txt"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Ensure log directory exists
$logDir = Split-Path $LogFilePath
if (-not (Test-Path $logDir)) {
    New-Item -ItemType Directory -Path $logDir -Force | Out-Null
}

# Begin logging
Add-Content -Path $LogFilePath -Value "`n=== PATH LOGIC EXECUTION ==="
Add-Content -Path $LogFilePath -Value "⏰ Timestamp: $timestamp"
Add-Content -Path $LogFilePath -Value "🔍 Starting Path: $RootPath`n"

# Recursive walk function
function Invoke-PathWalker {
    param (
        [string]$Path
    )

    try {
        Get-ChildItem -Path $Path -Recurse -ErrorAction Stop | ForEach-Object {
            if ($_.PSIsContainer) {
                Add-Content -Path $LogFilePath -Value "📁 DIR: $($_.FullName)"
            } else {
                Add-Content -Path $LogFilePath -Value "📄 FILE: $($_.FullName)"
            }
        }
    } catch {
        Add-Content -Path $LogFilePath -Value "❌ ERROR: Unable to access $Path"
    }
}

# Execute walk
Invoke-PathWalker -Path $RootPath

Write-Host "🧭 PATHLOGIC WALK COMPLETE — Map saved to pathlogic_map.txt" -ForegroundColor Cyan
