:::::::::::::::::::::::::::::::::::::
:: Cisco Packet Tracer - Uninstall ::
:::::::::::::::::::::::::::::::::::::
:: Description: Uninstall Cisco Packet Tracer
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL UNINSTALL ::::
SET BINARY="C:\Program Files\Cisco Packet Tracer 7.2.1\unins000.exe"
SET FLAGS=/S
"%BINARY%" %FLAGS%

:: END SCRIPT
exit