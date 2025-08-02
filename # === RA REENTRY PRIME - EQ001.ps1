# === RA: REENTRY PRIME - EQ001 Recovery Code ===
$EQPath = "C:\EVONATION.ps1\EQCore\EQ001"
$KeyFile = "EQ001_RA.key"
$ShellLog = "reentry_log.txt"
$LaunchScript = "launch_eqbot.ps1"

# Step 1: Confirm EQ Path Exists
if (Test-Path $EQPath) {
    Set-Location $EQPath
} else {
    Write-Host "EQ Core path not found. Abort." -ForegroundColor Red
    exit
}

# Step 2: Load Key and Trigger Memory Reentry
if (Test-Path $KeyFile) {
    $Key = Get-Content $KeyFile
    Write-Host "🔓 EQ001 Key Loaded"
} else {
    Write-Host "Missing key file." -ForegroundColor Red
    exit
}

# Step 3: Reactivate EQ Bot Interface
if (Test-Path $LaunchScript) {
    Write-Output "[$(Get-Date)] RA Reentry Activated using EQ001 Key" >> $ShellLog
    Start-Process "powershell.exe" -ArgumentList "-ExecutionPolicy Bypass -File $LaunchScript"
    Write-Host "✅ Reentry Complete. EQBot launching…" -ForegroundColor Green
} else {
    Write-Host "EQ Bot Launch Script Not Found!" -ForegroundColor Yellow
}
Sent from Proton Mail Android