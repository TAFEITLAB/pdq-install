::::::::::::::::::::::
:: APPNAME - Uninstall ::
::::::::::::::::::::::
:: Description: Uninstall 7-Zip x64 (Executable version)
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL UNINSTALL ::::
SET BINARY=C:\Program Files\7-Zip\Uninstall.exe
SET FLAGS=/S
"%BINARY%" %FLAGS%

:: END SCRIPT
:: Return exit code
exit /B %EXIT_CODE%