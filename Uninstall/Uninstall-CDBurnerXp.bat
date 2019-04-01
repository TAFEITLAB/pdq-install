::::::::::::::::::::::
:: CDBurnerXP - Uninstall ::
::::::::::::::::::::::
:: Description: Uninstall CDBurnerXP optical disc and ISO creator
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL UNINSTALL ::::
SET BINARY= C:\Program Files\CDBurnerXP\unins000.exe
SET FLAGS=/SILENT
"%BINARY%" %FLAGS%

:: END SCRIPT
:: Return exit code
exit /B %EXIT_CODE%