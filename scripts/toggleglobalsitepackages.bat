@echo off

if defined PYTHONHOME (
    set "PYHOME=%PYTHONHOME%"
    goto MAIN
)
for /f "usebackq tokens=*" %%a in (`python.exe -c "import sys;print(sys.exec_prefix)"`) do (
    set "PYHOME=%%a"
)

:MAIN
if not defined VIRTUAL_ENV (
    echo.
    echo  You must have an active virtualenv to use this command.
    goto END
)

set "file=%PYHOME%\Lib\no-global-site-packages.txt"
if exist "%file%" (
    del "%file%"
    echo.
    echo.    Enabled global site-packages
    goto END
) else (
    type nul >>"%file%"
    echo.
    echo.    Disabled global site-packages
)

:END
set file=
set PYHOME=
