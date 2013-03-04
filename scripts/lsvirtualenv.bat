@echo off

if not defined WORKON_HOME (
    set WORKON_HOME=%USERPROFILE%\Envs
)
    
:LIST
echo.
echo dir /b "%WORKON_HOME%"
echo ==============================================================================
dir /b "%WORKON_HOME%"

:END
