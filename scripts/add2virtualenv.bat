@echo off
::
::  add2virtualenv PATH  - adds path to module search path in current virtualenv
::

:: set default values
    set "vwadd2.proj_dir=%~1"
    set "vwadd2.site_packages=Lib\site-packages"
    set "vwadd2.pth_file=virtualenv_path_extensions.pth"

:getopts
    :: print usage if no arguments given
    if "%~1"==""        goto:usage & exit /b 0
    if "%~1"=="-h"      goto:usage & exit /b 0
    if "%~1"=="--help"  goto:usage & exit /b 0


:: Find root of Python installation
    call:find_pyhome
    set "vwadd2.pth_path=%vwadd2.pyhome%\%vwadd2.site_packages%\%vwadd2.pth_file%"

    :: make sure proj_dir exists, and set proj_path to point to it
    pushd "%vwadd2.proj_dir%" 2>NUL && popd
    if errorlevel 1 (
        mkdir "%vwadd2.proj_dir%"
    )
    pushd "%vwadd2.proj_dir%"
        set "vwadd2.proj_path=%CD%"
    popd

    :: we can't quote proj_path here, so make sure it's last
    >>%vwadd2.pth_path% echo.%vwadd2.proj_path%
    echo.
    echo.    "%vwadd2.proj_dir%" added to
    echo.    %vwadd2.pth_path%

goto:cleanup
exit /b 0


:find_pyhome
    if defined PYTHONHOME (
        set "vwadd2.pyhome=%PYTHONHOME%"
        goto:eof
    )
    if defined VIRTUAL_ENV (
        set "vwadd2.pyhome=%VIRTUAL_ENV%"
        goto:eof
    )
    for /f "usebackq tokens=*" %%a in (`python.exe -c "import sys;print(sys.exec_prefix)"`) do (
        set "vwadd2.pyhome=%%a"
    )
    goto:eof

:usage
    echo.
    echo.    Pass in a full or relative path of a directory to be added
    echo.    to the current virtualenv or non-virtualenv pythonpath.
    echo.    If the directory doesn't exist, it will be created.
    :: fall through

:cleanup
    for /f "usebackq delims==" %%v in (`set vwadd2.`) do @set "%%v="
    goto:eof
