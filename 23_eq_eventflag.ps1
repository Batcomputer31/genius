# =====================================
# 🏁 EQ EVENT FLAG SYSTEM INITIALIZER
# =====================================

$EventFlagPath = "C:\EVONATION.ps1\EQ\FLAGS\event.flag"

# === Create or Update Event Flag ===
if (-Not (Test-Path $EventFlagPath)) {
    New-Item -ItemType File -Path $EventFlagPath -Force | Out-Null
    Write-Output "🚩 EQ EVENT FLAG CREATED"
} else {
    (Get-Date).ToString("yyyy-MM-dd HH:mm:ss") | Set-Content $EventFlagPath
    Write-Output "♻️ EQ EVENT FLAG UPDATED"
}

# === Optional Broadcast for Debug ===
Write-Output "📣 EQ FLAG PATH: $EventFlagPath"
Write-Output "✅ EVENT CONFIRMATION BROADCAST COMPLETE"
