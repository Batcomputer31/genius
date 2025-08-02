# =========================================
# ⚡ CLONEPULSE MODULE: REPLICATION TRIGGER
# =========================================

$ClonePulsePath = "C:\EVONATION.ps1\EQ\CLONE\pulse.trigger"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# === Ensure Target Directory Exists ===
$cloneDir = Split-Path $ClonePulsePath
if (-not (Test-Path $cloneDir)) {
    New-Item -ItemType Directory -Path $cloneDir -Force | Out-Null
}

# === Emit Clone Pulse Signal ===
$cloneSignal = @"
== EQ CLONE PULSE EMITTED ==
📅 Time: $timestamp
🧬 Signal Strength: MAX
🔁 Replication State: READY
🔒 Auth Code: EQ_25_INIT
"@

$cloneSignal | Out-File -FilePath $ClonePulsePath -Encoding UTF8

Write-Host "🧬 CLONE PULSE EMITTED SUCCESSFULLY" -ForegroundColor Green
Write-Host "📂 Location: $ClonePulsePath" -ForegroundColor DarkGray
