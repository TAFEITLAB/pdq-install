::::::::::::::::::::::::
:: WinSCP - Uninstall ::
::::::::::::::::::::::::
:: Description: Uninstall WinSCP client for FTP, SFTP, and SCpP
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL UNINSTALL
SET BINARY=C:\Program Files (x86)\WinSCP\unins000.exe
SET FLAGS=/SILENT
"%BINARY%" %FLAGS%

:: END SCRIPT
:: Return exit code
exit /B %EXIT_CODE%