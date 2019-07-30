::::::::::::::::::::::
:: TeamViewer - Uninstall ::
::::::::::::::::::::::
:: Description: Uninstall APPNAME
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL UNINSTALL ::::
net stop "TeamViewer"
wmic product where "name like 'TeamViewer%%'" uninstall /nointeractive

:: Alternate uninstall
"%PROGRAMFILES(x86)%\TeamViewer\uninstall.exe" /S

:: - Remove registry entries and folders
reg delete HKLM\SOFTWARE\TeamViewer /f
reg delete HKLM\SOFTWARE\WOW6432Node\TeamViewer /f
reg delete HKU\.DEFAULT\Software\Wow6432Node\TeamViewer /f
reg delete HKU\.DEFAULT\Software\TeamViewer /f
reg delete HKU\S-1-5-18\Software\TeamViewer /f
reg delete HKU\S-1-5-18\Software\Wow6432Node\TeamViewer /f
reg delete HKU\S-1-5-18\Software\TeamViewer /f

REG DELETE HKLM\Software\TeamViewer /f
REG DELETE HKCU\Software\TeamViewer /f
RD /S /Q C:\Program Files\Teamviewer
RD /S /Q %%LOCALAPPDATA%%\Temp\TeamViewer

:: END SCRIPT
exit