@echo off
setlocal EnableDelayedExpansion

REM === SET SOURCE DIRECTORY ===
set "ROOTDIR=C:\EVONATION.ps1"
set "LOGFILE=%ROOTDIR%\EQ_SWEEP_LOG.txt"

echo 🔄 EQ File Sweeper Started > "%LOGFILE%"
echo Folder: %ROOTDIR% >> "%LOGFILE%"
echo Timestamp: %DATE% %TIME% >> "%LOGFILE%"
echo ----------------------------- >> "%LOGFILE%"

REM === SWEEP ALL FILES ===
for /r "%ROOTDIR%" %%F in (*) do (
    set "FILE=%%~fF"
    set "EXT=%%~xF"
    set "NAME=%%~nF"
    set "DIR=%%~dpF"

    REM === IF FILE HAS NO EXTENSION, ATTACH .ps1 ===
    if "!EXT!"=="" (
        ren "%%~fF" "%%~nF.ps1"
        echo 🔧 Converted (no ext) to .ps1: %%~fF >> "%LOGFILE%"
    )

    REM === IF FILE IS .txt and contains PowerShell —> convert to .ps1 ===
    if /I "!EXT!"==".txt" (
        findstr /I "powershell function param $" "%%~fF" >nul 2>&1 && (
            ren "%%~fF" "%%~nF.ps1"
            echo ⚙️ Script .txt renamed to .ps1: %%~fF >> "%LOGFILE%"
        )
    )

    REM === IF FILE IS .txt and contains @echo off —> convert to .bat ===
    if /I "!EXT!"==".txt" (
        findstr /I "@echo off" "%%~fF" >nul 2>&1 && (
            ren "%%~fF" "%%~nF.bat"
            echo 🚀 Batch .txt renamed to .bat: %%~fF >> "%LOGFILE%"
        )
    )
)

echo ✅ EQ Sweep Complete >> "%LOGFILE%"
echo Done.
pause