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

if defined VIRTUAL_ENV (
	call "%VIRTUAL_ENV%\Scripts\deactivate.bat" 
)

if defined PYTHONHOME (
	goto HOMEOK
)
FOR /F "tokens=*" %%i in ('whereis python.exe') do set PYTHONHOME=%%~dpi
SET PYTHONHOME=%PYTHONHOME:~0,-1%
:HOMEOK

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

REM In activate.bat, add VIRTUAL_ENV directories to PYTHONPATH and
REM set PYTHONHOME to the VIRTUAL_ENV.
REM This should be a change adopted by virtualenv.
>>"%WORKON_HOME%\%ENVNAME%\Scripts\activate.bat" (
	echo.
	echo.if defined _OLD_VIRTUAL_PYTHONPATH (
	echo.	set PYTHONPATH=%%_OLD_VIRTUAL_PYTHONPATH%%
	echo.	goto SKIPPYTHONPATH
	echo.^)
	echo.
	echo.set _OLD_VIRTUAL_PYTHONPATH=%%PYTHONPATH%%
	echo.
	echo.:SKIPPYTHONPATH
	echo.set PYTHONPATH=%%VIRTUAL_ENV%%\Scripts;%%VIRTUAL_ENV%%\Lib;%%VIRTUAL_ENV%%\Lib\site-packages;%%PYTHONPATH%%
	echo.
	echo.set PYTHONHOME=%%VIRTUAL_ENV%%
)

REM In deactivate.bat, reset PYTHONPATH to its former value
REM and unset VIRTUAL_ENV
>>"%WORKON_HOME%\%ENVNAME%\Scripts\deactivate.bat" (
	echo.
	echo.if defined _OLD_VIRTUAL_PYTHONPATH (
	echo.	set PYTHONPATH=%%_OLD_VIRTUAL_PYTHONPATH%%
	echo.^)
	echo.set VIRTUAL_ENV=
)

ENDLOCAL & call "%WORKON_HOME%\%ENVNAME%\Scripts\activate.bat"
echo.
goto END

:GET_ENVNAME
  set "ENVNAME=%~1"
  shift
  if not "%~1"=="" goto GET_ENVNAME
goto :eof

:END
