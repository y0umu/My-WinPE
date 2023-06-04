@echo off

@REM where is the image to modify?
set IMGSRC="WinPE_amd64\media\sources\boot.wim"

@REM ---------------------------
@REM mount
mkdir _mount
Dism /Mount-Image /ImageFile:%IMGSRC% /index:1 /MountDir:_mount

@REM ---------------------------
echo Adding language neutral packages...
set PE_WMI="C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-WMI.cab"
set PE_SECURE="C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-SecureStartup.cab"
set PE_NETFX="C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-NetFx.cab"
set PE_FONT_CN="C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-FontSupport-ZH-CN.cab"
set PE_FONT_HK="C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-FontSupport-ZH-HK.cab"
set PE_FONT_TW="C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-FontSupport-ZH-TW.cab"
set PE_FONT_JP="C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-FontSupport-JA-JP.cab"
set PE_FONT_KR="C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-FontSupport-KO-KR.cab"
set PE_FONT_LAGACY="C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-Fonts-Legacy.cab"
set PE_ENHANCED_STORAGE="C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-EnhancedStorage.cab"
set PE_SCRIPTING="C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-Scripting.cab"
set PE_POWERSHELL="C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-PowerShell.cab"
set PE_FMAPI="C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-FMAPI.cab"

@REM Dism /Image:_mount /Add-Package /PackagePath:%PE_WMI% /PackagePath:%PE_SECURE% /PackagePath:%PE_NETFX% /PackagePath:%PE_FONT_CN% /PackagePath:%PE_FONT_HK% /PackagePath:%PE_FONT_TW% /PackagePath:%PE_FONT_JP% /PackagePath:%PE_FONT_KR% /PackagePath:%PE_FONT_LAGACY% /PackagePath:%PE_ENHANCED_STORAGE% /PackagePath:%PE_SCRIPTING% /PackagePath:%PE_POWERSHELL%

@REM only add what you need
Dism /Image:_mount /Add-Package /PackagePath:%PE_WMI% /PackagePath:%PE_SECURE% /PackagePath:%PE_NETFX% /PackagePath:%PE_FONT_CN% /PackagePath:%PE_FONT_HK% /PackagePath:%PE_FONT_TW% /PackagePath:%PE_ENHANCED_STORAGE% /PackagePath:%PE_SCRIPTING% /PackagePath:%PE_POWERSHELL% /PackagePath:%PE_FMAPI%

echo adding language specific packages...
set PE_WMI_EN="C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-WMI_en-us.cab"
set PE_ENHANCED_STORAGE_EN="C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-EnhancedStorage_en-us.cab"
set PE_NETFX_EN="C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-NetFx_en-us.cab"
set PE_SECURE_EN="C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-SecureStartup_en-us.cab"
set PE_SCRIPTING_EN="C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-Scripting_en-us.cab"
set PE_POWERSHELL_EN="C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-PowerShell_en-us.cab"

Dism /Image:_mount /Add-Package /PackagePath:%PE_WMI_EN% /PackagePath:%PE_ENHANCED_STORAGE_EN% /PackagePath:%PE_NETFX_EN% /PackagePath:%PE_SECURE_EN% /PackagePath:%PE_SCRIPTING_EN% /PackagePath:%PE_POWERSHELL_EN%

@REM ---------------------------
echo Adding custom apps...
mkdir _mount\apps

@REM busybox (https://frippery.org/busybox/) and so on
mkdir "_mount\apps\my-cli-collection"
copy "D:\Applications\my-cli-collection\busybox.exe" "_mount\apps\my-cli-collection\"
@REM copy "D:\Applications\my-cli-collection\WolCmd.exe" "_mount\apps\my-cli-collection\"

@REM Systeminternalsuite (https://docs.microsoft.com/en-us/sysinternals)
mkdir "_mount\apps\SysinternalsSuite"
xcopy /E "D:\Applications\SysinternalsSuite" "_mount\apps\SysinternalsSuite\"

@REM WinFR (Windows File Recovery) (https://aka.ms/winfrhelp)
@REM You have to obtain it from Microsoft Store first
copy "C:\Program Files\WindowsApps\Microsoft.WindowsFileRecovery_0.1.20151.0_x64__8wekyb3d8bbwe\ntfssalv_cli_exe\WinFR.exe" "_mount\Windows"

@REM Double commander (explorer.exe alternative and much more) https://doublecmd.sourceforge.io/
@REM xcopy /E "D:\Applications\doublecmd" "_mount\apps\doublecmd\"
7z x d:\xzc\Downloads\app\doublecmd-1.0.11.x86_64-win64.zip -o"_mount\apps\"

@REM bbLean (a shell) http://bb4win.sourceforge.net/bblean/
xcopy /E "D:\Applications\bbLean" "_mount\apps\bbLean\"
xcopy /E "bbLean_modified_config\*" "_mount\apps\bbLean\"

@REM fastcopy https://fastcopy.jp/
@REM xcopy /E "D:\Applications\FastCopy392_x64" "_mount\apps\FastCopy\"

@REM Disk partiton and others https://www.diskgenius.cn/
@REM you need a legal copy of "C:\Windows\System32\oledlg.dll" to make it work in PE
xcopy /E "D:\Applications\DiskGenius" "_mount\apps\DiskGenius\"
copy "C:\Windows\System32\oledlg.dll" "_mount\apps\DiskGenius\"

@REM TestDisk & PhotoRec for disk and file recovery
@REM https://www.cgsecurity.org/
xcopy /E "D:\Applications\testdisk-7.1\" "_mount\apps\testdisk-7.1\"

@REM chntpw (compiled from source with mingw64 myself)
@REM https://pogostick.net/~pnh/ntpasswd/
xcopy /E "D:\xzc\lab\chntpw_mingw64\" "_mount\apps\chntpw_mingw64\"

@REM Recuva & Speccy (https://www.piriform.com)
mkdir "_mount\apps\Recuva"
7z x d:\xzc\Downloads\app\rcsetup153.exe -x!$* -o"_mount\apps\Recuva"
echo 1 > "_mount\apps\Recuva\portable.dat"
mkdir "_mount\apps\Speccy"
7z x d:\xzc\Downloads\app\spsetup132.exe -x!$* -o"_mount\apps\Speccy"
echo 1 > "_mount\apps\Speccy\portable.dat"

@REM Geany (https://www.geany.org)
mkdir "_mount\apps\geany"
7z x d:\xzc\Downloads\app\geany-1.38_setup.exe -x!$* -o"_mount\apps\geany"

@REM Detect-It-Easy (https://github.com/horsicq/Detect-It-Easy)
mkdir "_mount\apps\Detect-It-Easy"
7z x d:\xzc\Downloads\app\die_win64_portable_3.07.zip -o"_mount\apps\Detect-It-Easy"

@REM PDFreader
mkdir "_mount\apps\SumatraPDF"
7z x d:\xzc\Downloads\app\SumatraPDF-3.4.6-64.zip -o"_mount\apps\SumatraPDF"

@REM some drivers
@REM Dism /Add-Driver /Image:_mount /Driver:d:\Drivers\WLAN_Realtek_8852AE\netrtwlane6.inf

@REM PENetwork (https://www.penetworkmanager.de/)
mkdir _mount\apps\PENetwork
7z x d:\xzc\Downloads\app\PENetwork_x64.7z -o"_mount\apps\PENetwork"

@REM ---------------------------
echo Adding custom Winpeshl.ini...
@REM https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/winpeshlini-reference-launching-an-app-when-winpe-starts?view=windows-11
copy "winpeshl.ini" "_mount\Windows\System32"

@REM ---------------------------
@REM echo Adding a script
@REM mkdir _mount\Scripts
@REM copy tools\install_double_cmd_as_default.reg _mount\Scripts

@REM ---------------------------
echo Adding README...
copy "README.md" "_mount\"

@REM ---------------------------
@REM commit and unmount
Dism /Unmount-Image /MountDir:_mount /commit

@REM ---------------------------
@REM https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/compact-os?view=windows-11#image-optimization
@REM image optimization
mkdir temp
Dism /Mount-Image /ImageFile:%IMGSRC% /index:1 /MountDir:_mount
Dism /Cleanup-Image /Image="_mount" /StartComponentCleanup /ResetBase /ScratchDir:temp
Dism /Unmount-Image /MountDir:_mount /Commit
Dism /Export-Image /SourceImageFile:%IMGSRC% /SourceIndex:1 /DestinationImageFile:WinPE_amd64\media\sources\boot_cleaned.wim
del WinPE_amd64\media\sources\boot.wim
move WinPE_amd64\media\sources\boot_cleaned.wim %IMGSRC%

@REM ---------------------------
echo make iso media to test in virtual machine
MakeWinPEMedia /iso "WinPE_amd64" "WinPE_amd64.iso"
