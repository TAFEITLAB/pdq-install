:::::::::::::::::::::::::::::::::::::::::
:: VMWare Workstation 14.1 - Uninstall ::
:::::::::::::::::::::::::::::::::::::::::
:: Description: Uninstall VMWare Workstation 14.1
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL UNINSTALL
msiexec.exe /x {C59B3A41-789E-42A0-9902-688CFA7F47E3} /qn

:: END SCRIPT
:: Return exit code
exit /B %EXIT_CODE%