:::::::::::::::::::::::::::::
:: LibreOffice - Uninstall ::
:::::::::::::::::::::::::::::
:: Description: uninstall LibreOffice (All versions)
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL UNINSTALL
wmic product where "name like 'LibreOffice%%'" uninstall /nointeractive

:: END SCRIPT
:: Return exit code
exit /B %EXIT_CODE%