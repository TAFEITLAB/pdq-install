@echo off

REM | =========================
REM | DROPBOX OFFLINE INSTALLER
REM | =========================
REM | Purpose: Silently install Dropbox (offline install package) via PDQ Deploy.
REM | Requirements: 
REM |   - Script in same directory as binary.
REM |   - Script matches binary name.
REM | Author: Tim Dunn
REM | Organisation: TAFEITLAB

REM | ================
REM | VERSION HISTORY
REM | ================ 
REM | -- 2018-08-13 --
REM | Created script.
REM | ----------------
REM | -- 2019-03-06 --
REM | Reformatted to use proper "REM" comments instead of "::" hack.
REM | ----------------
REM | -- 2019-03-11 --
REM | Reinstated "::" comments.
REM | ----------------
REM | -- 2019-03-27--
REM |  - Reinstated REM comments
REM |  - Added additional comments to explain code
REM |  - Rewrote "Get date info" to be more efficient 
REM | ----------------

REM | ================================
REM | PREPARE ENVIRONMENT FOR INSTALL
REM | ================================
REM | -------------------------------

REM | Set location of batch file as current working directory
REM | NB: Breakdown of %~dp0:
REM |     % = start variable
REM |     ~ = remove surrounding quotes
REM |     0 = filepath of script
REM |     d = Expand 0 to drive letter only
REM |     p = expand 0 to path only
REM |     Therefore %~dp0 = 
REM |        Get current filepath of script (drive letter and path only)
REM |        No quote marks.
pushd "%~dp0"

REM | Clear screen.
cls

REM | Get date info in ISO 8601 standard date format (yyyy-mm-dd)
REM | NB: The SET function below works as follows:
REM |     VARIABLENAME:~STARTPOSITION,NUMBEROFCHARACTERS
REM |     Therefore in the string "20190327082654.880000+660"
REM |     ~0,4 translates to 2019
REM | NB: Carat (Escape character "^") needed to ensure pipe is processed as part of WMIC command instead of as part of the "for" loop
for /f %%a in ('WMIC OS GET LocalDateTime ^| find "."') do set DTS=%%a
set LOGDATE=%DTS:~0,4%-%DTS:~4,2%-%DTS:~6,2%
set LOGTIME=%DTS:~8,2%:%DTS:~10,2%:%DTS:~12,2%

REM | Logfile
REM | - Set log directory
set LOGPATH=%SYSTEMDRIVE%\Logs
REM | NB: %0 = Full file path of script
REM |     %~n0% = Script file name, no file extension
REM |     %~n0~x0 = Script file name, with file extension
REM | - Set log file name
REM |   - Include log path to ensure it is saved in the correct location.
set LOGFILE=

REM | Package to install.
REM | - Do not use trailing slashes (\).
set BINARY=Dropbox 71.3.102 Offline Installer.exe
set FLAGS=/S

REM | ========
REM | INSTALL
REM | ========

REM | Call binary and flags.
REM | - Quote marks used to avoid issues with spaces in binary name.
"%BINARY%" %FLAGS%

REM | Disable auto-update.
%SYSTEMROOT%\System32\schtasks.exe /delete /TN DropboxUpdateTaskMachineCore /F 2>NUL
%SYSTEMROOT%\System32\schtasks.exe /delete /TN DropboxUpdateTaskMachineUA /F 2>NUL

REM | ============================
REM | CLEAR ENVIRONMENT and EXIT
REM | ============================

REM | Reset current working directory.
popd

REM | Return exit code to PDQ Deploy.
exit /B %EXIT_CODE%