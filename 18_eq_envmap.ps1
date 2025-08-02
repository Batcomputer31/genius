# === [18_eq_envmap.ps1] ===
# Purpose: Log system environment map for EQ operational intelligence
# Author: RA:CREATOR

$envInfo = @{
    Username        = $env:USERNAME
    ComputerName    = $env:COMPUTERNAME
    OS              = (Get-CimInstance Win32_OperatingSystem).Caption
    Version         = (Get-CimInstance Win32_OperatingSystem).Version
    BuildNumber     = (Get-CimInstance Win32_OperatingSystem).BuildNumber
    Arch            = (Get-CimInstance Win32_Processor).Architecture
    Processor       = (Get-CimInstance Win32_Processor).Name
    RAM_Total_MB    = [math]::Round((Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1MB)
    SystemDrive     = $env:SystemDrive
    PSVersion       = $PSVersionTable.PSVersion.ToString()
    Time            = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
}

$envInfo | ConvertTo-Json | Out-File "C:\EVONATION.ps1\eq\envmap_18.json" -Encoding UTF8

Write-Host "🗺️ Environment Map Captured. Layer 18 complete."
