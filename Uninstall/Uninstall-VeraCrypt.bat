:::::::::::::::::::::::::
:: VeraCrypt - Uninstall ::
:::::::::::::::::::::::::
:: Description: Uninstall VeraCrypt encryption application
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL Uninstall
SET BINARY=C:\Program Files\VeraCrypt\VeraCrypt Setup.exe
SET FLAGS=/u /s
"%BINARY%" %FLAGS%

:: END SCRIPT
:: Return exit code
exit /B %EXIT_CODE%