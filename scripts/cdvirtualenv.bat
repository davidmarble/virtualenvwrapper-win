@echo off

if not defined WORKON_HOME (
    set WORKON_HOME=%USERPROFILE%\Envs
)

if defined PYTHONHOME (
	goto MAIN
)
FOR /F "tokens=*" %%i in ('whereis python.exe') do set PYTHONHOME=%%~dpi
SET PYTHONHOME=%PYTHONHOME:~0,-1%

:MAIN
set _LAST_DIR=%CD%
cd /d "%PYTHONHOME%"

:END
