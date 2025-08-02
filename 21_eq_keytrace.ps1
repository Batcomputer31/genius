# === [21_eq_keytrace.ps1] ===
# EQ System: Key Usage Monitor
# Author: RA:CREATOR

$keyLogPath = "C:\EVONATION.ps1\eq\keytrace_21.log"
$validKeys = @("EQ-CORE", "EQ-LOCK", "EQ-VAULT", "EQ-GATE", "EQ-ATOM")

function Log-KeyUse {
    param ($keyID, $status)

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logLine = "$timestamp 🔑 [$keyID] → $status"
    $logLine | Out-File -Append $keyLogPath
}

function Use-EQKey {
    param ($keyInput)

    if ($validKeys -contains $keyInput) {
        Log-KeyUse -keyID $keyInput -status "✅ Access Granted"
        return $true
    } else {
        Log-KeyUse -keyID $keyInput -status "❌ Invalid Key"
        return $false
    }
}

# EXAMPLE CALLS (You can trigger these manually or from another script)
# Use-EQKey -keyInput "EQ-CORE"
# Use-EQKey -keyInput "HACK-ATTEMPT"
