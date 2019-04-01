::::::::::::::::::::::
:: 7zip - Uninstall ::
::::::::::::::::::::::
:: Description: Uninstall 7-zip archive manager
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL UNINSTALL ::::
:: Version 18.05.00.0
msiexec.exe /x {23170F69-40C1-2702-1805-000001000000} /qn

:: END SCRIPT
:: Return exit code
exit /B %EXIT_CODE%