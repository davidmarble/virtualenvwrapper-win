@echo off

if [%1]==[] goto USAGE
goto SETPROJECTDIR

:USAGE
echo.
echo.    Pass in a full or relative path to the project directory.
echo.    If the directory doesn't exist, it will be created.
goto END

:SETPROJECTDIR
if not defined WORKON_HOME (
    set "WORKON_HOME=%USERPROFILE%\Envs"
)

if not defined VIRTUALENVWRAPPER_PROJECT_FILENAME (
    set VIRTUALENVWRAPPER_PROJECT_FILENAME=.project
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

echo.
echo.    "%PROJDIR%" is now the project directory for
echo.    virtualenv "%VIRTUAL_ENV%"

set /p ="%PROJDIR%">"%VIRTUAL_ENV%\%VIRTUALENVWRAPPER_PROJECT_FILENAME%" <NUL
call add2virtualenv.bat "%PROJDIR%"

:END
set CALLINGPATH=
set PROJDIR=