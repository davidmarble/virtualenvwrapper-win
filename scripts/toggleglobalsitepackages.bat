@echo off

:: see mkvirtualenv for explanation
:platform-detect-python-exe
pypy --version > nul 2>&1
if not errorlevel 1 (
  set "PYTHON_EXE=pypy.exe"
  set "LIB_DIR="
::  echo Found pypy.
  goto :platform-detect-python-end
)  
pypy --version > nul 2>&1
if not errorlevel 1 (
  set "PYTHON_EXE=python.exe"
  set "LIB_DIR=Lib\"
::  echo Found python.
  goto :platform-detect-python-end
)  
echo No python installation found.
goto:eof

:MAIN
if not defined VIRTUAL_ENV (
    echo.
    echo  You must have an active virtualenv to use this command.
    goto END
)

set "file=%VIRTUAL_ENV%\%LIB_DIR%no-global-site-packages.txt"
if exist "%file%" (
    del "%file%"
    echo.
    echo.    Enabled global site-packages
    goto END
) else (
    type nul >>"%file%"
    echo.
    echo.    Disabled global site-packages
)
set file=

:END