@echo off

if defined PYTHONHOME (
    set "PYHOME=%PYTHONHOME%"
    goto MAIN
)
if defined VIRTUAL_ENV (
    set "PYHOME=%VIRTUAL_ENV%"
    goto MAIN
)
for /f "usebackq tokens=*" %%a in (`python.exe -c "import sys;print(sys.exec_prefix)"`) do (
    set "PYHOME=%%a"
)

:MAIN
echo.
echo dir /b "%PYHOME%\Lib\site-packages"
echo ==============================================================================
dir /b "%PYHOME%\Lib\site-packages"
echo.
echo %PYHOME%\Lib\site-packages\easy-install.pth
echo ==============================================================================
type "%PYHOME%\Lib\site-packages\easy-install.pth"
echo.
if exist "%PYHOME%\Lib\site-packages\virtualenv_path_extensions.pth" (
    echo %PYHOME%\Lib\site-packages\virtualenv_path_extensions.pth
    echo ==============================================================================
    type "%PYHOME%\Lib\site-packages\virtualenv_path_extensions.pth"
    echo.
)

set PYHOME=

:END