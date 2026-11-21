# NetLens installer / updater for Windows 10/11 (x86_64)
# Usage (PowerShell):  irm https://omarmurcia.github.io/netlens-repo/install-windows.ps1 | iex
$ErrorActionPreference = "Stop"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$owner      = "omarmurcia"
$repo       = "netlens"
$installDir = Join-Path $env:LOCALAPPDATA "NetLens"

Write-Host "=========================================================="
Write-Host " NetLens Official Installer & Updater (Windows)"
Write-Host "=========================================================="

# 1. Close running instances
Get-Process -Name "netlens" -ErrorAction SilentlyContinue | ForEach-Object {
    Write-Host "==> Closing running NetLens (PID $($_.Id))..."
    $_ | Stop-Process -Force
}
Start-Sleep -Milliseconds 500

# 2. Locate the latest Windows build published on GitHub Releases
Write-Host "==> Looking up the latest release..."
$release = Invoke-RestMethod -Uri "https://api.github.com/repos/$owner/$repo/releases/latest" -Headers @{ "User-Agent" = "netlens-installer" }
$asset = $release.assets | Where-Object { $_.name -like "*windows-x86_64.zip" } | Select-Object -First 1
if (-not $asset) { throw "No Windows build found in release $($release.tag_name)." }

# 3. Download & extract
$zip = Join-Path $env:TEMP $asset.name
Write-Host "==> Downloading $($asset.name)..."
Invoke-WebRequest -Uri $asset.browser_download_url -OutFile $zip -UseBasicParsing
New-Item -ItemType Directory -Force $installDir | Out-Null
Expand-Archive -Path $zip -DestinationPath $installDir -Force
Remove-Item $zip -Force

# 4. Start Menu shortcut
$exe = Join-Path $installDir "netlens.exe"
$lnk = Join-Path ([Environment]::GetFolderPath("Programs")) "NetLens.lnk"
$shell = New-Object -ComObject WScript.Shell
$sc = $shell.CreateShortcut($lnk)
$sc.TargetPath = $exe
$sc.WorkingDirectory = $installDir
$sc.Description = "NetLens - Local Network Device Explorer"
$sc.Save()

Write-Host "NetLens $($release.tag_name) installed in $installDir"
Write-Host "Launch it from the Start Menu or run: & '$exe'"
