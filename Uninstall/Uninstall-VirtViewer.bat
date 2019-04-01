::::::::::::::::::::::
:: VirtViewer - Uninstall ::
::::::::::::::::::::::
:: Description: Uninstall VirtViewer virtual machine manager
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL UNINSTALL ::::
:: Version 5.0.256
msiexec.exe /x {6E998B6D-DDD5-4BB9-BC83-C86F76D9E0CE} /qn

:: END SCRIPT
:: Return exit code
exit /B %EXIT_CODE%