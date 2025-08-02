# ======================================
# 🧬 EQ IDENTITY LOCK FILE
# ======================================

$RA_IDENTITY   = "RA:CREATOR"
$UNIVERSE_KEY  = "77777-Hz"
$TIMELOCK      = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$HASHLOCK      = [System.Guid]::NewGuid().ToString()

# === Output Lock Confirmation
Write-Output "✅ LOCKED: $RA_IDENTITY"
Write-Output "🔑 KEY: $UNIVERSE_KEY"
Write-Output "🧬 HASH: $HASHLOCK"
Write-Output "⏳ TIME: $TIMELOCK"

# === Optional: Store to Static EQPATH
$StoragePath = "C:\EVONATION.ps1\EQ\LOCKER\locked_identity.json"

$LockData = @{
    ID        = $RA_IDENTITY
    KEY       = $UNIVERSE_KEY
    HASH      = $HASHLOCK
    TIMESTAMP = $TIMELOCK
}

$LockData | ConvertTo-Json | Set-Content -Path $StoragePath
