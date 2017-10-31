@echo off
:: Convenience script to create a project directory and an associated virtualenv
::
:: Syntax:
:: 
:: mkproject PROJ_DIR
::

:: print usage if no arguments given otherwise make a local variable to point at the expected project folder
if [%1]==[] (
	goto:usage
) else (
	set "PROJ_DIR=%PROJECT_HOME%\%1"
)

:: the environment variable PROJECT_HOME must be set for this script to work
if not defined PROJECT_HOME (
    call :error_message set environment variable PROJECT_HOME to the directory where projects are stored.
)
	
:: test if PROJECT_HOME exists (supporting network paths)
pushd %PROJECT_HOME% 2>NUL && popd
:: create it if it doesn't exist
if errorlevel 1 (
    mkdir %PROJECT_HOME%
)

:: test if PROJ_DIR exists (supporting network paths)
pushd "%PROJ_DIR%" 2>NUL && popd
:: create it if it doesn't exist and throw an error if it does
if errorlevel 1 (
    mkdir %PROJ_DIR%
) else (
	call :error_message project %PROJ_DIR% already exists
)

:: use mkvirtualenv to create the environment and link it to the project folder
call mkvirtualenv -a %PROJ_DIR% %1

:: move to the project directory
call cdproject

:: clean up and exit
goto:cleanup

:error_message
    echo.
    echo.    ERROR: %*
    echo.
	goto:cleanup

:usage
	echo.Usage:	mkproject PROJ_DIR
    echo.
    echo.  PROJ_DIR			The name of the project/envirnment to create.
    echo.
    echo.The new environment is automatically activated after being initialized.
	:: fall through
	
:cleanup
	set PROJ_DIR=