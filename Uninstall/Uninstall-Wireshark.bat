:::::::::::::::::::::::::::
:: Wireshark - Uninstall ::
:::::::::::::::::::::::::::
:: Description: Uninstall Wireshark packet sniffer
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL UNINSTALL
SET BINARY=C:\Program Files\Wireshark\uninstall.exe
SET FLAGS=/S
"%BINARY%" %FLAGS%

:: END SCRIPT
:: Return exit code
exit /B %EXIT_CODE%