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
if defined VIRTUAL_ENV (
    call "%VIRTUAL_ENV%\Scripts\deactivate.bat"
)

pushd "%WORKON_HOME%" 2>NUL && popd
if errorlevel 1 (
    mkdir "%WORKON_HOME%"
)

pushd "%WORKON_HOME%\%1" 2>NUL && popd
if errorlevel 1 (
    echo.
    echo.    virtualenv "%1" does not exist. Create it with "mkvirtualenv %1"
    goto END
)

call "%WORKON_HOME%\%1\Scripts\activate.bat"

if EXIST "%WORKON_HOME%\%1\%VIRTUALENVWRAPPER_PROJECT_FILENAME%" (
    call cdproject.bat
)

:END