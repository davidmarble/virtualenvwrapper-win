@echo off
setlocal enableDelayedExpansion

:: 
::  This command expects two parameters
::   1. the file name (including extension)
::   2. the module name (normally the file name without extension)
::

:: go to directory of this file
cd /d %~dp0

if defined VIRTUAL_ENV (
    call deactivate
)

:config
    set config.unique=%RANDOM%
    set config.workon_home=%TMP%\workon_home!config.unique!
    set config.output=%TMP%\output!config.unique!
    set config.current_file=%~1
    set config.current_module=%~2
    set /a config.found_error=0

if %config.verbose% geq 1 ( 
    echo.==== Starting file: %config.current_file% at %TIME%
)

:setup_env
    set WORKON_HOME=%config.workon_home%
    mkdir %WORKON_HOME%
    mkdir %config.output%
    set VIRTUAL_ENV=

:execute_test
    if %config.supress_output% geq 1 (
        echo on
        call %config.current_file% 1>nul
        @echo off
    ) else (
        echo on
        call %config.current_file%
        @echo off
    )
    if ERRORLEVEL 1     set /a config.found_error+=1

if %config.verbose% geq 1 ( 
    echo.==== Finished file: %config.current_file% at %TIME% ^(passing: %config.passing_tests%, failing: %config.failing_tests%^)
    echo.
)

:teardown_env
    if %config.teardown% geq 1 (
        if defined VIRTUAL_ENV  call deactivate
        rmdir %WORKON_HOME% /s /q 2>nul
        rmdir %config.output% /s /q 2>nul
    ) else (
        pushd %config.output%
    )

if %config.abort_on_fail% geq 1 (
    if %config.found_error% geq 1 (
        echo.
        echo.ABORT_ON_FAIL: %config.current_file% had errors - exiting.
        exit /b 99
    )
)

exit/b
