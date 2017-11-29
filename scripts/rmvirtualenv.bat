@echo off
::
:: Remove a virtualenv passed in as an argument
::
if "%~1"=="" goto:usage

:: see mkvirtualenv for explanation
:platform-detect-scripts-folder

echo %~dp0 | FINDSTR /r "[\\]bin[\\].$" > nul 2>&1
if not errorlevel 1 (
  set "SCRIPTS_FOLDER=bin"
::  echo Scripts are in bin\
  goto :platform-detect-end
)  

echo %~dp0 | FINDSTR /r "[\\]Scripts[\\].$" > nul 2>&1
if not errorlevel 1 (
  set "SCRIPTS_FOLDER=Scripts"
::  echo Scripts are in Scripts\
  goto :platform-detect-end
)  

echo No scripts folder found. Platform not supported.
goto :END 

:platform-detect-end


:rmvirtualenv
    if not defined WORKON_HOME (
        set "WORKON_HOME=%USERPROFILE%\Envs"
    )

    if defined VIRTUAL_ENV (
        if ["%VIRTUAL_ENV%"]==["%WORKON_HOME%\%~1"] call "%WORKON_HOME%\%~1\%SCRIPTS_FOLDER%\deactivate.bat"
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
    
:END    
