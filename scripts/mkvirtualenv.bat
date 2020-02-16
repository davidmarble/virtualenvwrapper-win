@echo off
:: Create a new environment, in the WORKON_HOME.
::
:: Syntax:
:: 
:: mkvirtualenv [-a project_path] [-i package] [-r requirements_file] [virtualenv options] %venvwrapper.envname%
::
:: All command line options except -a, -i, -r, and -h are passed directly 
:: to virtualenv. The new environment is automatically activated after being
:: initialized.
::
:: The -a option can be used to associate an existing project directory
:: with the new environment.
::
:: The -i option can be used to install one or more packages (by repeating 
:: the option) after the environment is created.
::
:: The -r option can be used to specify a text file listing packages to be 
:: installed. The argument value is passed to pip -r to be installed.
::

:defaults
    set "venvwrapper.original_args=%*"
    set "venvwrapper.default_workon_home=%USERPROFILE%\Envs"
    set "venvwrapper.scriptsdir=Scripts"

    :: make sure WORKON_HOME has a useful value
    if not defined WORKON_HOME  set "WORKON_HOME=%venvwrapper.default_workon_home%"
    set "venvwrapper.workon_home=%WORKON_HOME%"

    if defined VIRTUALENV_EXECUTABLE (
        set "venvwrapper.virtualenv_executable=%VIRTUALENV_EXECUTABLE%"
    ) else (
        set "venvwrapper.virtualenv_executable=virtualenv"
    )

:: print usage if no arguments given
if [%1]==[] goto:usage


setlocal 
:: virtualenv options that take a paramter
set "virualenv_param_options=-p --python --extra-search-dir --prompt"

set /a debug=0
:getopts
    set /a ouropt=0
    :: --debug and ---stop xxx should be first on the command line to get most effect
    if [%1]==[---stop]  set "stop=%2" & shift & shift
    if [%1]==[--debug] (
        echo time: %TIME%
        set /a ouropt=1
        set /a debug=1
        :: add verbose mode to virtualenv when in debug mode
        set "venvargs=%venvargs% -v"
    )
    if [%1]==[-h]       goto:usage
    if [%1]==[--help]   goto:usage

    if [%1]==[-a] (
        set /a ouropt=1
        set "project_path=%~2"
        shift
    )

    if [%1]==[-r] (
        set /a ouropt=1
        set "requirements_file=%~2"
        shift
    )

    if [%1]==[-i] (
        set /a ouropt=1
        set "install_packages=%install_packages% %2"
        shift
    )

    set "cur=%1"
    set "quotelesscur=%~1"
    if %debug% equ 1 (
        echo DEBUG cur=%cur% quotelesscur=%quotelesscur%
    )
    :: is cur in virualenv_param_options?
    call set filteredvar=%%virualenv_param_options:*%cur%=%%
    if %debug% equ 1 (
        echo DEBUG filteredvar=%filteredvar%
    )

    if %ouropt% equ 0 (
        if "%quotelesscur:~0,1%"=="-" (
            :: starts with a dash (we found an option)
            if not "%filteredvar%"=="%virualenv_param_options%" (
                :: this is one of virtualenv's options that take a parameter
                set "venvargs=%venvargs% %1 %2"
                shift
            ) else (
                set "venvargs=%venvargs% %1"
            )
        ) else (
            set "envname=%cur%"
            set "qlenvname=%quotelesscur%"
        )
    )

    shift
    if not [%1]==[] goto:getopts
(endlocal & rem export from setlocal block
    set "venvwrapper.project_path=%project_path%"
    set "venvwrapper.requirements_file=%requirements_file%"
    set "venvwrapper.install_packages=%install_packages%"
    set "venvwrapper.virtualenv_args=%venvargs%"
    set "venvwrapper.envname=%envname%"
    set "venvwrapper.quoteless_envname=%qlenvname%"
    set "venvwrapper.stop=%stop%"
    set /a venvwrapper.debug=%debug%
)

if %venvwrapper.debug% equ 1 (
    echo ^<DEBUG options="%venvwrapper.original_args%"^>
    set venvwrapper.
    echo ^</DEBUG^>
    if "%venvwrapper.stop%"=="after-argparse" goto:cleanup
)

if "%venvwrapper.quoteless_envname%"=="" (
    call :error_message You must specify a name for the virtualenv
    call :cleanup
    exit /b 1
)

:: exit any current virtualenv..
if defined VIRTUAL_ENV (
    if exist "%VIRTUAL_ENV%\Scripts\deactivate.bat" (
        call "%VIRTUAL_ENV%\Scripts\deactivate.bat"
    )
    set VIRTUAL_ENV=
)

if not exist "%WORKON_HOME%\*" (
    echo. %WORKON_HOME% is not a directory, creating
    :: try making it.. (let the user see any error messages)
    mkdir "%WORKON_HOME%"
    if errorlevel 1 (
        call :error_message couldn't create directory.
        call :cleanup
        exit /b 2
    )
)

:: make sure we know where the Scripts directory is located
    if defined PYTHONHOME (
        set "venvwrapper.pyhome=%PYTHONHOME%"
    ) else (
        for /f "usebackq tokens=*" %%a in (`python.exe -c "import sys;print(sys.exec_prefix)"`) do (
            set "venvwrapper.pyhome=%%a"
        )
    )

:: Check if venv exists (could be a file name, but don't care - still can't use it)
if exist "%WORKON_HOME%\%venvwrapper.quoteless_envname%" (
    call :error_message virtualenv "%venvwrapper.envname%" already exists
    call :cleanup
    exit /b 3
)

if %venvwrapper.debug% equ 1 (
    echo ^<DEBUG calling-virtualenv^>
    set venvwrapper.
    echo %venvwrapper.virtualenv_executable% %venvwrapper.virtualenv_args% %venvwrapper.envname%
    echo ^</DEBUG^>
    if "%venvwrapper.stop%"=="before-virtualenv" goto:cleanup
)
:: call virtualenv
pushd "%WORKON_HOME%"
    "%venvwrapper.virtualenv_executable%" %venvwrapper.virtualenv_args% %venvwrapper.envname% --prompt="(%venvwrapper.envname%) "
popd
if errorlevel 2 goto:cleanup

:: In activate.bat, keep track of PYTHONPATH.
:: This should be a change adopted by virtualenv.
>>"%WORKON_HOME%\%venvwrapper.quoteless_envname%\Scripts\activate.bat" (
    echo.:: In case user makes changes to PYTHONPATH
    echo.if defined _OLD_VIRTUAL_PYTHONPATH (
    echo.    set "PYTHONPATH=%%_OLD_VIRTUAL_PYTHONPATH%%"
    echo.^) else (
    echo.    set "_OLD_VIRTUAL_PYTHONPATH=%%PYTHONPATH%%"
    echo.^)
)

:: In deactivate.bat, reset PYTHONPATH to its former value
>>"%WORKON_HOME%\%venvwrapper.quoteless_envname%\Scripts\deactivate.bat" (
    echo.
    echo.if defined _OLD_VIRTUAL_PYTHONPATH (
    echo.    set "PYTHONPATH=%%_OLD_VIRTUAL_PYTHONPATH%%"
    echo.^)
)

call "%WORKON_HOME%\%venvwrapper.quoteless_envname%\Scripts\activate.bat"

if %venvwrapper.debug% equ 1 (
    echo DEBUG call setprojectdir.bat "%venvwrapper.project_path%"
)
:: handle -a
if not "%venvwrapper.project_path%"=="" call setprojectdir.bat "%venvwrapper.project_path%"

:: handle -i (can be multiple)
if not "%venvwrapper.install_packages%"=="" call :pipinstall "%venvwrapper.install_packages%"

:: handle -r
if not "%venvwrapper.requirements_file%"=="" (
    call "%VIRTUAL_ENV%\Scripts\pip" install -r "%venvwrapper.requirements_file%"
)

:: Run postmkvirtualenv.bat
if defined VIRTUALENVWRAPPER_HOOK_DIR (
    if exist "%VIRTUALENVWRAPPER_HOOK_DIR%\postmkvirtualenv.bat" (
    	call "%VIRTUALENVWRAPPER_HOOK_DIR%\postmkvirtualenv.bat"
    )
)


goto:cleanup

:dequote
    :: https://ss64.com/nt/syntax-dequote.html
    for /f "delims=" %%A in ('echo %%%1%%') do set %1=%%~A
    goto:eof

:pipinstall
    setlocal
        set packages=%~1
        for /F "tokens=1*" %%g in ("%packages%") do (
            :: XXX should use --disable-pip-version-check (but only if pip version >= 6)
            if not "%%g"=="" call "%VIRTUAL_ENV%\Scripts\pip" install %%g
            if not "%%h"=="" call :pipinstall "%%h"
        )
    endlocal
    goto:eof

:error_message
    echo.
    echo.    ERROR: %*
    echo.
    if %venvwrapper.debug% equ 1 (
        echo ^<DEBUG error-message^>
        echo %*
        echo ^</DEBUG^>
    )
    goto:eof

:debug_message
    if %venvwrapper.debug% equ 1 (
        echo ^<DEBUG message^>
        echo %*
        echo ^</DEBUG^>
    )
    goto:eof


:usage
    echo.
    echo.Usage: mkvirtualenv [mkvirtualenv-options] [virtualenv-options] DEST_DIR
    echo.
    echo.  DEST_DIR              The name of the envirnment to create (must be last).
    echo.
    echo.The new environment is automatically activated after being
    echo.initialized.
    echo.
    echo.mkvirtualenv options:
    echo.  -a project_path       Associate existing path as project directory
    echo.  -i package            Install package in new environment. This option
    echo.                        can be repeated to install more than one package.
    echo   -r requirements_file  requirements_file is passed to
    echo.                        pip install -r requirements_file
    echo.  
    echo.    NOTE: all mkvirtualenv-options must come before virtualenv-options!
    echo. 
    echo.Options not specified above are passed to virtualenv:
    echo.
    echo %venvwrapper.virtualenv_executable% -h
    call %venvwrapper.virtualenv_executable% -h
    echo.
    :: fall through

:cleanup
    if %venvwrapper.debug% equ 1  echo time: %TIME%
    :: clear any variables that shouldn't escape
    for /f "usebackq delims==" %%v in (`set venvwrapper.`) do @set "%%v="
    goto:eof
