@echo off
title DON RAC NHANH
color 0A

del /f /s /q "%temp%\*" >nul 2>&1
for /d %%x in ("%temp%\*") do rd /s /q "%%x" >nul 2>&1

del /f /s /q "%windir%\Temp\*" >nul 2>&1
for /d %%x in ("%windir%\Temp\*") do rd /s /q "%%x" >nul 2>&1

del /f /s /q "%windir%\Prefetch\*" >nul 2>&1
del /f /s /q "%APPDATA%\Microsoft\Windows\Recent\*" >nul 2>&1

PowerShell -Command "Clear-RecycleBin -Force" >nul 2>&1
ipconfig /flushdns >nul

exit