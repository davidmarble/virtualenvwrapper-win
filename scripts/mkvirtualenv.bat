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
    goto HOMEOK
)
for /f "usebackq tokens=*" %%a in (`python.exe -c "import sys;print(sys.exec_prefix)"`) do (
    set "PYHOME=%%a"
)
:HOMEOK

set "ENVNAME=%~1"

pushd "%WORKON_HOME%" 2>NUL && popd
@if errorlevel 1 (
    mkdir "%WORKON_HOME%"
)

pushd "%WORKON_HOME%\%ENVNAME%" 2>NUL && popd
@if not errorlevel 1 (
    echo.
    echo.    virtualenv "%ENVNAME%" already exists
    goto end
)

pushd "%WORKON_HOME%"
REM As of Python 2.7, calling virtualenv.exe causes a new window to open,
REM so call the script directly
REM virtualenv.exe %*
python.exe "%PYHOME%\Scripts\virtualenv-script.py" %*
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
goto END

:END
set PYHOME=
set ENVNAME=
