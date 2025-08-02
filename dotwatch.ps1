# === dotwatch.ps1 ===
$dotPath = "C:\EQ\dot.id"
$lastHash = ""

while ($true) {
    if (Test-Path $dotPath) {
        $current = Get-Content $dotPath -Raw
        $hash = (Get-FileHash $dotPath -Algorithm SHA256).Hash

        if ($hash -ne $lastHash) {
            $lastHash = $hash
            Write-Host "🔄 DOT CHANGE DETECTED @ $(Get-Date -Format 'HH:mm:ss')"
            powershell -ExecutionPolicy Bypass -File "C:\EQ\eqping.ps1"
        }
    }
    Start-Sleep -Seconds 5
}
