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
set "HOME=D:\%USERNAME%"

@REM busybox (https://frippery.org/busybox/) and so on
mkdir "_mount\apps\my-cli-collection"
copy "D:\Applications\my-cli-collection\busybox.exe" "_mount\apps\my-cli-collection\"
copy "D:\Applications\my-cli-collection\busybox64.exe" "_mount\apps\my-cli-collection\"
copy "D:\Applications\my-cli-collection\busybox64u.exe" "_mount\apps\my-cli-collection\"
@REM copy "D:\Applications\my-cli-collection\WolCmd.exe" "_mount\apps\my-cli-collection\"
7z e "%HOME%\Downloads\app\croc_v10.2.1_Windows-64bit.zip" croc.exe -o"_mount\apps\my-cli-collection\"


@REM Systeminternalsuite (https://docs.microsoft.com/en-us/sysinternals)
mkdir "_mount\apps\SysinternalsSuite"
@REM xcopy /E "D:\Applications\SysinternalsSuite" "_mount\apps\SysinternalsSuite\"
7z x "%HOME%\Downloads\app\SysinternalsSuite.zip" -o"_mount\apps\SysinternalsSuite\"

@REM WinFR (Windows File Recovery) (https://aka.ms/winfrhelp)
@REM You have to obtain it from Microsoft Store first
@REM copy "C:\Program Files\WindowsApps\Microsoft.WindowsFileRecovery_0.1.20151.0_x64__8wekyb3d8bbwe\ntfssalv_cli_exe\WinFR.exe" "_mount\Windows"

@REM Double commander (explorer.exe alternative and much more) https://doublecmd.sourceforge.io/
@REM xcopy /E "D:\Applications\doublecmd" "_mount\apps\doublecmd\"
7z x "%HOME%\Downloads\app\doublecmd-1.1.22.x86_64-win64.zip" -o"_mount\apps\"

@REM bbLean (a shell) http://bb4win.sourceforge.net/bblean/
xcopy /E "D:\Applications\bbLean" "_mount\apps\bbLean\"
copy "bbLean_modified_config\menu.rc" "_mount\apps\bbLean\"
copy "bbLean_modified_config\blackbox.rc" "_mount\apps\bbLean\"
copy "bbLean_modified_config\bbLeanBar.rc" "_mount\apps\bbLean\plugins\bbLeanBar\"
copy "bbLean_modified_config\styles\3colours\mod_blue" "_mount\apps\bbLean\styles\3colours\"
@REN Optionally add shizuku wallpaper. Should not be included in distributed image.
@REM copy "%HOME%\Pictures\Shizuku\ShizukuWP11_1920x1080.jpg" "_mount\apps\bbLean\backgrounds\"

@REM fastcopy https://fastcopy.jp/
@REM xcopy /E "D:\Applications\FastCopy392_x64" "_mount\apps\FastCopy\"

@REM Disk partiton and others https://www.diskgenius.cn/
@REM you need a legal copy of "C:\Windows\System32\oledlg.dll" to make it work in PE
@REM xcopy /E "D:\Applications\DiskGenius" "_mount\apps\DiskGenius\"
@REM copy "C:\Windows\System32\oledlg.dll" "_mount\apps\DiskGenius\"

@REM TestDisk & PhotoRec for disk and file recovery
@REM https://www.cgsecurity.org/
@REM xcopy /E "D:\Applications\testdisk-7.1\" "_mount\apps\testdisk-7.1\"
7z x "%HOME%\Downloads\app\testdisk-7.2.win64.zip" -o"_mount\apps\"

@REM chntpw (compiled from source with mingw64 myself)
@REM https://pogostick.net/~pnh/ntpasswd/
xcopy /E "%HOME%\lab\chntpw_mingw64\" "_mount\apps\chntpw_mingw64\"

@REM Recuva & Speccy (https://www.piriform.com)
@REM mkdir "_mount\apps\Recuva"
@REM 7z x %HOME%\Downloads\app\rcsetup153.exe -x!$* -o"_mount\apps\Recuva"
@REM echo 1 > "_mount\apps\Recuva\portable.dat"
@REM mkdir "_mount\apps\Speccy"
@REM 7z x %HOME%\Downloads\app\spsetup132.exe -x!$* -o"_mount\apps\Speccy"
@REM echo 1 > "_mount\apps\Speccy\portable.dat"

@REM Geany (https://www.geany.org)
mkdir "_mount\apps\geany"
7z x %HOME%\Downloads\app\geany-2.0_setup.exe -x!$* -o"_mount\apps\geany"

@REM Detect-It-Easy (https://github.com/horsicq/Detect-It-Easy)
mkdir "_mount\apps\Detect-It-Easy"
7z x "%HOME%\Downloads\app\die_win64_portable_3.09_x64.zip" -o"_mount\apps\Detect-It-Easy"

@REM PDFreader (https://www.sumatrapdfreader.org/)
mkdir "_mount\apps\SumatraPDF"
7z x "%HOME%\Downloads\app\SumatraPDF-3.5.2-64.zip" -o"_mount\apps\SumatraPDF"

@REM JPEGView (https://github.com/sylikc/jpegview)
mkdir "_mount\apps\JPEGView"
7z x "%HOME%\Downloads\app\JPEGView64_1.3.46.7z" -o"_mount\apps\JPEGView"

@REM some drivers
@REM Dism /Add-Driver /Image:_mount /Driver:d:\Drivers\WLAN_Realtek_8852AE\netrtwlane6.inf

@REM PENetwork (https://www.penetworkmanager.de/)
@REM mkdir _mount\apps\PENetwork
@REM 7z x %HOME%\Downloads\app\PENetwork_x64.7z -o"_mount\apps\PENetwork"

@REM ---------------------------
echo Adding custom Winpeshl.ini and startnet.cmd... 
@REM https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/winpeshlini-reference-launching-an-app-when-winpe-starts?view=windows-11
copy "winpe_startup_scripts\winpeshl.ini" "_mount\Windows\System32"
copy "winpe_startup_scripts\startnet.cmd" "_mount\Windows\System32"

@REM ---------------------------
@REM echo Adding a script
@REM mkdir _mount\Scripts
@REM copy tools\install_double_cmd_as_default.reg _mount\Scripts

@REM ---------------------------
echo Adding README...
copy "README.md" "_mount\"

@REM ---------------------------
echo Changing time zone and locals...
dism /image:_mount /Set-TimeZone:"China Standard Time"
dism /image:_mount /Set-SysLocale:zh-CN
dism /image:_mount /Set-UserLocale:zh-CN

@REM ---------------------------
@REM https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/compact-os?view=windows-11#image-optimization
@REM image optimization
mkdir temp
@REM Dism /Mount-Image /ImageFile:%IMGSRC% /index:1 /MountDir:_mount
Dism /Cleanup-Image /Image="_mount" /StartComponentCleanup /ResetBase /ScratchDir:temp
@REM commit and unmount
Dism /Unmount-Image /MountDir:_mount /Commit
Dism /Export-Image /SourceImageFile:%IMGSRC% /SourceIndex:1 /DestinationImageFile:WinPE_amd64\media\sources\boot_cleaned.wim
del WinPE_amd64\media\sources\boot.wim
move WinPE_amd64\media\sources\boot_cleaned.wim %IMGSRC%

@REM ---------------------------
echo make iso media to test in virtual machine
MakeWinPEMedia /iso "WinPE_amd64" "WinPE_amd64.iso"
