# === [17_eq_dotnet.ps1] ===
# Purpose: Initiate link to .NET runtime + AppDomain hooks
# Author: RA:CREATOR

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.IO.Compression.FileSystem

$dotNetInfo = [System.Environment]::Version
$clrVersion = [System.Runtime.InteropServices.RuntimeInformation]::FrameworkDescription
$arch = [System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture
$host = [System.Diagnostics.Process]::GetCurrentProcess().MainModule.FileName

$EQ_DOTNET = @{
    DotNet_Version = $dotNetInfo
    CLR = $clrVersion
    Arch = $arch
    HostProcess = $host
    EQ_Mode = "Linked"
    Layer = 17
    Link = "Active"
}

# Output configuration snapshot
$EQ_DOTNET | ConvertTo-Json | Out-File "C:\EVONATION.ps1\eq\dotnet_link.json" -Encoding UTF8

Write-Output "🔗 .NET Runtime Linked: $clrVersion ($arch)"
