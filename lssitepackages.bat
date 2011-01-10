@echo off

if not defined WORKON_HOME (
    set WORKON_HOME=%USERPROFILE%\Envs
)

if not defined VIRTUAL_ENV (
    if not defined PYTHONHOME (
        call :SETPH
    )
)

SETLOCAL EnableDelayedExpansion
if defined VIRTUAL_ENV (
    set PYDIR=%VIRTUAL_ENV%
) else (
    set PYDIR=%PYTHONHOME%
)

echo.
echo dir /b %PYDIR%\Lib\site-packages
echo ==============================================================================
dir /b %PYDIR%\Lib\site-packages
echo.
echo %PYDIR%\Lib\site-packages\easy-install.pth
echo ==============================================================================
type %PYDIR%\Lib\site-packages\easy-install.pth
echo.
if exist %PYDIR%\Lib\site-packages\virtualenv_path_extensions.pth (
    echo %PYDIR%\Lib\site-packages\virtualenv_path_extensions.pth
    echo ==============================================================================
    type %PYDIR%\Lib\site-packages\virtualenv_path_extensions.pth
    echo.
)
ENDLOCAL
goto END


:SETPH
SETLOCAL
for %%i in (python.exe) do set PH=%%~dp$PATH:i
ENDLOCAL & set PYTHONHOME=%PH:~0,-1%

:END
