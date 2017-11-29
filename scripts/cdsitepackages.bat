@echo off

:: see mkvirtualenv for explanation
:platform-detect-python-exe
pypy --version > nul 2>&1
if not errorlevel 1 (
  set "PYTHON_EXE=pypy.exe"
  echo Found pypy.
  goto :platform-detect-python-end
)  
pypy --version > nul 2>&1
if not errorlevel 1 (
  set "PYTHON_EXE=python.exe"
  echo Found python.
  goto :platform-detect-python-end
)  
echo No python installation found.
goto :END

:platform-detect-python-end

if defined PYTHONHOME (
    set "PYHOME=%PYTHONHOME%"
    goto MAIN
)
if defined VIRTUAL_ENV (
    set "PYHOME=%VIRTUAL_ENV%"
    goto MAIN
)
for /f "usebackq tokens=*" %%a in (`%PYTHON_EXE% -c "import sys;print(sys.exec_prefix)"`) do (
    set "PYHOME=%%a"
)

:MAIN
set "_LAST_DIR=%CD%"
cd /d "%PYHOME%\Lib\site-packages"
set PYHOME=

:END