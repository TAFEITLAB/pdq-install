@echo off

REM | ==========
REM | NOTEPAD++
REM | ==========
REM | Purpose: Silently install Notepad++ via PDQ Deploy.
REM | Requirements:
REM |   - Script in same directory as binary.
REM |   - Script matches binary name.
REM | Author: Tim Dunn
REM | Organisation: TAFEITLAB

REM | ================
REM | VERSION HISTORY
REM | ================
REM | -- 2019-03-11 --
REM | Created script.
REM | -- 2019-03-26 --
REM | Added file association loop.
REM | 	- Currently only associates Notepad++ with .txt files.
REM |  - Formatted to easily add more file types (separate by comma).
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

REM | Packages and flags
REM | - Do not use trailing slashes (\).
set LOCATION=
set BINARY=npp.7.6.6.Installer.x64.exe
set FLAGS=/S

REM | ========
REM | INSTALL
REM | ========

REM | Kill processes that may interfere with installation
taskkill /f /im notepad++.exe /t 2>NUL
wmic process where name="notepad++.exe" call terminate 2>NUL

REM | Call binary and flags.
REM | - Quote marks used to avoid issues with spaces in binary name.
"%BINARY%" %FLAGS%

REM | Create XML file to ensure plugins are user-specific
if exist "%ProgramFiles%\Notepad++" copy NUL "%ProgramFiles%\Notepad++\allowAppDataPlugins.xml"
if exist "%ProgramFiles(x86)%\Notepad++" copy NUL "%ProgramFiles(x86)%\Notepad++\allowAppDataPlugins.xml"

REM | Delete updater plugin
if exist "%SystemDrive%\Program Files (x86)\Notepad++\updater" rmdir /s /q "%SystemDrive%\Program Files (x86)\Notepad++\updater" 2>NUL
if exist "%SystemDrive%\Program Files\Notepad++\updater" rmdir /s /q "%SystemDrive%\Program Files\Notepad++\updater" 2>NUL

REM | Delete DSpellCheck plugin
del /f /q "%SystemDrive%\Program Files\Notepad++\plugins\DSpellCheck.dll" 2>NUL
del /f /q "%SystemDrive%\Program Files (x86)\Notepad++\plugins\DSpellCheck.dll" 2>NUL

REM | Associate Notepad++ with specified file types
for %%i in (txt) do (
	REM | Associations
	assoc .%%i=txtfile
	REM | Open With
	ftype txtfile="%PROGRAMFILES%\Notepad++\notepad++.exe" "%%1"
	)

REM | ============================
REM | CLEAR ENVIRONMENT and EXIT
REM | ============================

REM | Reset current working directory.
popd

REM | Return exit code to PDQ Deploy.
exit /B %EXIT_CODE%
