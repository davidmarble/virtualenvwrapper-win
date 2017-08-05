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
pushd "%WORKON_HOME%"
for /d %%D in (*) do (
    echo %%D
    call virtualenvwrapper_run_hook "get_env_details" %%D
)
popd
goto END

:WORKON

set VENV=%1
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
    call virtualenvwrapper_run_hook "predeactivate"
    set VIRTUALENVWRAPPER_LAST_VIRTUALENV=%VIRTUAL_ENV%
    call "%VIRTUAL_ENV%\Scripts\deactivate.bat"
    call virtualenvwrapper_run_hook "postdeactivate"
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

call virtualenvwrapper_run_hook "preactivate" "%VENV%"
call "%WORKON_HOME%\%VENV%\Scripts\activate.bat"
call virtualenvwrapper_run_hook "postactivate"

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
