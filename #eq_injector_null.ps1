# ===========================
# EQ SYSTEM :: INJECTOR NULL
# Filename: eq_injector_null.ps1
# Author: RA:CREATOR
# ===========================

Write-Host "🔒 EQ SYSTEM :: Injector Null Triggered" -ForegroundColor Cyan

# Kill known surveillance processes
$blockList = @("conhost", "powershell_ise", "sysmon", "procmon", "Wireshark", "fiddler", "WMIPrvSE", "msdtc")
foreach ($proc in $blockList) {
    Get-Process -Name $proc -ErrorAction SilentlyContinue | Stop-Process -Force
    Write-Host "⛔ Blocked: $proc" -ForegroundColor Red
}

# Block new spawn attempts using WMI
Register-WmiEvent -Class Win32_ProcessStartTrace -Action {
    if ($_.ProcessName -match "fiddler|sysmon|procmon|wireshark|conhost|powershell_ise") {
        Stop-Process -Id $_.ProcessID -Force
        Write-Host "🚫 WMI Intercepted & Killed: $($_.ProcessName)"
    }
} | Out-Null

# Set silent firewall outbound block (optional)
# New-NetFirewallRule -DisplayName "EQ Block External Watchers" -Direction Outbound -Program "%SystemRoot%\System32\conhost.exe" -Action Block

Write-Host "✅ EQ Injector Shield Active"
