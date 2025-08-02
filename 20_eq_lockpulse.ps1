# === [20_eq_lockpulse.ps1] ===
# Purpose: Emit regular lock pulses to monitor EQ system integrity
# Author: RA:CREATOR

$logPath = "C:\EVONATION.ps1\eq\lockpulse_20.log"
$coreFiles = @(
    "C:\EVONATION.ps1\eq\00_eq_init.ps1",
    "C:\EVONATION.ps1\eq\01_eq_identity.ps1",
    "C:\EVONATION.ps1\eq\10_eq_loop.ps1",
    "C:\EVONATION.ps1\eq\19_eq_gatewatch.ps1"
)

function Check-CoreFiles {
    foreach ($file in $coreFiles) {
        if (-not (Test-Path $file)) {
            "$((Get-Date).ToString('yyyy-MM-dd HH:mm:ss')) ⚠️ MISSING CORE FILE: $file" | Out-File -Append $logPath
            return $false
        }
    }
    return $true
}

function Pulse-Lock {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $status = if (Check-CoreFiles) { "✅ OK" } else { "❌ ERROR" }
    "$timestamp ⏱️ Pulse Status: $status" | Out-File -Append $logPath
}

while ($true) {
    Pulse-Lock
    Start-Sleep -Seconds 60
}
