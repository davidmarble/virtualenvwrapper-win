@echo off

if defined VIRTUAL_ENV (
    set "PYHOME=%VIRTUAL_ENV%"
    goto MAIN
)
if defined PYTHONHOME (
    set "PYHOME=%PYTHONHOME%"
) else (
    for /f "usebackq tokens=*" %%a in (`python.exe -c "import sys;print(sys.exec_prefix)"`) do (
        set "PYHOME=%%a"
    )
)

:MAIN
set "_LAST_DIR=%CD%"
cd /d "%PYHOME%"

set PYHOME=
