:::::::::::::::::::::::::::::::::
:: VLC Media Player - Uninstall::
:::::::::::::::::::::::::::::::::
:: Description: Uninstall VLC Media Player
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: SCALL UNINSTALL
SET BINARY=C:\Program Files\VideoLAN\VLC\uninstall.exe
SET FLAGS=/S
"%BINARY%" %FLAGS%

:: END SCRIPT
:: Return exit code
exit /B %EXIT_CODE%