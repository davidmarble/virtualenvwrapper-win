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

REM simple platform assumption
REM using only for checking for Scripts/bin difference
if exist "%~dp0..\pypy.exe" (
  set "SCRIPTS_FOLDER=bin"
) else (
  set "SCRIPTS_FOLDER=Scripts"
)


pushd "%WORKON_HOME%"
REM As of Python 2.7, calling virtualenv.exe causes a new window to open,
REM so call the script directly
REM recent versions of virtualenv does not contain virtualenv-script.py..
REM using relative path instead %PYHOME% for compatibility with pypy
if exist "%~dp0virtualenv-script.py" (
  if exist "%~dp0..\python.exe" (
      python.exe "%~dp0virtualenv-script.py" %ARGS%
   ) else (
      pypy.exe "%~dp0virtualenv-script.py" %ARGS%
   )
) else (
REM using current mkvirtualenv.bat path to get path for virtualenv
  %~dp0virtualenv.exe %ARGS%
)
popd
if errorlevel 2 goto END

REM In activate.bat, keep track of PYTHONPATH.
REM This should be a change adopted by virtualenv.
>>"%WORKON_HOME%\%ENVNAME%\%SCRIPTS_FOLDER%\activate.bat" (
    echo.:: In case user makes changes to PYTHONPATH
    echo.if defined _OLD_VIRTUAL_PYTHONPATH (
    echo.    set "PYTHONPATH=%%_OLD_VIRTUAL_PYTHONPATH%%"
    echo.^) else (
    echo.    set "_OLD_VIRTUAL_PYTHONPATH=%%PYTHONPATH%%"
    echo.^)
)

REM In deactivate.bat, reset PYTHONPATH to its former value
>>"%WORKON_HOME%\%ENVNAME%\%SCRIPTS_FOLDER%\deactivate.bat" (
    echo.
    echo.if defined _OLD_VIRTUAL_PYTHONPATH (
    echo.    set "PYTHONPATH=%%_OLD_VIRTUAL_PYTHONPATH%%"
    echo.^)
)

call "%WORKON_HOME%\%ENVNAME%\%SCRIPTS_FOLDER%\activate.bat"
goto END

:GET_ENVNAME
  set "ENVNAME=%~1"
  shift
  if not "%~1"=="" goto GET_ENVNAME
goto :eof

:END
set PYHOME=
set ENVNAME=
