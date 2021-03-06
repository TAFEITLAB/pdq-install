@echo off

REM | =========================
REM | Uninstall VMWare Workstation Pro
REM | =========================
REM | Purpose: Silently install PACKAGE via PDQ Deploy.
REM | Requirements:
REM |   - VMware Workstation is installed.
REM | Author: Tim Dunn
REM | Organisation: TAFEITLAB

REM | ================
REM | VERSION HISTORY
REM | ================
REM | -- 2019-04-01 --
REM | Created script
REM | ----------------

REM | ================================
REM | PREPARE ENVIRONMENT FOR INSTALL
REM | ================================

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
set LOGFILE=%LOGPATH%\%~n0_%LOGDATE%.log

REM | Create log directory if does not exist
if not exist %LOGPATH% mkdir %LOGPATH%

REM | Packages and flags
REM | - Do not use trailing slashes (\).
set BINARY=VMware-workstation-full-15.0.4-12990004.exe
REM | NB: %1 in SERIALNUMBER refers to PDQ Deploy package parameter. Ensure it is set.
set FLAGS=/s /nsr /v/qn EULAS_AGREED=1 SERIALNUMBER="%1" AUTOSOFTWAREUPDATE=0 DATACOLLECTION=0 DESKTOP_SHORTCUT=0 ADDLOCAL=ALL DISABLE_AUTORUN=0 QUICKLAUNCH_SHORTCUT=0 REBOOT=ReallySuppress

REM | ========
REM | INSTALL
REM | ========

REM | Kill processes that may interfere with uninstallation
REM | - With TASKKILL
%SystemDrive%\windows\system32\taskkill.exe /F /IM vmware-authd.exe /T 2>NUL
%SystemDrive%\windows\system32\taskkill.exe /F /IM vmware-usbarbitrator64.exe /T 2>NUL
%SystemDrive%\windows\system32\taskkill.exe /F /IM vmnat.exe /T 2>NUL
%SystemDrive%\windows\system32\taskkill.exe /F /IM vmnetdhcp.exe /T 2>NUL
%SystemDrive%\windows\system32\taskkill.exe /F /IM vmware-converter-a.exe /T 2>NUL
%SystemDrive%\windows\system32\taskkill.exe /F /IM vmware-converter.exe /T 2>NUL
%SystemDrive%\windows\system32\taskkill.exe /F /IM vmware-hostd.exe /T 2>NUL
%SystemDrive%\windows\system32\taskkill.exe /F /IM vmware-tray.exe /T 2>NUL
REM | - With WMIC
wmic process where name="vmware-authd.exe" call terminate 2>NUL
wmic process where name="vmware-usbarbitrator64.exe" call terminate 2>NUL
wmic process where name="vmnat.exe" call terminate 2>NUL
wmic process where name="vmnetdhcp.exe" call terminate 2>NUL
wmic process where name="vmware-converter-a.exe" call terminate 2>NUL
wmic process where name="vmware-converter.exe" call terminate 2>NUL
wmic process where name="vmware-hostd.exe" call terminate 2>NUL
wmic process where name="vmware-tray.exe" call terminate 2>NUL

REM | Uninstall
REM | - Prevent uninstall from causing reboot.
wmic product where name="VMware Workstation" call uninstall /nointeractive

REM | ============================
REM | CLEAR ENVIRONMENT and EXIT
REM | ============================

REM | Reset current working directory.
popd

REM | Return exit code to PDQ Deploy.
exit /B %EXIT_CODE%
