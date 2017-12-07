@echo off
::
:: Convenience script to create a project directory and an associated virtualenv
::
:: Syntax:
:: 
:: mkproject PROJ_DIR
::

:getopts
    :: print usage if no arguments given
    if "%~1"==""        goto:usage & exit /b 0
    if "%~1"=="-h"      goto:usage & exit /b 0
    if "%~1"=="--help"  goto:usage & exit /b 0

:: the environment variable PROJECT_HOME must be set for this script to work
if not defined PROJECT_HOME (
    call :error_message set environment variable PROJECT_HOME to the directory where projects are stored.
    exit /b 1
)

set "PROJ_DIR=%PROJECT_HOME%\%~1"

:: test if PROJECT_HOME exists (supporting network paths) and create it if it doesn't exist
pushd "%PROJECT_HOME%" 2>NUL && popd
if errorlevel 1 (
    mkdir "%PROJECT_HOME%"
)

:: test if PROJ_DIR exists
pushd "%PROJ_DIR%" 2>NUL && popd
if errorlevel 1 (
    mkdir "%PROJ_DIR%"
) else (
    call :error_message project %PROJ_DIR% already exists
    exit /b 2
)

:: use mkvirtualenv to create the environment and link it to the project folder
call mkvirtualenv -a "%PROJ_DIR%" "%~1"

:: move to the project directory
call cdproject

:: clean up and exit
goto:cleanup
exit /b 0

:error_message
    echo.
    echo.    ERROR: %*
    echo.
    goto:cleanup

:usage
    echo.Usage:    mkproject PROJ_DIR
    echo.
    echo.  PROJ_DIR            The name of the project/envirnment to create.
    echo.
    echo.The new environment is automatically activated after being initialized.
    :: fall through
    
:cleanup
    set PROJ_DIR=
    goto:eof
