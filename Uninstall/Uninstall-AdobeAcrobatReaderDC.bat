::::::::::::::::::::::
:: APPNAME - Uninstall ::
::::::::::::::::::::::
:: Description: Uninstall APPNAME
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL UNINSTALL ::::
:: Version 18.011.20040
msiexec.exe /x {AC76BA86-7AD7-1033-7B44-AC0F074E4100} /qn

:: END SCRIPT
:: Return exit code
exit /B %EXIT_CODE%