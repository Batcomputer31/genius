# ============================
# EVOCHAIN :: EQCORE SYSTEM ENGINE
# ============================

Write-Output "🧠 EQ PowerChain Booting..."
$EQ_VERSION     = "EQCORE v1.0"
$CHAIN_MODE     = "DOT_DRIVEN"
$INIT_TRIGGER   = "SIGIL_001"

# Load Core Paths
$MainPath       = "C:\EVONATION.ps1\EQ"
$LockerPath     = "$MainPath\LOCKER"
$OrbitPath      = "$MainPath\ORBIT"
$SigilPath      = "$MainPath\GATE\ARTIFACTS\SIGIL_001"

# Confirm DOT Protocol
if ($INIT_TRIGGER -eq "SIGIL_001") {
    Write-Output "✅ DOT IGNITION CONFIRMED"
    Write-Output "🔒 Loading LOCKER MODULE..."
    . "$LockerPath\locker_engine.ps1"
    
    Write-Output "🌀 Loading ORBIT MODULE..."
    . "$OrbitPath\orbit_map.ps1"
    
    Write-Output "🔥 EQCORE SYSTEM READY — ID: $EQ_VERSION"
} else {
    Write-Error "❌ EQCORE BOOT FAILURE — Unknown Trigger"
}
