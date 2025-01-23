@echo off
@REM Refer to https://github.com/iperdomo/update-intel-me-using-linux

set "IMGSRC=WinPE_amd64\media\sources\boot.wim"
set "HOME=D:\%USERNAME%"

@REM mount PE image
mkdir _mount
Dism /Mount-Image /ImageFile:%IMGSRC% /index:1 /MountDir:_mount

@REM -------------------
@REM Drivers are from MSI
@REM https://www.msi.cn/Motherboard/MAG-B760M-MORTAR-MAX-WIFI/support#driver

@REM Add Chipset driver
Dism /Add-Driver /Image:_mount /Driver:"%HOME%\Downloads\MAG-B760M-MORTAR-MAX-WIFI\Intel Chipset Driver_10.1.19627.8423\drivers\RaptorLake\RaptorLakeSystem.inf" 

@REM Add necessary ME driver
@REM https://news.ycombinator.com/item?id=15744152
@REM I figured out how to install it using Windows PE. First, get a Windows installer image or WADK and mount it. Microsoft provides these, but hides the download link well. Then get the ME firmware update installer and the AMT/ME software installer from Lenovo and execute the unpackers with wine. From ~/.wine/drive_c/DRIVERS/WIN/AMT, do "cabextract SetupME.exe". You can discard everything but the "HECI_REL" directory from this, including SetupME.exe.
@REM Now you need wimlib to create the WinPE image: "mkwinpeimg --windows-dir=/mnt winpe.img --overlay=$HOME/.wine/drive_c/DRIVERS"
@REM The resulting winpe.img can be dd'ed to a USB thumb drive. Boot into it, and execute "cd /WIN/AMT/HECI_REL/win10", "drvload HECI.inf" (to load the MEI driver) and then "cd /WIN/ME/", "MEUpdate.cmd" to update the ME firmware.
Dism /Add-Driver /Image:_mount /Driver:"%HOME%\Downloads\MAG-B760M-MORTAR-MAX-WIFI\Intel Management Engine (ME)\DRIVERS\WIN\MEI\Drivers\HECI_REL\win10\heci.inf"


@REM Add firmware update executables
mkdir _mount\apps\FWUpdate
xcopy /E "%HOME%\Downloads\MAG-B760M-MORTAR-MAX-WIFI\Intel Management Engine (ME)\ME_16.1.30.2361\FWUpdate\*" "_mount\apps\FWUpdate"

@REM Confirm we have installed the drivers 
Dism /Image:_mount /Get-Drivers

@REM Change scratchspace size
Dism /Image:_mount /Set-ScratchSpace:512

@REM Clean up
mkdir temp
Dism /Cleanup-Image /Image="_mount" /StartComponentCleanup /ResetBase /ScratchDir:temp
Dism /Unmount-Image /MountDir:_mount /Commit
Dism /Export-Image /SourceImageFile:%IMGSRC% /SourceIndex:1 /DestinationImageFile:WinPE_amd64\media\sources\boot_cleaned.wim
del WinPE_amd64\media\sources\boot.wim
move WinPE_amd64\media\sources\boot_cleaned.wim %IMGSRC%

@REM gennerate ISO image
MakeWinPEMedia /iso "WinPE_amd64" "WinPE_amd64.iso"