@echo off
::
:: Remove a virtualenv passed in as an argument
::
if "%~1"=="" goto:usage


:rmvirtualenv
    if not defined WORKON_HOME (
        set "WORKON_HOME=%USERPROFILE%\Envs"
    )

    if defined VIRTUAL_ENV (
        if ["%VIRTUAL_ENV%"]==["%WORKON_HOME%\%~1"] call "%WORKON_HOME%\%~1\Scripts\deactivate.bat"
    )

    if not defined VIRTUALENVWRAPPER_PROJECT_FILENAME (
        set VIRTUALENVWRAPPER_PROJECT_FILENAME=.project
    )

    pushd "%WORKON_HOME%" 2>NUL && popd
    if errorlevel 1 (
        mkdir "%WORKON_HOME%"
    )

    pushd "%WORKON_HOME%\%~1" 2>NUL && popd
    if errorlevel 1 (
        echo.
        echo.    virtualenv %1 does not exist
        goto:eof
    )

    pushd "%WORKON_HOME%
        rmdir "%~1" /s /q
    popd

    echo.
    echo.    Deleted %WORKON_HOME%\%~1
    echo.
    goto:eof

:usage
    echo.
    echo.Removes a virtualenv.
    echo.
    echo.Usage:  rmvirtualenv NAME
    echo.
    echo.    NAME       the name of the virtualenv to remove
    echo.
