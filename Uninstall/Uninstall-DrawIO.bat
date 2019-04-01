::::::::::::::::::::::
:: draw.io - Uninstall ::
::::::::::::::::::::::
:: Description: Uninstall draw.io diagram and vector graphics editor
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL UNINSTALL ::::
SET BINARY=C:\Program Files\draw.io\Uninstall draw.io.exe
SET FLAGS=/S
"%BINARY%" %FLAGS%

:: END SCRIPT
:: Return exit code
exit /B %EXIT_CODE%