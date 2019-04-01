:::::::::::::::::::::::::::
:: OWASP ZAP - Uninstall ::
:::::::::::::::::::::::::::
:: Description: Uninstall OWASP Zed Attack proxy
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL Uninstall
:: Version ZAP_2_7_0_windows (Custom TAFEITLAB silent install)
msiexec.exe /x {4D12F37E-DBE0-4FFC-A9BA-5844E62BFBE6} /qn

:: END SCRIPT
:: Return exit code
exit /B %EXIT_CODE%