:::::::::::::::::::::
:: GNS3 - Uninstall::
:::::::::::::::::::::
:: Description: Uninstall GNS3
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

::::  CALL UNINSTALL
SET BINARY=C:\Program Files\GNS3\Uninstall.exe
SET FLAGS=/S
"%BINARY%" %FLAGS%

:: END SCRIPT
:: Return exit code
exit /B %EXIT_CODE%