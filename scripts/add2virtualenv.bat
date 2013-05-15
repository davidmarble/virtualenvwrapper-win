@echo off

if [%1]==[] goto USAGE
goto ADD2

:USAGE
echo.
echo.    Pass in a full or relative path of a directory to be added
echo.    to the current virtualenv or non-virtualenv pythonpath.
echo.    If the directory doesn't exist, it will be created.
goto END

:ADD2
if not defined WORKON_HOME (
    set "WORKON_HOME=%USERPROFILE%\Envs"
)

if not defined VIRTUAL_ENV (
    echo.
    echo A virtualenv must be activated.
    goto USAGE    
)

set "CALLINGPATH=%CD%"
set "PROJDIR=%1"

pushd "%PROJDIR%" 2>NUL
if errorlevel 1 (
    popd
    mkdir "%PROJDIR%"
    set "PROJDIR=%CALLINGPATH%\%PROJDIR%"
) else (
    set "PROJDIR=%CD%"
    popd
)

REM Note that %1 is already quoted by setprojdir or by the prompt
echo "%PROJDIR%">>"%VIRTUAL_ENV%\Lib\site-packages\virtualenv_path_extensions.pth"
echo.
echo.    "%PROJDIR%" added to
echo.    %VIRTUAL_ENV%\Lib\site-packages\virtualenv_path_extensions.pth

:END
set CALLINGPATH=
set PYHOME=
set PROJDIR=
