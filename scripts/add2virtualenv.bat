@echo off

if [%1]==[] goto USAGE

pushd %1 2>NUL && popd
@if errorlevel 1 (
    echo.
    echo  Directory %1 does not exist
    goto USAGE
)

goto ADD2

:USAGE
echo.
echo  Pass the full path of a directory to add it to the current virtualenv
echo  or non-virtualenv pythonpath.
echo.
goto END

:ADD2
if not defined WORKON_HOME (
    set WORKON_HOME=%USERPROFILE%\Envs
)

if defined PYTHONHOME (
    goto MAIN
)
FOR /F "tokens=*" %%i in ('where python.exe') do set PYTHONHOME=%%~dpi
SET PYTHONHOME=%PYTHONHOME:~0,-1%

:MAIN
echo %1>>"%PYTHONHOME%\Lib\site-packages\virtualenv_path_extensions.pth"
echo.
echo %1 added to %PYTHONHOME%\Lib\site-packages\virtualenv_path_extensions.pth
echo.

:END
