@echo off

if [%1]==[] goto USAGE
goto RMVIRTUALENV

:USAGE
echo.
echo.    Pass a name to remove a virtualenv
goto END

:RMVIRTUALENV
if not defined WORKON_HOME (
    set "WORKON_HOME=%USERPROFILE%\Envs"
)

if defined VIRTUAL_ENV (
    if [%VIRTUAL_ENV%]==[%WORKON_HOME%\%1] call "%WORKON_HOME%\%1\Scripts\deactivate.bat"
)

if not defined VIRTUALENVWRAPPER_PROJECT_FILENAME (
    set VIRTUALENVWRAPPER_PROJECT_FILENAME=.project
)

pushd "%WORKON_HOME%" 2>NUL && popd
if errorlevel 1 (
    mkdir "%WORKON_HOME%"
)

pushd "%WORKON_HOME%\%1" 2>NUL && popd
if errorlevel 1 (
    echo.
    echo.    virtualenv "%1" does not exist
    goto END
)

set "_CURRDIR=%CD%"
cd /d "%WORKON_HOME%\%1"
if exist "%WORKON_HOME%\%1\%VIRTUALENVWRAPPER_PROJECT_FILENAME%" (
    del "%WORKON_HOME%\%1\%VIRTUALENVWRAPPER_PROJECT_FILENAME%"
)

call folder_delete.bat *
cd ..
rmdir "%1"
cd /d "%_CURRDIR%"
echo.
echo.    Deleted %WORKON_HOME%\%1 
echo.

set _CURRDIR=

:END