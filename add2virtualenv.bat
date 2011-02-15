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

set _LAST_DIR=%CD%

if defined VIRTUAL_ENV (
    echo %1>>"%VIRTUAL_ENV%\Lib\site-packages\virtualenv_path_extensions.pth"
    echo.
    echo %1 added to %VIRTUAL_ENV%\Lib\site-packages\virtualenv_path_extensions.pth
    echo.
) else (
    if defined PYTHONHOME (
        goto KEEPON
    )
    for %%i in (python.exe) do set PYTHONHOME=%%~dp$PATH:i

    :KEEPON
    echo %1>>"%PYTHONHOME%\Lib\site-packages\virtualenv_path_extensions.pth"
    echo.
    echo %1 added to %PYTHONHOME%\Lib\site-packages\virtualenv_path_extensions.pth
    echo.
)

:END
