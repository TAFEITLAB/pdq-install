@echo off

:: =============================================
:: NAME
:: =============================================
:: Purpose: 
:: Requirements:
:: Author: 
:: Organisation: 

:: ================
:: VERSION HISTORY
:: ================ 
:: -- YYYY-MM-DD --
:: 
:: ----------------

:: ===============================
:: PREPARE ENVIRONMENT FOR SCRIPT
:: ===============================

:: Set location of batch file as current working directory
:: NB: Breakdown of %~dp0:
::     % = start variable
::     ~ = remove surrounding quotes
::     0 = filepath of script
::     d = Expand 0 to drive letter only
::     p = expand 0 to path only
::     Therefore %~dp0 = 
::        Get current filepath of script (drive letter and path only)
::        No quote marks.
pushd "%~dp0"

:: Clear screen.
cls

:: Get date info in ISO 8601 standard date format (yyyy-mm-dd)
:: NB: The SET function below works as follows:
::     VARIABLENAME:~STARTPOSITION,NUMBEROFCHARACTERS
::     Therefore in the string "20190327082654.880000+660"
::     ~0,4 translates to 2019
:: NB: Carat (Escape character "^") needed to ensure pipe is processed as part of WMIC command instead of as part of the "for" loop
for /f %%a in ('WMIC OS GET LocalDateTime ^| find "."') do set DTS=%%a
set LOGDATE=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%
set LOGTIME=%DTS:~8,2%:%DTS:~10,2%:%DTS:~12,2%

:: Logfile
:: - Set log directory
set LOGPATH=%SYSTEMDRIVE%\Logs
:: NB: %0 = Full file path of script
::     %~n0% = Script file name, no file extension
::     %~n0~x0 = Script file name, with file extension
:: - Set log file name
::   - Include log path to ensure it is saved in the correct location.
set LOGFILE=

:: Create log directory if does not exist
IF NOT EXIST %LOGPATH% MKDIR %LOGPATH%

:: Log location and name. Do not use trailing slashes (\)
set LOGPATH=%SystemDrive%\Logs
set LOGFILE=

:: ===============================
:: CREATE APP SECIFIC VARIABLES
:: ===============================
:: Packages and flags
:: - Do not use trailing slashes (\).
:: App version number
SET APP-VRSN=
:: App install location
SET LOCATION=
:: App binary name (include APP-VRSN variable, e.g. appname-%APP-VRSN%-x64.exe)
SET BINARY=
:: App installation flags/switches
SET FLAGS=

:: ======
:: TASKS
:: ======
:: Kill all running instances of application, e.g.
:: - %SYSTEMDRIVE%\windows\system32\taskkill.exe /F /IM chrome.exe /T 2>NUL
:: - wmic process where name="chrome.exe" call terminate 2>NUL

:: Run binary with flags
%BINARY% %FLAGS%

:: Run cleanup tasks, e.g.
:: - if exist "%PROGRAMFILES(x86)%\Google\Update" rmdir /s /q "%PROGRAMFILES(x86)%\Google\Update"

:: ============================
:: CLEAR ENVIRONMENT and EXIT
:: ============================

:: Reset current working directory
popd

:: Exit and return exit code to PDQ Deploy
exit /B %EXIT_CODE%