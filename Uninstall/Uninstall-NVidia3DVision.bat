:::::::::::::::::::::::::::::::::::::::::
:: NVIDIA 3D Vision Driver - Uninstall ::
:::::::::::::::::::::::::::::::::::::::::
:: Description: Uninstall NVIDIA 3D Vision Driver
:: Version: 1.0
:: Change log:
:::: YYYY-MM-DD - Brief description of change.

:: Make script silent
@echo off

:::: CALL UNINSTALL ::::
"C:\Windows\SysWOW64\RunDll32.EXE" "C:\Program Files\NVIDIA Corporation\Installer2\InstallerCore\NVI2.DLL",UninstallPackage Display.NVIRUSB

:: END SCRIPT
:: Return exit code
exit /B %EXIT_CODE%