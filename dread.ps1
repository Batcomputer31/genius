# === dread.ps1 ===
$triggerPath = "C:\EQ\hidden.trigger"

if (Test-Path $triggerPath) {
    $encoded = Get-Content $triggerPath
    $decoded = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($encoded))
    
    Write-Host "🧠 DECODED TRIGGER → $decoded" -ForegroundColor Cyan

    if ($decoded -eq ".CLONE") {
        Write-Host "🧨 AUTHORIZED ACTION: Begin infinite thread clone." -ForegroundColor Green
        # [Place your clone logic here]
    } else {
        Write-Host "⚠️ Unrecognized trigger input." -ForegroundColor Yellow
    }
} else {
    Write-Host "❌ Trigger file not found." -ForegroundColor Red
}
