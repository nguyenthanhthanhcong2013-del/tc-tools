@echo off
echo DANG GIAI PHONG RAM...
timeout /t 2 /nobreak > NUL
ipconfig /flushdns
rundll32.exe advapi32.dll,ProcessIdleTasks
echo RAM da duoc don sach!
pause
