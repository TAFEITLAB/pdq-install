@echo off

REM | =====================
REM | GNS3 AND DEPENDENCIES
REM | =====================
REM | Purpose: Silently install GNS3 and dependencies via PDQ Deploy.
REM | Requirements: 
REM |   - Script in same directory as binary.
REM |   - Script matches binary name.
REM |   - "Include Entire Directory" option is ticked in PDQ Deploy package. 
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
REM | WinPcap install section: Added check for existence of WinPcap folder in ProgramFiles and ProgramFiles(x86). 
REM | dotNet Framework install section: Added check and error message for existence of dotNet installer on NAS.
REM | ----------------
REM | -- 2019-03-11 --
REM | Reinstated "::" comments."
REM | -- 2019-03-25 --
REM | Added check to see if dotNet is already installed before check for existence of NAS file.
REM | ----------------
REM | -- 2019-03-27--
REM |  - Reinstated REM comments
REM |  - Added additional comments to explain code
REM |  - Rewrote "Get date info" to be more efficient 
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
set LOGFILE=

REM | Create log directory if does not exist
IF NOT EXIST %LOGPATH% MKDIR %LOGPATH%

REM | Location
SET LOCATION=

REM | WinPCap
REM | -- Custom package
REM | -- Official version does not allow for silent installation. 
REM | -- New custom package must be built for each new version.
SET WPBIN=WinPcap_4_1_3_sib.msi
SET WPFLAGS=/qn /norestart /log virtview.log

REM | Virt Viewer
SET VVBIN=virt-viewer-x64-7.0.msi
SET VVFLAGS=/qn /norestart /log virtview.log

REM | GNS3
REM | Custom package
REM | Official version does not allow for silent installation. 
REM | New custom package must be built for each new version.
SET GNS3BIN=GNS3-2.1.9-all-in-one-regular_sib.msi
SET GNS3FLAGS=/qn /norestart

REM | ========
REM | INSTALL
REM | ========

REM | Installs dependencies first, then GNS3

REM | - WinPCap
REM | -- Check if WinPcap exists. If yes, skip to Virt Viewer install.
if EXIST "%PROGRAMFILES(x86)%"\WinPcap goto :VirtViewer
if EXIST "%PROGRAMFILES%"\WinPcap goto :VirtViewer
REM | -- Call binary and flags.
%WPBIN% %WPFLAGS%
echo.

REM | - Virt Viewer
REM | -- Call binary and flags.
:VirtViewer
%VVBIN% %VVFLAGS%
echo.

REM | - dotNet Framework 3.5
REM | -- Check if dotNet already exists on target
:dotnet
reg query "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v3.5" | if %errorlevel%==0 goto gsn3
REM | -- Check if file exists on server
if EXIST \\rnas\tmp\Win10edu.16299.125.171213-1220\sources\sxs (
REM | Run install via PowerShell
powershell.exe -Command "& { DISM /ONLINE /Enable-feature /FeatureName:NetFx3 /All /Source:\\rnas\tmp\Win10edu.16299.125.171213-1220\sources\sxs }"
) ELSE (
REM | -- File not found. Echo error message.
echo dotNetFx not found. Check network connection.
echo This installation requires access to:
echo \\rnas\tmp\Win10edu.16299.125.171213-1220\sources\sxs
echo.
goto finished
)

REM | GNS3
REM | - Call binary and flags.
:gns3
%GNS3BIN% %GNS3FLAGS%
echo.

:finished
REM | ============================
REM | CLEAR ENVIRONMENT and EXIT
REM | ============================

REM | Reset current working directory.
popd

REM | Return exit code to PDQ Deploy.
exit /B %EXIT_CODE%