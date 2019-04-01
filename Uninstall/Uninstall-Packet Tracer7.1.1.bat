:::::::::::::::::::::::::::::::::::::
:: Cisco Packet Tracer - Uninstall ::
:::::::::::::::::::::::::::::::::::::
:: Description: Uninstall Cisco Packet Tracer
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL UNISTALL
SET BINARY=C:\Program Files\Cisco Packet Tracer 7.1.1\unins000.exe
SET FLAGS=/SILENT
"%BINARY%" %FLAGS%

:: END SCRIPT
:: Return exit code
exit /B %EXIT_CODE%