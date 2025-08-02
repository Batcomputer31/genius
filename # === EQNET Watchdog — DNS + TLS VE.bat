# === EQNET Watchdog — DNS + TLS VERIFY ===
$domain = "evonation.net"
$ipExpected = "38.88.82.64"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$logDir = "C:\EVONATION.ps1\EQNET\NETWORK"
$logFile = "$logDir\eqnet_dns_tls_log.txt"

# Create path if missing
if (!(Test-Path -Path $logDir)) {
    New-Item -Path $logDir -ItemType Directory | Out-Null
}

function Log($text) {
    $entry = "[$timestamp] $text"
    $entry | Tee-Object -FilePath $logFile -Append
    Write-Host $entry
}

# === Start Scan
Log "`n=== EQNET Verify Scan Start ==="

# === DNS A RECORD CHECK ===
try {
    $ipActual = [System.Net.Dns]::GetHostAddresses($domain)[0].IPAddressToString
    if ($ipActual -eq $ipExpected) {
        Log "✅ A record matches: $ipActual"
    } else {
        Log "❌ A record mismatch. Got: $ipActual | Expected: $ipExpected"
    }
} catch {
    Log "❌ Failed to resolve A record for $domain"
}

# === TLS HANDSHAKE CHECK ===
try {
    $tcpClient = New-Object Net.Sockets.TcpClient
    $tcpClient.Connect($domain, 443)
    $sslStream = New-Object System.Net.Security.SslStream($tcpClient.GetStream(), $false, ({$true}))
    $sslStream.AuthenticateAsClient($domain)
    Log "✅ TLS Handshake Successful: $($sslStream.SslProtocol)"
    $sslStream.Close()
    $tcpClient.Close()
} catch {
    Log "❌ TLS handshake failed: $_"
}
