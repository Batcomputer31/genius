# === cstring.ps1 ===
$dot = "."
$trigger = "CLONE"
$encoded = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($dot + $trigger))
Set-Content -Path "C:\EQ\hidden.trigger" -Value $encoded
