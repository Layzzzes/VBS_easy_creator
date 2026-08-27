@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ============================
echo   VBS MsgBox Generator
echo ============================
echo.

set /p "msgtext=Enter message text: "
set /p "msgtitle=Enter window title: "

echo.
echo Choose window icon:
echo   1 - Information (i)
echo   2 - Warning (!)
echo   3 - Question (?)
echo   4 - Error (X)
echo   5 - No icon
set /p "iconchoice=Your choice (1-5): "

if "%iconchoice%"=="1" set "iconval=64"
if "%iconchoice%"=="2" set "iconval=48"
if "%iconchoice%"=="3" set "iconval=32"
if "%iconchoice%"=="4" set "iconval=16"
if "%iconchoice%"=="5" set "iconval=0"

echo.
echo Choose buttons:
echo   1 - OK
echo   2 - OK / Cancel
echo   3 - Abort / Retry / Ignore
echo   4 - Yes / No / Cancel
echo   5 - Yes / No
echo   6 - Retry / Cancel
set /p "btnchoice=Your choice (1-6): "

if "%btnchoice%"=="1" set "btnval=0"
if "%btnchoice%"=="2" set "btnval=1"
if "%btnchoice%"=="3" set "btnval=2"
if "%btnchoice%"=="4" set "btnval=3"
if "%btnchoice%"=="5" set "btnval=4"
if "%btnchoice%"=="6" set "btnval=5"

set /a "total=%iconval%+%btnval%"

set /p "outname=File name (without .vbs): "
set "output=%outname%.vbs"

set "msgtext=!msgtext:"=""!"
set "msgtitle=!msgtitle:"=""!"

powershell -NoProfile -Command ^
  "$t = '%msgtext%'; $ti = '%msgtitle%';" ^
  "$content = 'MsgBox \"' + $t + '\", ' + %total% + ', \"' + $ti + '\"';" ^
  "[System.IO.File]::WriteAllText('%output%', $content, [System.Text.Encoding]::Unicode)"

echo.
echo File %output% created.
echo.
choice /c YN /m "Run now"
if errorlevel 2 goto :end
if errorlevel 1 cscript //nologo "%output%"

:end
endlocal
