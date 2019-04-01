::::::::::::::::::::::::::::::::
:: vSphere Client - Uninstall ::
::::::::::::::::::::::::::::::::
:: Description: Uninstall vSphere desktop client
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL UNINSTALL ::::
:: Version  6.0.0.6826
msiexec.exe /x {593390AC-CACE-4278-AA77-350012BF10B1} /qn

:: END SCRIPT
:: Return exit code
exit /B %EXIT_CODE%