@echo off

if not defined WORKON_HOME (
    set "WORKON_HOME=%USERPROFILE%\Envs"
)
    
:LIST
echo.
echo dir /b /ad "%WORKON_HOME%"
echo ==============================================================================
dir /b /ad "%WORKON_HOME%"
echo.

:END