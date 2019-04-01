:::::::::::::::::::::::::
:: BATCH FILE TEMPLATE ::
:::::::::::::::::::::::::
:: Description: Uninstall PuTTY SSH client
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL Uninstall
:: Version 0.70.0.0
msiexec.exe /x {45B3032F-22CC-40CD-9E97-4DA7095FA5A2} /qn

:: END SCRIPT
:: Return exit code
exit /B %EXIT_CODE%