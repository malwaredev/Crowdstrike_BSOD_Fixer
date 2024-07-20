@echo off
setlocal enabledelayedexpansion

:: Set the path to the CrowdStrike drivers folder
set "CS_PATH=C:\Windows\System32\drivers\CrowdStrike"

:: Check if the folder exists
if not exist "%CS_PATH%" (
    echo CrowdStrike folder not found.
    goto :EOF
)

:: Change to the CrowdStrike folder
cd /d "%CS_PATH%"

:: Try to delete the file
echo Attempting to delete C-00000291*.sys file...
del /F /Q C-00000291*.sys

:: Check if the deletion was successful
if exist "C-00000291*.sys" (
    echo Unable to delete file. It may be in use or require elevated permissions.
    echo Please try running this script as administrator or in Safe Mode.
) else (
    echo File successfully deleted.
)

pause
