Clear-Host
$Host.UI.RawUI.WindowTitle = "Kroxssy Booster v3 - AUTO MODE"

$gameProcesses = @(
    "javaw",
    "Minecraft.Windows",
    "VALORANT",
    "cs2"
)

$boostActive = $false

function Enable-Boost {
    Write-Host "🚀 GAME DETECTED → BOOST ON" -ForegroundColor Green

    powercfg /setactive SCHEME_MIN | Out-Null
    ipconfig /flushdns | Out-Null

    $global:boostActive = $true
}

function Disable-Boost {
    Write-Host "🔄 GAME CLOSED → NORMAL MODE" -ForegroundColor Yellow

    powercfg /setactive SCHEME_BALANCED | Out-Null

    $global:boostActive = $false
}

Write-Host "👀 Oyunlar izleniyor..." -ForegroundColor Cyan

while ($true)
{
    $runningGame = $false

    foreach ($g in $gameProcesses)
    {
        if (Get-Process -Name $g -ErrorAction SilentlyContinue)
        {
            $runningGame = $true
        }
    }

    if ($runningGame -and -not $boostActive)
    {
        Enable-Boost
    }

    if (-not $runningGame -and $boostActive)
    {
        Disable-Boost
    }

    Start-Sleep -Seconds 5
}