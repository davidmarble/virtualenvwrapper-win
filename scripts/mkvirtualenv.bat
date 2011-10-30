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

call :GET_ENVNAME %*

SETLOCAL EnableDelayedExpansion

pushd "%WORKON_HOME%" 2>NUL && popd
@if errorlevel 1 (
    mkdir "%WORKON_HOME%"
)

pushd "%WORKON_HOME%\%ENVNAME%" 2>NUL && popd
@if not errorlevel 1 (
    echo.
    echo  virtualenv "%ENVNAME" already exists
    echo.
    goto end
)

pushd "%WORKON_HOME%"
virtualenv.exe %*
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
