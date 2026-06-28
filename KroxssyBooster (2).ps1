Clear-Host
$Host.UI.RawUI.WindowTitle = "KroxsFPS v2"

function PauseScreen {
    Write-Host ""
    Read-Host "Devam etmek için Enter'a bas"
}

while ($true)
{
    Clear-Host

    Write-Host ""
    Write-Host "==============================================" -ForegroundColor Cyan
    Write-Host "               KROXSFPS v2" -ForegroundColor Green
    Write-Host "==============================================" -ForegroundColor Cyan
    Write-Host ""

    Write-Host "[1] 🎮 Oyun Modu" -ForegroundColor Yellow
    Write-Host "[2] 🧹 Sistem Temizliği" -ForegroundColor Yellow
    Write-Host "[3] 🌐 DNS Temizle" -ForegroundColor Yellow
    Write-Host "[4] 📊 Sistem Bilgisi" -ForegroundColor Yellow
    Write-Host "[5] 🎮 Oyun Algıla" -ForegroundColor Yellow
    Write-Host "[6] ⚡ Tüm Optimizasyonları Uygula" -ForegroundColor Green
    Write-Host "[0] ❌ Çıkış" -ForegroundColor Red
    Write-Host ""

    $secim = Read-Host "Seçimin"

    switch ($secim)
    {
        "1"
        {
            Write-Host ""
            Write-Host "Oyun modu uygulanıyor..." -ForegroundColor Green

            powercfg /setactive SCHEME_MIN
            ipconfig /flushdns | Out-Null

            Write-Host ""
            Write-Host "✓ Yüksek Performans açıldı." -ForegroundColor Green
            Write-Host "✓ DNS temizlendi." -ForegroundColor Green

            PauseScreen
        }

        "2"
        {
            Write-Host ""
            Write-Host "Temizlik başlatılıyor..." -ForegroundColor Yellow

            Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
            Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

            Write-Host ""
            Write-Host "✓ Temp klasörleri temizlendi." -ForegroundColor Green

            PauseScreen
        }

        "3"
        {
            Write-Host ""
            Write-Host "DNS temizleniyor..." -ForegroundColor Yellow

            ipconfig /flushdns | Out-Null

            Write-Host ""
            Write-Host "✓ DNS başarıyla temizlendi." -ForegroundColor Green

            PauseScreen
        }

        "4"
        {
            Clear-Host

            $os = Get-CimInstance Win32_OperatingSystem
            $cpu = Get-CimInstance Win32_Processor

            $toplamRAM = [math]::Round($os.TotalVisibleMemorySize/1MB,2)
            $bosRAM = [math]::Round($os.FreePhysicalMemory/1MB,2)

            Write-Host ""
            Write-Host "========== SİSTEM ==========" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "İşlemci : $($cpu.Name)"
            Write-Host "RAM     : $toplamRAM GB"
            Write-Host "Boş RAM : $bosRAM GB"
            Write-Host "Windows : $($os.Caption)"
            Write-Host ""

            PauseScreen
        }

        "5"
        {
            Write-Host ""

            $oyun = $null

            if(Get-Process javaw -ErrorAction SilentlyContinue){$oyun="Minecraft"}
            elseif(Get-Process VALORANT-Win64-Shipping -ErrorAction SilentlyContinue){$oyun="Valorant"}
            elseif(Get-Process cs2 -ErrorAction SilentlyContinue){$oyun="Counter-Strike 2"}
            elseif(Get-Process FortniteClient-Win64-Shipping -ErrorAction SilentlyContinue){$oyun="Fortnite"}

            if($oyun)
            {
                Write-Host "🎮 $oyun algılandı." -ForegroundColor Green
            }
            else
            {
                Write-Host "Açık desteklenen oyun bulunamadı." -ForegroundColor Red
            }

            PauseScreen
        }

        "6"
        {
            Write-Host ""
            Write-Host "Tüm optimizasyonlar uygulanıyor..." -ForegroundColor Cyan

            powercfg /setactive SCHEME_MIN
            ipconfig /flushdns | Out-Null

            Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
            Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

            Write-Host ""
            Write-Host "=====================================" -ForegroundColor Green
            Write-Host "✓ Güç Planı Güncellendi"
            Write-Host "✓ DNS Temizlendi"
            Write-Host "✓ Temp Dosyaları Silindi"
            Write-Host "=====================================" -ForegroundColor Green

            PauseScreen
        }

        "0"
        {
            break
        }

        default
        {
            Write-Host ""
            Write-Host "Geçersiz seçim." -ForegroundColor Red
            PauseScreen
        }
    }
}