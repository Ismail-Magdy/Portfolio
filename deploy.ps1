$ErrorActionPreference = "Stop"

$Project = "E:\New_Flutter\PROFILE\ismailmagdy"
$Deploy  = "E:\New_Flutter\PROFILE\Ismail-Magdy.github.io"

Clear-Host
Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "      Portfolio Auto Deploy Script" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

$start = Get-Date

try {

    Write-Host "[1/5] Building Flutter Web..." -ForegroundColor Yellow
    Set-Location $Project
    flutter build web --release

    Write-Host ""
    Write-Host "[2/5] Copying files..." -ForegroundColor Yellow

    robocopy `
        "$Project\build\web" `
        "$Deploy" `
        /MIR `
        /NFL `
        /NDL `
        /NJH `
        /NJS `
        /NP | Out-Null

    Write-Host ""
    Write-Host "[3/5] Checking Git..." -ForegroundColor Yellow

    Set-Location $Deploy

    git status | Out-Null

    git add .

    $changes = git status --porcelain

    if ([string]::IsNullOrWhiteSpace($changes)) {
        Write-Host ""
        Write-Host "No changes detected." -ForegroundColor DarkYellow
        exit
    }

    Write-Host ""
    Write-Host "[4/5] Creating Commit..." -ForegroundColor Yellow

    $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    git commit -m "Deploy $time"

    Write-Host ""
    Write-Host "[5/5] Pushing to GitHub..." -ForegroundColor Yellow

    git push origin main

    $elapsed = (Get-Date) - $start

    Write-Host ""
    Write-Host "==========================================" -ForegroundColor Green
    Write-Host "      DEPLOY SUCCESSFUL" -ForegroundColor Green
    Write-Host "==========================================" -ForegroundColor Green
    Write-Host ""

    Write-Host ("Time: {0:N1} seconds" -f $elapsed.TotalSeconds) -ForegroundColor Cyan

    Start-Process "https://ismail-magdy.github.io"

}
catch {

    Write-Host ""
    Write-Host "==========================================" -ForegroundColor Red
    Write-Host "           DEPLOY FAILED" -ForegroundColor Red
    Write-Host "==========================================" -ForegroundColor Red
    Write-Host ""

    Write-Host $_.Exception.Message -ForegroundColor Red
}

Read-Host "`nPress Enter to exit"