@echo off

if not defined WORKON_HOME (
    set WORKON_HOME=%USERPROFILE%\Envs
)

if defined PYTHONHOME (
	goto MAIN
)
FOR /F "tokens=*" %%i in ('whereis python.exe') do set PYTHONHOME=%%~dpi
SET PYTHONHOME=%PYTHONHOME:~0,-1%

:MAIN
echo.
echo dir /b "%PYTHONHOME%\Lib\site-packages"
echo ==============================================================================
dir /b "%PYTHONHOME%\Lib\site-packages"
echo.
echo %PYTHONHOME%\Lib\site-packages\easy-install.pth
echo ==============================================================================
type "%PYTHONHOME%\Lib\site-packages\easy-install.pth"
echo.
if exist "%PYTHONHOME%\Lib\site-packages\virtualenv_path_extensions.pth" (
    echo %PYTHONHOME%\Lib\site-packages\virtualenv_path_extensions.pth
    echo ==============================================================================
    type "%PYTHONHOME%\Lib\site-packages\virtualenv_path_extensions.pth"
    echo.
)
goto END

:END
