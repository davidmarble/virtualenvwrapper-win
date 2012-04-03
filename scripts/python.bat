@echo off

if defined PYTHONHOME (
	goto MAIN
)
FOR /F "tokens=*" %%i in ('where python.exe') do set PYTHONHOME=%%~dpi
SET PYTHONHOME=%PYTHONHOME:~0,-1%

:MAIN
SETLOCAL EnableDelayedExpansion
if defined VIRTUAL_ENV (
    set PY="%VIRTUAL_ENV%\Scripts\python.exe"
) else (
    set PY="%PYTHONHOME%\python.exe"
)
ENDLOCAL & %PY% %*

:END
