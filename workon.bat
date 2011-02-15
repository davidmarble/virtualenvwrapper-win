@echo off

if not defined WORKON_HOME (
    set WORKON_HOME=%USERPROFILE%\Envs
)
    
if [%1]==[] goto LIST
goto WORKON

:LIST
echo.
echo Pass a name to activate one of the following virtualenvs:
dir /b "%WORKON_HOME%"
goto END

:WORKON
SETLOCAL EnableDelayedExpansion

pushd "%WORKON_HOME%" 2>NUL && popd
@if errorlevel 1 (
    mkdir "%WORKON_HOME%"
)

pushd "%WORKON_HOME%\%1" 2>NUL && popd
@if errorlevel 1 (
    echo.
    echo virtualenv "%1" does not exist. Create it with "mkvirtualenv %1"
    echo.
    goto end
)

ENDLOCAL & "%WORKON_HOME%\%1\Scripts\activate.bat"

:END
