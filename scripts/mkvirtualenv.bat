@echo off

if [%1]==[] goto USAGE
goto MKVIRTUALENV

:USAGE
echo.
echo  Pass a name to create a new virtualenv
echo.
goto END

:MKVIRTUALENV
if not defined WORKON_HOME (
    set WORKON_HOME=%USERPROFILE%\Envs
)

if defined PYTHONHOME (
	goto KEEPON
)
for %%i in (python.exe) do set PYTHONHOME=%%~dp$PATH:i
:KEEPON

call :GET_ENVNAME %*

SETLOCAL EnableDelayedExpansion

pushd "%WORKON_HOME%" 2>NUL && popd
@if errorlevel 1 (
    mkdir "%WORKON_HOME%"
)

pushd "%WORKON_HOME%\%ENVNAME%" 2>NUL && popd
@if not errorlevel 1 (
    echo.
    echo  virtualenv "%ENVNAME%" already exists
    echo.
    goto end
)

pushd "%WORKON_HOME%"
REM As of Python 2.7, calling virtualenv.exe causes a new window to open,
REM so call the script directly
REM virtualenv.exe %*
python.exe "%PYTHONHOME%\Scripts\virtualenv-script.py" %* 2>NUL
popd

REM Add unsetting of VIRTUAL_ENV to deactivate.bat
echo set VIRTUAL_ENV=>>"%WORKON_HOME%\%ENVNAME%\Scripts\deactivate.bat"

ENDLOCAL & "%WORKON_HOME%\%ENVNAME%\Scripts\activate.bat"
echo.
goto END

:GET_ENVNAME
  set "ENVNAME=%~1"
  shift
  if not "%~1"=="" goto GET_ENVNAME
goto :eof

:END
