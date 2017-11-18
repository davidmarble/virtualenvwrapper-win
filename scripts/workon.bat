@echo off

if not defined WORKON_HOME (
    set "WORKON_HOME=%USERPROFILE%\Envs"
)

if not defined VIRTUALENVWRAPPER_PROJECT_FILENAME (
    set VIRTUALENVWRAPPER_PROJECT_FILENAME=.project
)

if [%1]==[] goto LIST
goto WORKON

:LIST
echo.
echo Pass a name to activate one of the following virtualenvs:
echo ==============================================================================
dir /b /ad "%WORKON_HOME%"
goto END

:WORKON

set "VENV=%~1"
shift

:LOOP
if not "%1"=="" (
    if "%1"=="-c" (
        SET CHANGEDIR=1
        shift
    )
    shift
    goto :LOOP
)

if defined VIRTUAL_ENV (
    call "%VIRTUAL_ENV%\Scripts\deactivate.bat"
)

pushd "%WORKON_HOME%" 2>NUL && popd
if errorlevel 1 (
    mkdir "%WORKON_HOME%"
)

pushd "%WORKON_HOME%\%VENV%" 2>NUL && popd
if errorlevel 1 (
    echo.
    echo.    virtualenv "%VENV%" does not exist.
    echo.    Create it with "mkvirtualenv %1"
    goto END
)

if not exist "%WORKON_HOME%\%VENV%\Scripts\activate.bat" (
    echo.
    echo.    %WORKON_HOME%\%VENV%
    echo.    doesn't contain a virtualenv ^(yet^).
    echo.    Create it with "mkvirtualenv %VENV%"
    goto END
)

call "%WORKON_HOME%\%VENV%\Scripts\activate.bat"
if defined WORKON_OLDTITLE (
    title %1 ^(VirtualEnv^)
)

if exist "%WORKON_HOME%\%VENV%\%VIRTUALENVWRAPPER_PROJECT_FILENAME%" (
    call cdproject.bat
) else (
    if "%CHANGEDIR%"=="1" (
        cd /d "%WORKON_HOME%\%VENV%"
    )
)

:END
