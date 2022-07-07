#Region Arguments
$DownloadPath = "$HOME\Downloads\BugSec"
$ZimmermanTools = "$HOME\Downloads\BugSec\ZimmermanTools"
$ZimmermanToolsPS = "$HOME\Downloads\BugSec\ZimmermanTools\Get-ZimmermanTools.ps1"
$DFIRTools = "$HOME\Desktop\DFIR Tools"
$PowershellScripts = "$HOME\Desktop\PSScripts"
#Endregion

#Region StartArt
Write-Host "
   _____      _          _____  ______ _____ _____ _______          _       _             _   _ _ _    _ _        _  __
  / ____|    | |        |  __ \|  ____|_   _|  __ \__   __|        | |     | |           | \ | (_) |  (_) |      | |/ /
 | |  __  ___| |_ ______| |  | | |__    | | | |__) | | | ___   ___ | |___  | |__  _   _  |  \| |_| | ___| |_ __ _| ' / 
 | | |_ |/ _ \ __|______| |  | |  __|   | | |  _  /  | |/ _ \ / _ \| / __| | '_ \| | | | | . ` | | |/ / | __/ _` |  <  
 | |__| |  __/ |_       | |__| | |     _| |_| | \ \  | | (_) | (_) | \__ \ | |_) | |_| | | |\  | |   <| | || (_| | . \ 
  \_____|\___|\__|      |_____/|_|    |_____|_|  \_\ |_|\___/ \___/|_|___/ |_.__/ \__, | |_| \_|_|_|\_\_|\__\__,_|_|\_\
                                                                                   __/ |                               
                                                                                  |___/                                
"
#Endregion

#Region CreateNeededFolders
try {
    New-Item -Path $DownloadPath -ItemType Directory
    New-Item -Path $DFIRTools -ItemType Directory
    New-Item -Path $PowershellScripts -ItemType Directory
} catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
}
#Endregion

#Region Get-ZimmermanTools
try {
    Invoke-WebRequest -Uri "https://f001.backblazeb2.com/file/EricZimmermanTools/Get-ZimmermanTools.zip" -OutFile $DownloadPath\Get-ZimmermanTools.zip
    Expand-Archive -LiteralPath $DownloadPath\Get-ZimmermanTools.zip -DestinationPath $ZimmermanTools
} catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
}
& $ZimmermanToolsPS -Dest $ZimmermanTools
#Endregion

#Region DownloadPowershellScripts
try {
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/zjorz/Public-AD-Scripts/master/Reset-KrbTgt-Password-For-RWDCs-And-RODCs.ps1" -OutFile "$PowershellScripts\Reset-KrbTgt.ps1"
} catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
}
#Endregion

#Region DownloadMobaXterm
try {
    Invoke-WebRequest -Uri "https://download.mobatek.net/2212022060563542/MobaXterm_Installer_v22.1.zip" -OutFile "$DownloadPath\MobaXterm_Installer_v22.1.zip"
    Expand-Archive -LiteralPath "$DownloadPath\MobaXterm_Installer_v22.1.zip" -DestinationPath $DownloadPath
    msiexec.exe /i "$DownloadPath\MobaXterm_installer_22.1.msi" /qn
} catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
}
#Endregion

#Region InstallFromGit
try {
    Invoke-WebRequest -Uri "https://github.com/DFIRKuiper/Hoarder/raw/main/releases/hoarder.exe" -OutFile "$DFIRTools\Hoarder.exe"
    Invoke-WebRequest - Uri "https://github.com/ahmedkhlief/APT-Hunter/archive/refs/heads/main.zip" -OutFile "$DFIRTools\APT-Hunter.zip"
    Invoke-WebRequest - Uri "https://github.com/countercept/chainsaw/archive/refs/heads/master.zip" -OutFile "$DFIRTools\chainsaw.zip"
    Expand-Archive -LiteralPath "$DFIRTools\APT-Hunter.zip" -DestinationPath "$DFIRTools\APT-Hunter"
    Expand-Archive -LiteralPath "$DFIRTools\chainsaw.zip" -DestinationPath "$DFIRTools\chainsaw"
} catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
}
#Endregion

#Region InstallChocoAndPackages
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco upgrade chocolatey
choco install winscp -y
choco install ghidra -y
choco install hashmyfiles -y
choco install pestudio -y --ignore-checksum
choco install x64dbg.portable -y
choco install ida-free -y
choco install hxd -y
choco install python3 -y
choco install volatility -y
#Endregion

#Region DoneArt
Write-Host "
_____   ____  _   _ ______ _ 
|  __ \ / __ \| \ | |  ____| |
| |  | | |  | |  \| | |__  | |
| |  | | |  | | . ` |  __| | |
| |__| | |__| | |\  | |____|_|
|_____/ \____/|_| \_|______(_)
                              
                              
"
#Endregion