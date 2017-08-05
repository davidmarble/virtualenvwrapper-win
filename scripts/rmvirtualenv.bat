@echo off

if [%1]==[] goto USAGE
set "ENVNAME=%1"
goto RMVIRTUALENV

:USAGE
echo.
echo.    Pass a name to remove a virtualenv
goto END

:RMVIRTUALENV
if not defined WORKON_HOME (
    set "WORKON_HOME=%USERPROFILE%\Envs"
)

if defined VIRTUAL_ENV (
    if ["%VIRTUAL_ENV%"]==["%WORKON_HOME%\%ENVNAME%"] (
        call virtualenvwrapper_run_hook predeactivate 
        set VIRTUALENVWRAPPER_LAST_VIRTUALENV=%ENVNAME%
        call "%WORKON_HOME%\%ENVNAME%\Scripts\deactivate.bat"
        call virtualenvwrapper_run_hook postdeactivate 
    )
)

if not defined VIRTUALENVWRAPPER_PROJECT_FILENAME (
    set VIRTUALENVWRAPPER_PROJECT_FILENAME=.project
)

pushd "%WORKON_HOME%" 2>NUL && popd
if errorlevel 1 (
    mkdir "%WORKON_HOME%"
)

pushd "%WORKON_HOME%\%ENVNAME%" 2>NUL && popd
if errorlevel 1 (
    echo.
    echo.    virtualenv "%ENVNAME%" does not exist
    goto END
)

set "_CURRDIR=%CD%"
cd /d "%WORKON_HOME%\%ENVNAME%"
if exist "%WORKON_HOME%\%ENVNAME%\%VIRTUALENVWRAPPER_PROJECT_FILENAME%" (
    del "%WORKON_HOME%\%ENVNAME%\%VIRTUALENVWRAPPER_PROJECT_FILENAME%"
)

pushd "%WORKON_HOME%"
    call virtualenvwrapper_run_hook "prermvirtualenv" %ENVNAME%
    rmdir "%1" /s /q
    call virtualenvwrapper_run_hook "postrmvirtualenv" %ENVNAME%
popd
cd /d "%_CURRDIR%"
echo.
echo.    Deleted %WORKON_HOME%\%ENVNAME%
echo.

set _CURRDIR=

:END
