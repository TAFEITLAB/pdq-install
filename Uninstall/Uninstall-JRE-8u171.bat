::::::::::::::::::::::::::::::::::::::::::::::::
:: Java Runtime Environment 8u171 - Uninstall ::
::::::::::::::::::::::::::::::::::::::::::::::::
:: Description: Uninstall Jave Runtime Environment version 8 update 171
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL UNINSTALL
:: Method 1 - WMIC with 2-digit ID
wmic product where "IdentifyingNumber like '{26A24AE4-039D-4CA4-87B4-2F864180__F_}'" call uninstall /nointeractive >> "%LOGPATH%\%LOGFILE%"
:: Method 2 - WMIC with 3-digit ID
wmic product where "IdentifyingNumber like '{26A24AE4-039D-4CA4-87B4-2F64180___F_}'" call uninstall /nointeractive >> "%LOGPATH%\%LOGFILE%"
:: Method 3 - WMIC by similar name
wmic product where "name like 'Java 8 Update %% (64-bit)'" uninstall /nointeractive

:: END SCRIPT
:: Return exit code
exit /B %EXIT_CODE%