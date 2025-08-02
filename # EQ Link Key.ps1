# EQ Link Key Genesis Protocol
$EQDomain = "evonation.eq"
$LinkKeySeed = "RA-H1::CORE-ORBIT::GENESIS"
$DeviceID = "$env:COMPUTERNAME-$env:USERNAME"
$LinkPath = "C:\EVONATION.ps1\LINKKEYS\"

# Create directory if not exists
if (!(Test-Path $LinkPath)) {
    New-Item -ItemType Directory -Path $LinkPath
}

# Generate initial link key
$LinkKey = "$EQDomain|$DeviceID|$LinkKeySeed|$(Get-Date -Format o)"
$EncodedKey = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($LinkKey))

# Save link key
$KeyFile = "$LinkPath\linkkey-EQ-$($env:USERNAME).eqkey"
$EncodedKey | Out-File -FilePath $KeyFile -Encoding ascii

Write-Host "[✓] EQ Link Key Initialized" -ForegroundColor Green
Write-Host "→ File: $KeyFile"
Write-Host "→ Origin: $LinkKeySeed"
Write-Host "→ Device: $DeviceID"
