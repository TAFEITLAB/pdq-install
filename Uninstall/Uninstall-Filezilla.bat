:::::::::::::::::::::::::::
:: Filezilla - Uninstall ::
:::::::::::::::::::::::::::
:: Description: Uninstall Filezilla FTP Client
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL Uninstall
SET BINARY=C:\Program Files\FileZilla FTP Client\uninstall.exe
SET FLAGS=/S
"%BINARY%" %FLAGS%

:: END SCRIPT
:: Return exit code
exit /B %EXIT_CODE%