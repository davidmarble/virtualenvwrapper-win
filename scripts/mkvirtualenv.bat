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
    call "%VIRTUAL_ENV%\Scripts\deactivate.bat" 
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

call "%WORKON_HOME%\%ENVNAME%\Scripts\activate.bat"

REM Run postmkvirtualenv.bat

if defined VIRTUALENVWRAPPER_HOOK_DIR (
    if exist "%VIRTUALENVWRAPPER_HOOK_DIR%\postmkvirtualenv.bat" (
    	call "%VIRTUALENVWRAPPER_HOOK_DIR%\postmkvirtualenv.bat"
    )
)


goto END

:GET_ENVNAME
  set "ENVNAME=%~1"
  shift
  if not "%~1"=="" goto GET_ENVNAME
goto :eof

:END
set PYHOME=
set ENVNAME=
