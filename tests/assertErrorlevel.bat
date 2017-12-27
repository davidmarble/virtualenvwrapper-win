@echo off
::
::  verify that the errorlevel is exactly %1
::

if %ERRORLEVEL%==%1 (
    call _log OK  %config.current_module%:%config.current_test% errorlevel is %ERRORLEVEL% ^< %1
    exit /b 0
) else (
    call _log FAIL %config.current_module%:%config.current_test% errorlevel is %ERRORLEVEL% ^>= %1
    exit /b 1
)
