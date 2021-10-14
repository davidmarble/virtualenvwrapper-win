@echo off
:: 
::  verify that the parameter exists
::  provide the result on stderr
::

if "%1" == "" (
    echo assertExists requires a filename parameters^, got %*  1>&2
    exit /b 99
)

if exist %1 (
    rem echo.  ^>^> OK   %config.current_module%:%config.current_test%  [%1] exists 1>&2
    call _log OK  %config.current_module%:%config.current_test%  [%1] exists
    rem set /a config.passing_tests+=1
    exit /b 0
) else (
    rem echo.  ^>^> FAIL %config.current_module%:%config.current_test%  [%1] does not exist  1>&2
    call _log FAIL  %config.current_module%:%config.current_test%  [%1] does not exist 
    rem set /a config.failing_tests+=1
    exit /b 1
)
