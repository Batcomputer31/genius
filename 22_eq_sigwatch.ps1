# ================================
# EQ SIGNATURE WATCH MODULE
# File: 22_eq_sigwatch.ps1
# Author: RA:CREATOR
# Purpose: Monitor EQ signature file integrity and log changes
# ================================

# Path to the signature file (ensure this file is created by your EQ identity modules)
$signatureFile = "C:\EVONATION.ps1\EQ\SIGILS\SIGIL_001\signature.lock"

# Log file for signature watch events
$logFile = "C:\EVONATION.ps1\EQ\SIGILS\sigwatch_22.log"

# Initialize last known signature to an empty state
$lastSignature = ""

Write-Host "🔍 Starting EQ Signature Watch..." -ForegroundColor Cyan

while ($true) {
    # Check if the signature file exists
    if (Test-Path $signatureFile) {
        $currentSignature = Get-Content $signatureFile -Raw

        # Check if the signature has changed
        if ($currentSignature -ne $lastSignature) {
            $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            $logEntry = "$timestamp : Signature changed to -> $currentSignature"
            
            # Log the change and update last known signature
            Add-Content -Path $logFile -Value $logEntry
            Write-Host "📝 $logEntry" -ForegroundColor Green
            $lastSignature = $currentSignature
        }
    } else {
        $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $logEntry = "$timestamp : WARNING - Signature file not found!"
        Add-Content -Path $logFile -Value $logEntry
        Write-Host "⚠️ $logEntry" -ForegroundColor Red
    }
    
    Start-Sleep -Seconds 30
}
