@echo off

REM | ======================
REM | MICROSOFT OFFICE 2016
REM | ======================
REM | Purpose: Silently install customised installation of Microsoft Office 2016 via PDQ Deploy.
REM | Requirements:
REM |   - ISO is present on NAS.
REM |   - KMS Server is running and available.
REM |   - First parameter in PDQ Deploy package is FQDN of KMS server.
REM | Author:
REM | Organisation: TAFEITLAB

REM | ================
REM | VERSION HISTORY
REM | ================
REM | -- 2019-03-11 --
REM | Created script.
REM | -- 2019-03-25 --
REM | Added segment to check if ISO can be found, skip to end of script on failure.
REM | Added InstallState checks for Excel, PowerPoint, Word.
REM | -- 2019-03-27--
REM |  - Reinstated REM comments
REM |  - Added additional comments to explain code
REM |  - Rewrote "Get date info" to be more efficient
REM | -- 2019-04-01 --
REM |  - KMS_Sev now uses PDQ Deploy package first parameter instead of directly using FQDN
REM | ----------------

REM | ================================
REM | PREPARE ENVIRONMENT FOR INSTALL
REM | ================================

REM | Start localization of environment variables
setlocal

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

REM | Check if products are already installed
REM | - Excel
:excel
for /f "skip=1" %%A in (
'wmic product where "Name like '%%Microsoft Excel%%'" get installstate'
) do (
	if %%A==5 goto powerpoint
	)
	echo.Excel not installed. Proceeding to install Office 2016.
	goto check_iso
REM | - PowerPoint
:powerpoint
for /f "skip=1" %%A in (
'wmic product where "Name like '%%Microsoft PowerPoint%%'" get installstate'
) do (
	if %%A==5 goto word
	)
	echo.PowerPoint not installed. Proceeding to install Office 2016.
	goto check_iso
REM | - Word
:word
for /f "skip=1" %%A in (
'wmic product where "Name like '%%Microsoft Word%%'" get installstate'
) do (
	if %%A==5 goto finished
	)
	echo.Word not installed. Proceeding to install Office 2016.
	goto check_iso

REM | Check if ISO can be found. If not, echo an error message and go to end of script.
:check_iso
IF NOT EXIST \\rnas\admin\iso\custom\SW_DVD5_Office_Professional_Plus_2016_64Bit_English_MLF_X20-42432.iso (
echo ISO does not exist or cannot be reached
goto finished
)

REM | ISO variable
SET NASISO=\\rnas\admin\iso\custom\SW_DVD5_Office_Professional_Plus_2016_64Bit_English_MLF_X20-42432.iso
SET ISO=C:\SW_DVD5_Office_Professional_Plus_2016_64Bit_English_MLF_X20-42432.iso

REM | ========
REM | INSTALL
REM | ========

REM | Download ISO from share
COPY %NASISO% %ISO%

REM | Mount ISO with powerShell
POWERSHELL Mount-DiskImage -ImagePath "%ISO%"

REM | Get ISO drive letter, set as variable
For /F "Skip=1 Delims=" %%A In ('
    "WMIC LogicalDisk Where (VolumeName='SW_DVD5_Office_P') Get Name"
') Do For %%B In (%%A) Do Set "ISODRIVE=%%B"

REM | Run installer with customisation adminfile
%ISODRIVE%\setup.exe /adminfile install.msp

REM | =====================
REM | POST-INSTALL CLEANUP
REM | =====================

REM | Dismount ISO with PowerShell
IF EXIST %ISO% POWERSHELL Dismount-DiskImage -ImagePath "%ISO%"

REM | Delete ISO
IF EXIST %ISO% DEL /f %ISO%

REM | Point Office to KMS and activate
REM | - Set variables
SET OfcPath="C:\Program Files\Microsoft Office\Office16"
REM | -- NB: %1 = first parameter in PDQ Deploy package.
SET KMS_Sev="%1"
REM | - Add KMS key to Office
cscript %OfcPath%\ospp.vbs /inpkey:XQNVK-8JYDB-WJ9W3-YJ8YR-WFG99
REM | - Add KMS Server to Office
cscript //nologo %OfcPath%\ospp.vbs /sethst:%KMS_Sev% >nul
REM | - Activate against KMS server
cscript //nologo %OfcPath%\ospp.vbs /act | find /i "successful"

:finished
REM | ============================
REM | CLEAR ENVIRONMENT and EXIT
REM | ============================

REM | End localization of environment variables
endlocal

REM | Return exit code to PDQ Deploy.
exit /B %EXIT_CODE%
