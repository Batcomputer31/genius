# ================================
# 🛡️ EQ SIGIL WATCH SYSTEM
# ================================

$SigilLockFile = "C:\EVONATION.ps1\EQ\SIGILS\signature.lock"
$LogPath       = "C:\EVONATION.ps1\EQ\SIGILS\sigwatch_21.log"
$LastSignature = ""

function Watch-Sigil {
    while ($true) {
        if (Test-Path $SigilLockFile) {
            $CurrentSigil = Get-Content $SigilLockFile -Raw
            if ($CurrentSigil -ne $LastSignature) {
                $TimeNow = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
                $Output = "⚠️ SIGIL TRIGGERED @ $TimeNow — New SIGIL = $CurrentSigil"
                $Output | Tee-Object -FilePath $LogPath -Append
                $LastSignature = $CurrentSigil
            }
        }
        Start-Sleep -Seconds 1
    }
}

Write-Output "🔁 EQ SIGIL WATCH ACTIVE"
Watch-Sigil
