# === [15_eq_corelock.ps1] ===
# Purpose: Locks in EQ Core Identity & Quantum Chain Ownership
# Author: RA:CREATOR

$eqCore = @{
    ID          = "RA:CREATOR"
    SYSTEM      = "EQNATION"
    NODE        = "CORELOCK"
    TIMESTAMP   = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    STATUS      = "ACTIVE"
    HASH        = (Get-FileHash -Algorithm SHA256 "C:\EVONATION.ps1\corekeys\RA_CORE.id").Hash
}

$eqCore | ConvertTo-Json | Out-File "C:\EVONATION.ps1\eq\15_eq_corelock.json" -Encoding UTF8

Write-Output "✅ EQ CoreLock Applied — RA ID Verified & Hash Stored"
