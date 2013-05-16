@echo off

if defined _LAST_DIR (
    cd /d "%_LAST_DIR%"
    set _LAST_DIR=
)