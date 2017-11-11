@echo off
:: 
::  verify that the two parameters are equal (case insensitively)
::  provide the result on stderr
::

if "%~2" == "" (
    echo assertEquals requires two parameters^, got %*  1>&2
    exit /b 99
)

if /I [%1]==[%2] (
    rem echo.  ^>^> OK   %config.current_module%:%config.current_test%  [%1] and [%2] are equal 1>&2
    call _log OK %config.current_module%:%config.current_test%  [%1] and [%2] are equal
    exit /b 0
) else (
    rem echo.  ^>^> FAIL %config.current_module%:%config.current_test%  [%1] and [%2] are not equal  1>&2
    call _log FAIL %config.current_module%:%config.current_test%  [%1] and [%2] are not equal
    exit /b 1
)
