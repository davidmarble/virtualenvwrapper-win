@echo on


:defaults
    set "venvwrapper.original_args=%*"
    set "venvwrapper.default_workon_home=%USERPROFILE%\Envs"
    set "venvwrapper.scriptsdir=Scripts"
::     set "venvwrapper
::
::
set "__callingpath=%CALLINGPATH%"
set "__projdir=%PROJDIR%"


:: print usage if no arguments given
if "%~1"=="" goto:usage


:setprojectdir
    if not defined WORKON_HOME (
        set "WORKON_HOME=%USERPROFILE%\Envs"
    )

    if not defined VIRTUALENVWRAPPER_PROJECT_FILENAME (
        set VIRTUALENVWRAPPER_PROJECT_FILENAME=.project
    )

    if not defined VIRTUAL_ENV (
        echo.
        echo A virtualenv must be activated.
        goto:usage
    )

    set "CALLINGPATH=%CD%"
    set "PROJDIR=%~1"
    pushd "%PROJDIR%" 2>NUL
    if errorlevel 1 (
        popd
        mkdir "%PROJDIR%"
        set "PROJDIR=%CALLINGPATH%\%PROJDIR%"
    ) else (
        set "PROJDIR=%CD%"
        popd
    )

    echo.
    echo.    "%PROJDIR%" is now the project directory for
    echo.    virtualenv "%VIRTUAL_ENV%"

    set /p ="%PROJDIR%">"%VIRTUAL_ENV%\%VIRTUALENVWRAPPER_PROJECT_FILENAME%" <NUL
    call add2virtualenv.bat "%PROJDIR%"


:usage
    echo.
    echo.    Pass in a full or relative path to the project directory.
    echo.    If the directory doesn't exist, it will be created.
    echo.
    :: fall through

:cleanup
    set "CALLINGPATH=%__callingpath%"
    set "PROJDIR=%__projdir%"

    for /f "usebackq delims==" %%v in (`set venvwrapper.`) do @set "%%v="
    goto:eof
