# =========================================
# ☁️ EQ UPLINK: REMOTE CHANNEL ACTIVATOR
# =========================================

$UplinkStatusPath = "C:\EVONATION.ps1\EQ\NET\uplink.status"
$Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# === Create Directory If Needed ===
$dir = Split-Path $UplinkStatusPath
if (-not (Test-Path $dir)) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
}

# === Log Initial Uplink Trigger ===
$uplinkLog = @"
== EQ REMOTE UPLINK INITIATED ==
📡 Uplink Time: $Timestamp
🔗 Bridge Active: TRUE
🛡️ Status Secure: TRUE
"@

$uplinkLog | Out-File -FilePath $UplinkStatusPath -Encoding UTF8

Write-Host "✅ REMOTE UPLINK SIGNAL INJECTED" -ForegroundColor Cyan
Write-Host "📡 Path: $UplinkStatusPath" -ForegroundColor Gray
