@echo off
::
:: Convenience script to create a virtualenv and add it to jupyter
::
:: Syntax:
:: 
:: mkjupyter ENV_NAME
::

:getopts
    :: print usage if no arguments given
    if "%~1"==""        goto:usage & exit /b 0
    if "%~1"=="-h"      goto:usage & exit /b 0
    if "%~1"=="--help"  goto:usage & exit /b 0

:: use mkvirtualenv to create the environment with the ipython kernel
call mkvirtualenv -i ipykernel "%~1"

:: install the kernel in jupyter
python -m ipykernel install --user --name="%~1"

:: clean up and exit
goto:cleanup
exit /b 0

:error_message
    echo.
    echo.    ERROR: %*
    echo.
    goto:cleanup

:usage
    echo.Usage:    mkjupyter ENV_NAME
    echo.
    echo.  ENV_NAME            The name of the environment to create.
    echo.
    echo.The new environment is automatically activated after being initialized.
    :: fall through
    
:cleanup
    goto:eof
