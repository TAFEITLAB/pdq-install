::::::::::::::::::::::
:: Waterfox - Uninstall ::
::::::::::::::::::::::
:: Description: Uninstall APPNAME
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL UNINSTALL ::::
if exist %PROGRAMFILES%\Waterfox (
	"%PROGRAMFILES%\Waterfox\uninstall\helper.exe" /S
	)
if exist %PROGRAMFILES(x86)%\Waterfox (
	"%PROGRAMFILES(x86)%\Waterfox\uninstall\helper.exe" /S
	)

:: END SCRIPT
exit