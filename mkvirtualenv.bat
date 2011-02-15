@echo off

if [%1]==[] goto USAGE
goto MKVIRTUALENV

:USAGE
echo.
echo  Pass a name to create a new virtualenv
echo.
goto END

:MKVIRTUALENV
if not defined WORKON_HOME (
    set WORKON_HOME=%USERPROFILE%\Envs
)

SETLOCAL EnableDelayedExpansion

pushd "%WORKON_HOME%" 2>NUL && popd
@if errorlevel 1 (
    mkdir "%WORKON_HOME%"
)

pushd "%WORKON_HOME%\%1" 2>NUL && popd
@if not errorlevel 1 (
    echo.
    echo  virtualenv "%1" already exists
    echo.
    goto end
)

virtualenv.exe "%WORKON_HOME%\%1"

REM Add unsetting of VIRTUAL_ENV to deactivate.bat
echo set VIRTUAL_ENV=>>"%WORKON_HOME%\%1\Scripts\deactivate.bat"

ENDLOCAL & "%WORKON_HOME%\%1\Scripts\activate.bat"
echo.

:END
