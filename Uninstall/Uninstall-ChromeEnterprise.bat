::::::::::::::::::::::::::::::::::::::::::
:: Google Chrome enterprise - Uninstall ::
::::::::::::::::::::::::::::::::::::::::::
:: Description: Uninstall Google Chrome Enterprise
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL UNINSTALL ::::
:: Version 67.0.3396.62
msiexec.exe /x {E5CB3D68-6603-34FA-9024-066D9FE9DB4F} /qn

:: END SCRIPT
:: Return exit code
exit /B %EXIT_CODE%