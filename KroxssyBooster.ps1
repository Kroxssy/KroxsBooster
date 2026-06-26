Clear-Host
$Host.UI.RawUI.WindowTitle = "Kroxssy Booster v1.0"

function Show-Header {
    Clear-Host
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "        KROXSSY BOOSTER v1.0" -ForegroundColor Green
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host ""
}

function Wait {
    Read-Host "Devam etmek için Enter"
}

while ($true)
{
    Show-Header

    Write-Host "[1] FPS Optimize" -ForegroundColor Yellow
    Write-Host "[2] Temp Cleaner" -ForegroundColor Yellow
    Write-Host "[3] DNS Flush" -ForegroundColor Yellow
    Write-Host "[4] Sistem Bilgisi" -ForegroundColor Yellow
    Write-Host "[0] Çıkış" -ForegroundColor Red
    Write-Host ""

    $secim = Read-Host "Seçimin"

    switch ($secim)
    {
        "1"
        {
            Show-Header
            Write-Host "🚀 FPS Optimize başlatılıyor..." -ForegroundColor Green

            # High Performance mode
            powercfg /setactive SCHEME_MIN | Out-Null

            # DNS flush
            ipconfig /flushdns | Out-Null

            # Temp cleanup
            Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
            Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

            Write-Host ""
            Write-Host "✓ High Performance aktif" -ForegroundColor Green
            Write-Host "✓ DNS temizlendi" -ForegroundColor Green
            Write-Host "✓ Temp dosyaları temizlendi" -ForegroundColor Green

            Wait
        }

        "2"
        {
            Show-Header
            Write-Host "🧹 Temp temizleniyor..." -ForegroundColor Yellow

            Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
            Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

            Write-Host ""
            Write-Host "✓ Temp temizlendi" -ForegroundColor Green

            Wait
        }

        "3"
        {
            Show-Header
            Write-Host "🌐 DNS temizleniyor..." -ForegroundColor Yellow

            ipconfig /flushdns | Out-Null

            Write-Host ""
            Write-Host "✓ DNS temizlendi" -ForegroundColor Green

            Wait
        }

        "4"
        {
            Show-Header
            Write-Host "📊 Sistem Bilgisi" -ForegroundColor Cyan
            Write-Host ""

            $os = Get-CimInstance Win32_OperatingSystem
            $cpu = Get-CimInstance Win32_Processor
            $gpu = Get-CimInstance Win32_VideoController

            Write-Host "OS: $($os.Caption)"
            Write-Host "CPU: $($cpu.Name)"
            Write-Host "GPU: $($gpu.Name)"
            Write-Host ""
            Write-Host "RAM Kullanımı (GB):"
            Write-Host ("Toplam: " + [math]::Round($os.TotalVisibleMemorySize/1MB,2))
            Write-Host ("Boş: " + [math]::Round($os.FreePhysicalMemory/1MB,2))

            Wait
        }

        "0"
        {
            break
        }

        default
        {
            Write-Host "❌ Hatalı seçim!" -ForegroundColor Red
            Start-Sleep 1
        }
    }
}