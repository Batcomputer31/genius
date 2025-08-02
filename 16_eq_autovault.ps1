# === [16_eq_autovault.ps1] ===
# Purpose: Auto-create secure folders and hide the trigger access point
# Author: RA:CREATOR

$vaultPath = "C:\EVONATION.ps1\vault\"
$triggerFile = "$vaultPath\.hidden.trigger"

# Create vault directory if not exists
If (!(Test-Path $vaultPath)) {
    New-Item -ItemType Directory -Path $vaultPath -Force | Out-Null
}

# Generate base vault files
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$vaultMeta = @{
    Folder = $vaultPath
    Created = $timestamp
    Secure = $true
    Trigger = $triggerFile
}

$vaultMeta | ConvertTo-Json | Out-File "$vaultPath\vault_config_$timestamp.json" -Encoding UTF8

# Create the hidden trigger file
New-Item -ItemType File -Path $triggerFile -Force | Out-Null
(Get-Item $triggerFile).Attributes = 'Hidden'

Write-Output "🔒 Vault initialized and trigger set: $triggerFile"
