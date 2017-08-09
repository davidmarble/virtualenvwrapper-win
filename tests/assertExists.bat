@echo off
::
::  verify that a file exists
::
python -B -u assertExists.py %*

goto:eof
setlocal enableDelayedExpansion

if [%1]==[] (
    echo assertExists requires at least a file name as a parameter 1>&2
    exit /b 99
)

if not exist %1 (
    echo.  ^>^> FAIL %config.current_module%:%config.current_test%  [%1] does not exist  1>&2
    set /a config.failing_tests+=1
    exit /b 1
) else (
    echo.  ^>^> OK   %config.current_module%:%config.current_test%  [%1] exists 1>&2
    if not [%2]==[] (
        set /p hookoutput=<%1
        if /I "!hookoutput!"=="%2 " (
            echo.  ^>^> OK   %config.current_module%:%config.current_test%  1>&2
            set /a config.passing_tests+=1
            exit /b 0
        ) else (
            echo.  ^>^> FAIL %config.current_module%:%config.current_test%  [!hookoutput!] and [%2] are not equal  1>&2
            set /a config.failing_tests+=1
            exit /b 1
        )
    ) else (
        echo.     no content check 1>&2
    )
)
