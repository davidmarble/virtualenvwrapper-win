@echo off

:MAIN
if not defined VIRTUAL_ENV (
    echo.
    echo  You must have an active virtualenv to use this command.
    goto END
)

set "file=%VIRTUAL_ENV%\Lib\no-global-site-packages.txt"
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
set file=

:END