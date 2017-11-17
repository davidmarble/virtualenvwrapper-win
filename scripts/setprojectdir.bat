@echo off
::
::  setprojectdir PATH
::
::      make PATH  and copy it into %VIRTUAL_ENV%\.project
::      call add2virtualenv.bat to include the project path into the
::      python path of the virtualenv.
::
::  sets/creates WORKON_HOME, VIRTUALENVWRAPPER_PROJECT_FILENAME if not defined.
::

:: set default values
    set "vwsetproject.callingpath=%CD%"
    set "vwsetproject.projdir=%~1"

    set "vwsetproject.default_workon_home=%USERPROFILE%\Envs"
    set "vwsetproject.project_fname=.project"

    set "vwsetproject.original_args=%*"
    set "vwsetproject.scriptsdir=Scripts"


:getopts
    :: print usage if no arguments given
    if "%~1"==""        goto:usage & exit /b 0
    if "%~1"=="-h"      goto:usage & exit /b 0
    if "%~1"=="--help"  goto:usage & exit /b 0


:: ensure we can run

    if not defined VIRTUAL_ENV (
        call :error_msg A virtualenv must be activated.
        call :usage
        exit /b 1
    )

    if not defined WORKON_HOME (
        set "WORKON_HOME=%vwsetproject.default_workon_home%"
    )

    if not defined VIRTUALENVWRAPPER_PROJECT_FILENAME (
        set "VIRTUALENVWRAPPER_PROJECT_FILENAME=%vwsetproject.project_fname%"
    )


:: setprojectdir functionality
    :: check projectdir
    pushd "%vwsetproject.projdir%" 2>NUL && popd
    if errorlevel 1 (
        :: it doesn't exist, create it
        mkdir "%vwsetproject.projdir%"
    )

    pushd "%vwsetproject.projdir%"
        set "vwsetproject.proj_path=%CD%"
    popd

    >"%VIRTUAL_ENV%\%VIRTUALENVWRAPPER_PROJECT_FILENAME%" echo.%vwsetproject.proj_path%
    echo.
    echo.    "%vwsetproject.proj_path%" is now the project directory for
    echo.    virtualenv "%VIRTUAL_ENV%"

    call add2virtualenv.bat "%vwsetproject.proj_path%"

goto:cleanup
exit /b 0

:error_msg
    echo.
    echo.    ERROR: %*
    echo.
    goto:eof

:usage
    echo.
    echo.    Pass in a full or relative path to the project directory.
    echo.    If the directory doesn't exist, it will be created:
    echo.
    echo.        setprojectdir PATH
    echo.
    :: fall through

:cleanup
    for /f "usebackq delims==" %%v in (`set vwsetproject.`) do @set "%%v="
    goto:eof
