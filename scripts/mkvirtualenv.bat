@echo off

if [%1]==[] goto USAGE
goto MKVIRTUALENV

:USAGE
echo.
echo.    Pass a name to create a new virtualenv
goto END

:MKVIRTUALENV
if not defined WORKON_HOME (
    set "WORKON_HOME=%USERPROFILE%\Envs"
)

if defined VIRTUAL_ENV (
    call virtualenvwrapper_run_hook "predeactivate"
    set VIRTUALENVWRAPPER_LAST_VIRTUALENV=%ENVNAME%
    call "%VIRTUAL_ENV%\Scripts\deactivate.bat" 
    call virtualenvwrapper_run_hook "postdeactivate"
)

if defined PYTHONHOME (
    set "PYHOME=%PYTHONHOME%"
    goto MAIN
)
for /f "usebackq tokens=*" %%a in (`python.exe -c "import sys;print(sys.exec_prefix)"`) do (
    set "PYHOME=%%a"
)

:MAIN
REM Copy all arguments, then set ENVNAME to the last argument
set "ARGS=%*"
call :GET_ENVNAME %*

pushd "%WORKON_HOME%" 2>NUL && popd
if errorlevel 1 (
    mkdir "%WORKON_HOME%"
)

pushd "%WORKON_HOME%\%ENVNAME%" 2>NUL && popd
if not errorlevel 1 (
    echo.
    echo.    virtualenv "%ENVNAME%" already exists
    goto END
)

pushd "%WORKON_HOME%"
REM As of Python 2.7, calling virtualenv.exe causes a new window to open,
REM so call the script directly
REM recent versions of virtualenv does not contain virtualenv-script.py..
if exist "%PYHOME%\Scripts\virtualenv-script.py" (
    python.exe "%PYHOME%\Scripts\virtualenv-script.py" %ARGS%
) else (
    virtualenv.exe %ARGS%
)
:: premkvirtualenv is supposed to be called after virtualenv is created
:: but before it is pointed to.. Not sure how to do that..
:: this https://bitbucket.org/virtualenvwrapper/virtualenvwrapper/src/d2e5303bbe6ab2f33d318fadb71bc3162108e4cc/virtualenvwrapper.sh?at=master&fileviewer=file-view-default#virtualenvwrapper.sh-476
:: is where it happens in the mother-project..
call virtualenvwrapper_run_hook "premkvirtualenv"
popd
if errorlevel 2 goto END

REM In activate.bat, keep track of PYTHONPATH.
REM This should be a change adopted by virtualenv.
>>"%WORKON_HOME%\%ENVNAME%\Scripts\activate.bat" (
    echo.:: In case user makes changes to PYTHONPATH
    echo.if defined _OLD_VIRTUAL_PYTHONPATH (
    echo.    set "PYTHONPATH=%%_OLD_VIRTUAL_PYTHONPATH%%"
    echo.^) else (
    echo.    set "_OLD_VIRTUAL_PYTHONPATH=%%PYTHONPATH%%"
    echo.^)
)

REM In deactivate.bat, reset PYTHONPATH to its former value
>>"%WORKON_HOME%\%ENVNAME%\Scripts\deactivate.bat" (
    echo.
    echo.if defined _OLD_VIRTUAL_PYTHONPATH (
    echo.    set "PYTHONPATH=%%_OLD_VIRTUAL_PYTHONPATH%%"
    echo.^)
)

call virtualenvwrapper_run_hook "preactivate" "%ENVNAME%"
call "%WORKON_HOME%\%ENVNAME%\Scripts\activate.bat"
call virtualenvwrapper_run_hook "postactivate"

call virtualenvwrapper_run_hook postmkvirtualenv


goto END

:GET_ENVNAME
  set "ENVNAME=%~1"
  shift
  if not "%~1"=="" goto GET_ENVNAME
goto :eof

:END
set PYHOME=
set ENVNAME=
