@echo off
title SYSTEM TOOLKIT INSANE
color 0A
setlocal EnableExtensions

:menu
cls
echo ===================================================
echo                SYSTEM TOOLKIT INSANE
echo ===================================================
echo  1. Trang thai nhanh (CPU/RAM/GPU/VRAM/Disk/Uptime)
echo  2. Theo doi he thong lien tuc (CPU+RAM)
echo  3. Chi tiet phan cung (CPU/RAM/GPU/Disk)
echo  4. Toan bo thong tin Windows (systeminfo)
echo  5. Phan mem da cai
echo  6. Tinh trang o cung (SMART)
echo  7. Chuong trinh khoi dong cung Windows
echo  8. Nhiet do he thong (neu ho tro)
echo  9. Danh sach driver
echo 10. Lich su USB da ket noi
echo 11. Thiet bi phan cung (PnP)
echo 12. Log loi Windows gan day
echo 13. Virtualization CPU
echo 14. Thong tin RAM chi tiet
echo 15. Kiem tra file he thong Windows (SFC)
echo 16. Kiem tra o cung (CHKDSK)
echo 17. Don file rac (Disk Cleanup)
echo 18. Danh gia cau hinh may
echo 19. Top chuong trinh dung RAM
echo 20. Service Windows
echo 21. Process dang chay
echo 22. Thong tin pin
echo 23. Tinh trang mang (IP / Adapter)
echo 24. Top chuong trinh an CPU nhieu nhat
echo 25. Kiem tra Virtual Memory (Pagefile)
echo 26. Thong tin BIOS + Mainboard
echo 27. Liet ke tat ca o dia logical
echo 28. Liet ke o cung vat ly
echo 29. Liet ke phan vung
echo 30. Thoat
echo ===================================================

set /p chon=Nhap lua chon:

if "%chon%"=="1" goto quick
if "%chon%"=="2" goto monitor
if "%chon%"=="3" goto hardware
if "%chon%"=="4" goto full
if "%chon%"=="5" goto software
if "%chon%"=="6" goto smart
if "%chon%"=="7" goto startup
if "%chon%"=="8" goto temp
if "%chon%"=="9" goto driver
if "%chon%"=="10" goto usb
if "%chon%"=="11" goto devices
if "%chon%"=="12" goto errors
if "%chon%"=="13" goto virtual
if "%chon%"=="14" goto ramdetail
if "%chon%"=="15" goto scan
if "%chon%"=="16" goto diskcheck
if "%chon%"=="17" goto cleanup
if "%chon%"=="18" goto evaluate
if "%chon%"=="19" goto topram
if "%chon%"=="20" goto services
if "%chon%"=="21" goto process
if "%chon%"=="22" goto battery
if "%chon%"=="23" goto network
if "%chon%"=="24" goto topcpu
if "%chon%"=="25" goto pagefile
if "%chon%"=="26" goto bios
if "%chon%"=="27" goto logical
if "%chon%"=="28" goto physical
if "%chon%"=="29" goto partitions
if "%chon%"=="30" exit
goto menu

:quick
cls
echo =============== TRANG THAI NHANH ===============
powershell -NoProfile -Command ^
"$cpu=(Get-Counter '\Processor(_Total)% Processor Time').CounterSamples.CookedValue; ^
$os=Get-CimInstance Win32_OperatingSystem; ^
$gpu=Get-CimInstance Win32_VideoController | Select-Object -First 1; ^
$total=[math]::Round($os.TotalVisibleMemorySize/1MB,2); ^
$free=[math]::Round($os.FreePhysicalMemory/1MB,2); ^
$used=[math]::Round($total-$free,2); ^
$vram=[math]::Round($gpu.AdapterRAM/1MB,2); ^
$uptime=(Get-Date)-$os.LastBootUpTime; ^
Write-Host ('CPU dang dung      : '+[math]::Round($cpu,1)+' %'); ^
Write-Host ('RAM tong           : '+$total+' GB'); ^
Write-Host ('RAM da dung        : '+$used+' GB'); ^
Write-Host ('RAM con lai        : '+$free+' GB'); ^
Write-Host ('GPU                : '+$gpu.Name); ^
Write-Host ('VRAM               : '+$vram+' MB'); ^
Write-Host ('Uptime             : '+$uptime.Days+' ngay '+$uptime.Hours+' gio'); ^
Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3' | ForEach-Object { ^
$size=[math]::Round($_.Size/1GB,2); ^
$free=[math]::Round($_.FreeSpace/1GB,2); ^
$used=[math]::Round($size-$free,2); ^
Write-Host ($_.DeviceID+'  Tong:'+ $size +'GB  Da dung:'+ $used +'GB  Con:'+ $free +'GB') ^
}"
pause
goto menu

:monitor
cls
echo Dang theo doi he thong... Ctrl+C de thoat
:loop
powershell -NoProfile -Command ^
"$cpu=(Get-Counter '\Processor(_Total)% Processor Time').CounterSamples.CookedValue; ^
$os=Get-CimInstance Win32_OperatingSystem; ^
$total=[math]::Round($os.TotalVisibleMemorySize/1MB,2); ^
$free=[math]::Round($os.FreePhysicalMemory/1MB,2); ^
$used=[math]::Round($total-$free,2); ^
Write-Host ('CPU: '+[math]::Round($cpu,1)+' %'); ^
Write-Host ('RAM: '+$used+' / '+$total+' GB')"
timeout /t 2 >nul
cls
goto loop

:hardware
cls
wmic cpu get Name,NumberOfCores,MaxClockSpeed
wmic memorychip get Capacity,Speed,Manufacturer
wmic path win32_videocontroller get Name,AdapterRAM
wmic diskdrive get Model,Size
pause
goto menu

:full
cls
systeminfo
pause
goto menu

:software
cls
wmic product get Name,Version
pause
goto menu

:smart
cls
wmic diskdrive get Model,Status,Size
pause
goto menu

:startup
cls
wmic startup get Caption,Command
pause
goto menu

:temp
cls
powershell -NoProfile -Command "Get-WmiObject MSAcpi_ThermalZoneTemperature -Namespace root/wmi | foreach { $t=($_.CurrentTemperature/10)-273.15; Write-Host ('Nhiet do: ' + [math]::Round($t,1) + ' C') }"
pause
goto menu

:driver
cls
driverquery
pause
goto menu

:usb
cls
wmic path Win32_USBControllerDevice
pause
goto menu

:devices
cls
wmic path Win32_PnPEntity get Name,Manufacturer,Status
pause
goto menu

:errors
cls
powershell -NoProfile -Command "Get-EventLog -LogName System -EntryType Error -Newest 20"
pause
goto menu

:virtual
cls
systeminfo | find "Virtualization"
pause
goto menu

:ramdetail
cls
wmic memorychip get Manufacturer,Capacity,Speed,PartNumber
pause
goto menu

:scan
cls
sfc /scannow
pause
goto menu

:diskcheck
cls
chkdsk
pause
goto menu

:cleanup
cls
cleanmgr
pause
goto menu

:evaluate
cls
for /f "skip=1 tokens=2 delims==" %%a in ('wmic cpu get NumberOfCores /value') do set cores=%%a
for /f "skip=1 tokens=2 delims==" %%a in ('wmic computersystem get TotalPhysicalMemory /value') do set ram=%%a
set /a ramgb=%ram%/1073741824
echo CPU cores: %cores%
echo RAM: %ramgb% GB
pause
goto menu

:topram
cls
powershell -NoProfile -Command "Get-Process | Sort WorkingSet -Descending | Select -First 10"
pause
goto menu

:services
cls
sc query
pause
goto menu

:process
cls
tasklist
pause
goto menu

:battery
cls
wmic path Win32_Battery get EstimatedChargeRemaining,Status
pause
goto menu

:network
cls
ipconfig
pause
goto menu

:topcpu
cls
powershell -NoProfile -Command "Get-Process | Sort CPU -Descending | Select -First 10"
pause
goto menu

:pagefile
cls
wmic pagefile list /format:list
pause
goto menu

:bios
cls
wmic bios get Manufacturer,SMBIOSBIOSVersion,ReleaseDate
wmic baseboard get Manufacturer,Product,SerialNumber
pause
goto menu

:logical
cls
wmic logicaldisk get Name,FileSystem,FreeSpace,Size
pause
goto menu

:physical
cls
wmic diskdrive get Model,InterfaceType,Size
pause
goto menu

:partitions
cls
wmic partition get Name,Size,Type
pause
goto menu