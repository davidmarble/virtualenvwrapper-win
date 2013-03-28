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
    set "WORKON_HOME=%USERPROFILE%\Envs"
)

if defined PYTHONHOME (
    set "PYHOME=%PYTHONHOME%"
    goto MAIN
)
for /f "usebackq tokens=*" %%a in (`python.exe -c "import sys;print(sys.exec_prefix)"`) do (
    set "PYHOME=%%a"
)

:MAIN
REM Note that %1 is already quoted by setprojdir or by the prompt
echo %1>>"%PYHOME%\Lib\site-packages\virtualenv_path_extensions.pth"
echo.
echo.    %1 added to 
echo.    %PYHOME%\Lib\site-packages\virtualenv_path_extensions.pth
echo.

:END
set PYHOME=