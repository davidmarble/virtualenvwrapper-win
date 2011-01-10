@echo off

if not defined WORKON_HOME (
    set WORKON_HOME=%USERPROFILE%\Envs
)

if not defined VIRTUAL_ENV (
    if not defined PYTHONHOME (
        call :SETPH
    )
)

set _LAST_DIR=%CD%

if defined VIRTUAL_ENV (
    cd %VIRTUAL_ENV%
) else (
    cd %PYTHONHOME%
)

:SETPH
SETLOCAL
for %%i in (python.exe) do set PH=%%~dp$PATH:i
ENDLOCAL & set PYTHONHOME=%PH:~0,-1%

:END
