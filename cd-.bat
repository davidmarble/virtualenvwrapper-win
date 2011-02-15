@echo off

if defined _LAST_DIR (
    cd "%_LAST_DIR%"
    set _LAST_DIR=
    goto END
) 

:END
