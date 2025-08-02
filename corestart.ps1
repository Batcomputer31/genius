# ====================================
# EQ CORESTART TRIGGER: SIGIL_001 Injection
# ====================================
. "C:\EVONATION.ps1\EQ\GATE\ARTIFACTS\SIGIL_001\EQ_SIGIL_001.ps1"

# Signal verification output
if ($Trigger -eq "DOT.IGNITION" -and $LockStatus -eq "Immutable") {
    Write-Output "⚡ SIGIL_001 Verified. Ignition Trigger Detected."
    Write-Output "→ Executing EQ PowerChain Initialization Protocol"
    
    # Begin EQ PowerChain logic here
    . "C:\EVONATION.ps1\EQ\CORE\eqcore.ps1"
}
else {
    Write-Error "❌ SIGIL_001 integrity check failed."
}
