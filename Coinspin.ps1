function Invoke-SpinWhiteBlueNormal {    <#
    .SYNOPSIS
    Advanced spin sequence: Normal → White → Blue → Normal

    .DESCRIPTION
    Creates animated spinning effect with color transitions through white and blue states

    .PARAMETER Duration
    Duration of each transition phase in milliseconds

    .PARAMETER Cycles
    Number of complete white-blue-normal cycles

    .EXAMPLE
    Invoke-SpinWhiteBlueNormal

    .EXAMPLE
    Invoke-SpinWhiteBlueNormal -Duration 1000 -Cycles 3
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false)]
        [int]$Duration = 1200,

        [Parameter(Mandatory = $false)]
        [int]$Cycles = 1
    )

    # Spin animation characters
    $spinChars = @('⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏')
    $whiteSpinChars = @('◐', '◓', '◑', '◒', '◐', '◓', '◑', '◒')
    $blueSpinChars = @('🔵', '🔷', '🔹', '💙', '🟦', '🔹', '🔷', '🔵')

    Write-Host "`n🌀 INITIATING WHITE-BLUE-NORMAL SPIN SEQUENCE..." -ForegroundColor Cyan
    Start-Sleep -Milliseconds 500

    for ($cycle = 1; $cycle -le $Cycles; $cycle++) {

        Write-Host "`n[$cycle/$Cycles] Starting spin cycle..." -ForegroundColor DarkGray

        # === PHASE 1: NORMAL TO WHITE ===
        Write-Host "`n🔄 Spinning to WHITE state..." -ForegroundColor Yellow

        # Transition spinning
        for ($i = 0; $i -lt 6; $i++) {
            $char = $spinChars[$i % $spinChars.Length]
            Write-Host "`r  $char Transitioning..." -ForegroundColor Gray -NoNewline
            Start-Sleep -Milliseconds ($Duration / 18)
        }

        # White state spinning
        Write-Host "`r  ⚪ WHITE STATE ACTIVE    " -ForegroundColor White
        for ($i = 0; $i -lt 8; $i++) {
            $whiteChar = $whiteSpinChars[$i % $whiteSpinChars.Length]
            Write-Host "`r  $whiteChar WHITE SPINNING..." -ForegroundColor White -NoNewline
            Start-Sleep -Milliseconds ($Duration / 16)
        }

        Write-Host "`r  ⚪ WHITE PHASE COMPLETE " -ForegroundColor White
        Start-Sleep -Milliseconds 200

        # === PHASE 2: WHITE TO BLUE ===
        Write-Host "`n🔄 Spinning to BLUE state..." -ForegroundColor Cyan

        # White to blue transition
        for ($i = 0; $i -lt 4; $i++) {
            $transChar = $whiteSpinChars[$i % $whiteSpinChars.Length]
            Write-Host "`r  $transChar Shifting..." -ForegroundColor DarkCyan -NoNewline
            Start-Sleep -Milliseconds ($Duration / 20)
        }

        # Blue state spinning
        Write-Host "`r  🔵 BLUE STATE ACTIVE     " -ForegroundColor Blue
        for ($i = 0; $i -lt 8; $i++) {
            $blueChar = $blueSpinChars[$i % $blueSpinChars.Length]
            Write-Host "`r  $blueChar BLUE SPINNING..." -ForegroundColor Blue -NoNewline
            Start-Sleep -Milliseconds ($Duration / 16)
        }

        Write-Host "`r  🔵 BLUE PHASE COMPLETE  " -ForegroundColor Blue
        Start-Sleep -Milliseconds 200

        # === PHASE 3: BLUE TO NORMAL ===
        Write-Host "`n🔄 Spinning back to NORMAL..." -ForegroundColor Yellow

        # Blue to normal transition
        for ($i = 7; $i -ge 0; $i--) {
            $blueChar = $blueSpinChars[$i % $blueSpinChars.Length]
            Write-Host "`r  $blueChar Returning..." -ForegroundColor DarkBlue -NoNewline
            Start-Sleep -Milliseconds ($Duration / 20)
        }

        # Final normal spinning
        for ($i = 9; $i -ge 0; $i--) {
            $char = $spinChars[$i % $spinChars.Length]
            Write-Host "`r  $char Normalizing..." -ForegroundColor Gray -NoNewline
            Start-Sleep -Milliseconds ($Duration / 20)
        }

        Write-Host "`r  ⚫ NORMAL STATE RESTORED " -ForegroundColor White
        Start-Sleep -Milliseconds 400

        if ($cycle -lt $Cycles) {
            Write-Host "    ⏳ Preparing next cycle..." -ForegroundColor DarkGray
            Start-Sleep -Milliseconds 300
        }
    }

    # === FINAL STATUS ===
    Write-Host "`n🎯 WHITE-BLUE-NORMAL SEQUENCE COMPLETE" -ForegroundColor Magenta
    Write-Host "═══════════════════════════════════════" -ForegroundColor DarkMagenta
    Write-Host "   ├─ Cycles Completed: $Cycles" -ForegroundColor Gray
    Write-Host "   ├─ Phases: NORMAL → WHITE → BLUE → NORMAL" -ForegroundColor Gray
    Write-Host "   ├─ Current State: NORMAL" -ForegroundColor Gray
    Write-Host "   └─ Status: READY FOR NEXT COMMAND" -ForegroundColor Gray
    Write-Host "═══════════════════════════════════════`n" -ForegroundColor DarkMagenta

    return [PSCustomObject]@{
        CyclesCompleted = $Cycles
        FinalState = "NORMAL"
        PhaseSequence = @("NORMAL", "WHITE", "BLUE", "NORMAL")
        Status = "READY"
        Timestamp = Get-Date
    }
}

# Quick single-phase functions
function Start-SpinToWhite {
    Write-Host "⚫" -ForegroundColor Gray -NoNewline
    Start-Sleep -Milliseconds 150
    Write-Host "`r🔄" -ForegroundColor Yellow -NoNewline
    Start-Sleep -Milliseconds 150
    Write-Host "`r⚪ WHITE" -ForegroundColor White
}

function Start-SpinToBlue {
    Write-Host "⚪" -ForegroundColor White -NoNewline
    Start-Sleep -Milliseconds 150
    Write-Host "`r🔄" -ForegroundColor Cyan -NoNewline
    Start-Sleep -Milliseconds 150
    Write-Host "`r🔵 BLUE" -ForegroundColor Blue
}

function Start-SpinToNormal {
    Write-Host "🔵" -ForegroundColor Blue -NoNewline
    Start-Sleep -Milliseconds 150
    Write-Host "`r🔄" -ForegroundColor Yellow -NoNewline
    Start-Sleep -Milliseconds 150
    Write-Host "`r⚫ NORMAL" -ForegroundColor White
}

# Advanced color sequence with custom colors
function Invoke-CustomColorSpin {
    param(
        [string[]]$ColorSequence = @("White", "Blue", "Normal"),
        [int]$Duration = 1000
    )

    $colorMap = @{
        "White" = @{ Char = "⚪"; Color = "White" }
        "Blue" = @{ Char = "🔵"; Color = "Blue" }
        "Normal" = @{ Char = "⚫"; Color = "Gray" }
        "Green" = @{ Char = "🟢"; Color = "Green" }
        "Red" = @{ Char = "🔴"; Color = "Red" }
        "Yellow" = @{ Char = "🟡"; Color = "Yellow" }
    }

    Write-Host "`n🌈 CUSTOM COLOR SEQUENCE INITIATED" -ForegroundColor Magenta

    foreach ($color in $ColorSequence) {
        if ($colorMap.ContainsKey($color)) {
            $colorInfo = $colorMap[$color]
            Write-Host "🔄" -ForegroundColor Yellow -NoNewline
            Start-Sleep -Milliseconds ($Duration / 4)
            Write-Host "`r$($colorInfo.Char) $color" -ForegroundColor $colorInfo.Color
            Start-Sleep -Milliseconds ($Duration / 2)
        }
    }

    Write-Host "✨ Custom sequence complete`n" -ForegroundColor Magenta
}

# Usage Examples:
# Invoke-SpinWhiteBlueNormal                              # Standard sequence
# Invoke-SpinWhiteBlueNormal -Duration 2000 -Cycles 3     # Slower, multiple cycles
# Start-SpinToWhite; Start-SpinToBlue; Start-SpinToNormal # Manual control
# Invoke-CustomColorSpin -ColorSequence @("White", "Blue", "Green", "Normal") # Custom sequence


Sent with Proton Mail secure email.