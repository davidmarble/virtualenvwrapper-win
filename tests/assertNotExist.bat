@echo off
:: 
::  verify that the parameters does not exist
::  provide the result on stderr
::

if "%1" == "" (
    echo assertEquals requires a filename parameters^, got %*  1>&2
    exit /b 99
)

if not exist %1 (
    call _log OK  %config.current_module%:%config.current_test%  [%1] does not exist
    exit /b 0
) else (
    call _log FAIL   %config.current_module%:%config.current_test%  [%1] does exist  
    exit /b 1
)
