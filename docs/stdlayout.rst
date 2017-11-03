

@echo off
::
::  name - what it does
::
::

:: set default values
    set "prefix.original_args=%*"
    set "prefix.dirname=..default value.."


:: handle options
if "%~1"=="" goto:usage & exit /b 0
setlocal
set /a __debug=0
:getopts
    set /a __handled=0
    
    if "%~1"=="--debug" (
        set /a __debug=1
	set /a __handled=1
    )
    if "%~1"=="-h"      goto:usage & exit /b 0
    if "%~1"=="--help"  goto:usage & exit /b 0

    if "%~1"=="--arg-with-value" (
        set "__arg_with_value=%~2"
	set /a __handled=1
    )

    if %__handled% equ 0 (
        set "__positional_args=%__positional_args% %1"
    )

    shift
    if __debug equ 1 (
        echo.DEBUG:args %*
    )
    if not "%~1"=="" goto:getopts
(endlocal & rem export from setlocal block
    set /a prefix.debug=%__debug%
    set "prefix.args=%__positional_args%"
    set "prefix.arg_with_value=%__arg_with_value%"
    set "prefix.dirname=..override dirname based on options.."
)

:: set initial values
   set "prefix.filename=%prefix.dirname%\.filename"


:: script code goes here..
    :: ...
    if errorlevel 1 (
        call :error_message text for error message.
	call : cleanup
	exit /b 1
    )
    :: ...


:: (end-of-script)
goto:cleanup
exit /b 0

:: (start-of-subroutines)

:error_message
    echo.
    echo.    ERROR: %*
    echo.
    goto:eof


:usage
    echo.
    echo.toolname - description
    echo.
    echo.Usage:  toolname [...args...]
    echo.
    echo.Description
    echo.
    echo.tool options:
    echo.  -y            answer yes to all prompts
    echo.  -f|--force    force execution
    echo.  --name NAME   set name to NAME
    echo. ...
    echo.
    :: fall through

:cleanup
    for /f "usebackq delims==" %%v in (`set prefix.`) do @set "%%v="
    goto:eof	
    
