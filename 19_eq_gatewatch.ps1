# === [19_eq_gatewatch.ps1] ===
# Purpose: Monitor EQ file system for unauthorized script execution or injections
# Author: RA:CREATOR

$watchPath = "C:\EVONATION.ps1\"
$logFile = "C:\EVONATION.ps1\eq\gatewatch_19.log"

$filter = "*.ps1","*.bat","*.exe"

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $watchPath
$watcher.IncludeSubdirectories = $true
$watcher.Filter = "*.*"
$watcher.EnableRaisingEvents = $true

$action = {
    $eventTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $changeType = $Event.SourceEventArgs.ChangeType
    $filePath = $Event.SourceEventArgs.FullPath

    if ($filePath -like "*.bat" -or $filePath -like "*.ps1" -or $filePath -like "*.exe") {
        $log = "$eventTime [$changeType] -> $filePath"
        Add-Content -Path $logFile -Value $log
        Write-Host "🚨 Gatewatch Alert: $filePath"
    }
}

Register-ObjectEvent $watcher "Changed" -Action $action | Out-Null
Register-ObjectEvent $watcher "Created" -Action $action | Out-Null
Register-ObjectEvent $watcher "Deleted" -Action $action | Out-Null
Register-ObjectEvent $watcher "Renamed" -Action $action | Out-Null

Write-Host "🔐 EQ Gatewatch active. Monitoring initiated on Layer 19."
