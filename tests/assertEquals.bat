@echo off
:: 
::  verify that the two parameters are equal (case insensitively)
::  provide the result on stderr
::

if "%2" == "" (
    echo assertEquals requires two parameters^, got %*  1>&2
    exit /b 99
)

if /I [%1]==[%2] (
    echo.  ^>^> OK   %config.current_module%:%config.current_test%  1>&2
    set /a config.passing_tests+=1
    exit /b 0
) else (
    echo.  ^>^> FAIL %config.current_module%:%config.current_test%  [%1] and [%2] are not equal  1>&2
    set /a config.failing_tests+=1
    exit /b 1
)
