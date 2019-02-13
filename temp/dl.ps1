# PowerShell script to download various tools/utility applications
# Applications that we want to download include:
# 1.    Chrome
# 2.    NotePad++
# 3.    7-Zip
# Python
# Tools

# $exe_dl_urls = @{
#     "chrome_enterprise" = "http://dl.google.com/edgedl/chrome/install/GoogleChromeStandaloneEnterprise64.msi"
#     ; "chrome" = "http://dl.google.com/edgedl/chrome/install/chrome_installer.exe"
#  }


# Notepad++ download links are based on version number
Write-Progress -Activity "NotePad++"
$url = "https://notepad-plus-plus.org/download/"
$html = wget $url
$download_url = ($html.Links | Where-Object {$_.innerText -eq "Notepad++ Installer 64-bit x64"} | Select-Object -First 1).href
$output_filename = [System.IO.Path]::GetFileName($download_url)
wget $url -OutFile $output_filename
Write-Host "$url$download_url"


# 7-zip download links are based on position; 64bit is at the last.
Write-Progress -Activity "7-Zip"
$url = "https://www.7-zip.org/"
$html = wget $url
$download_url = ($html.Links | Where-Object {$_.outerText -eq "Download"} | Select-Object -Last 1).href
$output_filename = [System.IO.Path]::GetFileName($download_url)
wget $url -OutFile $output_filename
Write-Host "$url$download_url"


Write-Progress -Activity "Python"
# Website for python.org uses TLS1.2; By default, PowerShell uses TLS 1.0
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$url = "https://www.python.org/downloads/"
$html = wget $url
# Link for downloading for Windows platform is the 3rd in the list; (1st is MacOS, 2nd is Linux)
$download_url = ($html.links | Where-Object {$_.href.StartsWith("https://www.python.org/ftp/python")})[2].href
$output_filename = [System.IO.Path]::GetFileName($download_url)
wget $url -OutFile $output_filename
Write-Host $download_url


Write-Progress -Activity "Sysinternals Utilities"
$download_url = "https://download.sysinternals.com/files/SysinternalsSuite.zip"

Write-Host $download_url
$output_filename = [System.IO.Path]::GetFileName($download_url)
#wget $url -OutFile $output_filename

# Download TFS
# Sqlserver

# Change timezone to Singapore (UTC+8)
# Run this script to get a list of TimeZones [System.TimeZoneInfo]::GetSystemTimeZones()
Set-TimeZone -Id "Singapore Standard Time"

