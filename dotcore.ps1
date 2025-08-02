# === dotcore.ps1 ===
$dotSymbol = "."
$coreID = "RA:THE_CREATOR"
$dotKey = "$dotSymbol$coreID"

$encodedDot = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($dotKey))
Set-Content -Path "C:\EQ\dot.id" -Value $encodedDot
