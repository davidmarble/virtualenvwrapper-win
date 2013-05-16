@echo off

if defined PYTHONHOME (
    set "PYHOME=%PYTHONHOME%"
    goto MAIN
)
if defined VIRTUAL_ENV (
    set "PYHOME=%VIRTUAL_ENV%"
    goto MAIN
)
for /f "usebackq tokens=*" %%a in (`python.exe -c "import sys;print(sys.exec_prefix)"`) do (
    set "PYHOME=%%a"
)

:MAIN
set "_LAST_DIR=%CD%"
cd /d "%PYHOME%\Lib\site-packages"
set PYHOME=

:END