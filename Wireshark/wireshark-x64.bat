@echo off

REM | ==============
REM | WIRESHARK x64
REM | ==============
REM | Purpose: Silently install Wireshark 64-bit with NMap via PDQ Deploy.
REM | Requirements: 
REM |   - Script in same directory as binary.
REM |   - Script matches binary name.
REM |   - "Include Entire Directory" option is ticked in PDQ Deploy package.
REM | Author: Tim Dunn
REM | Organisation: TAFEITLAB

REM | ================
REM | VERSION HISTORY
REM | ================ 
REM | -- 2018-09-12 --
REM | Created script.
REM | ----------------
REM | -- 2019-03-06 --
REM | Reformatted to use proper "REM" comments instead of "::" hack.
REM | ----------------
REM | -- 2019-03-11 --
REM | Reinstated "::" comments
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

REM | - Create the log directory if it doesn't exist.
if not exist %LOGPATH% mkdir %LOGPATH%

REM | Package to install.
REM | - Do not use trailing slashes (\)
REM | -- Set NMap binary and flags
set NMBINARY=nmap-7.70-setup.exe
set NMFLAGS=/S
REM | -- Set Wireshark binary and flags
set WSBINARY=Wireshark-win64-3.0.0.exe
set WSFLAGS=/S

REM | ========
REM | INSTALL
REM | ========

REM | Kill running process. Uses TASKKILL and WMIC for redundancy.
REM | - Kill Zenmap
taskkill /f /im zenmap.exe /t 2>NUL
wmic process where name="zenmap.exe" call terminate 2>NUL
REM | - Kill NMAP
taskkill /f /im nmap.exe /t 2>NUL
wmic process where name="nmap.exe" call terminate 2>NUL
REM | - Kill Wireshark
taskkill /f /im Wireshark.exe /t 2>NUL
wmic process where name="Wireshark.exe" call terminate 2>NUL
REM | - Kill Wireshark-related
taskkill /f /im dumpcap.exe /t 2>NUL
wmic process where name="dumpcap.exe" call terminate 2>NUL

REM | Call binary and flags.
REM | - Quote marks used to avoid issues with spaces in binary name.
REM | - NMAP
REM | -- Check if NMap is installed.
REM | --- If yes, go to Wireshark install.
REM | --- Else, install NMap.
if NOT EXIST "%PROGRAMFILES(x86)%"\Nmap\nmap.exe (
goto :nmap
	) else (
	goto :wireshark
	)
:nmap
%NMBINARY% %NMFLAGS%
REM | - Wireshark
:wireshark
%WSBINARY% %WSFLAGS%

REM | ============================
REM | CLEAR ENVIRONMENT and EXIT
REM | ============================

REM | Reset current working directory.
popd

REM | Return exit code to PDQ Deploy.
exit /B %EXIT_CODE%