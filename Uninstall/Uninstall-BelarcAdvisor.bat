::::::::::::::::::::::
:: Belarc Advisor - Uninstall ::
::::::::::::::::::::::
:: Description: Uninstall Belarc Advisor
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL UNINSTALL ::::
:: Call uninstall string, as per registry
"C:\Program Files (x86)\Belarc\BelarcAdvisor\Uninstall.exe" /s "C:\Program Files (x86)\Belarc\BelarcAdvisor\INSTALL.LOG"

:: END SCRIPT
:: Return exit code
exit /B %EXIT_CODE%