@echo off

if defined PYTHONHOME (
	goto MAIN
)
FOR /F "tokens=*" %%i in ('where python.exe') do set PYTHONHOME=%%~dpi
SET PYTHONHOME=%PYTHONHOME:~0,-1%

:MAIN
if not defined VIRTUAL_ENV (
    echo.
    echo  You must have an active virtualenv to use this command.
    echo.
    goto END
)

if defined _OLD_PYTHONPATH_WITH_GLOBAL_SITE_PACKAGES (
	set PYTHONPATH=%_OLD_PYTHONPATH_WITH_GLOBAL_SITE_PACKAGES%
    set _OLD_PYTHONPATH_WITH_GLOBAL_SITE_PACKAGES=
    echo.
    echo  Enabled global site-packages
    goto END
)
set _OLD_PYTHONPATH_WITH_GLOBAL_SITE_PACKAGES=%PYTHONPATH%
setlocal enabledelayedexpansion
set SEARCHTEXT=\site-packages
set NEWPATH=!_OLD_VIRTUAL_PYTHONPATH:%SEARCHTEXT%=!
endlocal & set PYTHONPATH=%VIRTUAL_ENV%\Scripts;%VIRTUAL_ENV%\Lib;%VIRTUAL_ENV%\Lib\site-packages;%NEWPATH%
echo.
echo  Disabled global site-packages
echo.

:END
