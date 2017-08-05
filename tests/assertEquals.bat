@echo off
setlocal

if "%3" == "" (
    echo assertEquals requires two 3 parameters ^(label^, param1^, param2^)^, got %*
    exit /b 99
)
set "LABEL=%1"
shift
if /I "%1" == "%2" (
    echo ^>^> OK   %CURRENT_MODULE%:%LABEL%
    exit /b 0
) else (
    echo ^>^> FAIL %CURRENT_MODULE%:%LABEL%  ^[%1^] and ^[%2^] are not equal
    exit /b 1
)
