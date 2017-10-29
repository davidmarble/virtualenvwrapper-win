@echo off
:: Call a hook if defined. Usage:
:: 
::     call virtualenvwrapper_run_hook "postactivate"
::
if not defined venvwrapper.debug set /a venvwrapper.debug=0

if defined venvwrapper.debug (
    if %venvwrapper.debug% equ 1 (
        echo RUN_HOOK[%1][%*] workon_home=%WORKON_HOME% hookdir=%VIRTUALENVWRAPPER_HOOK_DIR%
    )
)

setlocal

if not defined WORKON_HOME (
   echo ERROR WORKON_HOME not set
   goto:eof
)
if defined VIRTUALENVWRAPPER_HOOK_DIR (
    if defined venvwrapper.debug (
        if %venvwrapper.debug% equ 1 (
            echo DEBUG: WE HAVE the HOOK DIR [%VIRTUALENVWRAPPER_HOOK_DIR%]
        )
    )
    if "%VIRTUALENVWRAPPER_HOOK_DIR%" == "" (
        echo ERROR empty VIRTUALENVWRAPPER_HOOK_DIR variable
        exit 1
    )
)
set HOOK_NAME=%~1
shift
call :%HOOK_NAME% %*
if defined venvwrapper.debug (
    if %venvwrapper.debug% equ 1 (
        echo AFTER_HOOK[%HOOK_NAME%]
    )
)
goto :exit


:get_env_details

    :: $VIRTUALENVWRAPPER_HOOK_DIR/get_env_details.bat is run when workon is run
    :: with no arguments and a list of the virtual environments is
    :: printed. The hook is run once for each environment, after the name is
    :: printed, and can print additional information about that environment.

    :: call global hook
    set "ENVNAME=%~2"
    if defined VIRTUALENVWRAPPER_HOOK_DIR (
        if exist "%VIRTUALENVWRAPPER_HOOK_DIR%\get_env_details.bat" (
            endlocal
            call "%VIRTUALENVWRAPPER_HOOK_DIR%\get_env_details.bat" %ENVNAME%
        )
    )
    :: call local hook
    if exist "%WORKON_HOME%\%ENVNAME%\Scripts\get_env_details.bat" (
        endlocal
        call "%WORKON_HOME%\%ENVNAME%\Scripts\get_env_details.bat" %ENVNAME%
    )
    goto:eof

:preactivate
    set "ENVNAME=%~2"
    :: The global $VIRTUALENVWRAPPER_HOOK_DIR/preactivate script is run 
    :: before the new environment is enabled. The environment name is 
    :: passed as the first argument.
    :: 
    :: The local $VIRTUAL_ENV/bin/preactivate hook is run before the new 
    :: environment is enabled. The environment name is passed as the first
    :: argument.
    if defined VIRTUALENVWRAPPER_HOOK_DIR (
        if exist "%VIRTUALENVWRAPPER_HOOK_DIR%\preactivate.bat" (
            endlocal
            call "%VIRTUALENVWRAPPER_HOOK_DIR%\preactivate.bat"
        )
    )
    :: call local hook
    if exist "%WORKON_HOME%\%ENVNAME%\Scripts\preactivate.bat" (
        endlocal
        call "%WORKON_HOME%\%ENVNAME%\Scripts\preactivate.bat"
    )
    goto:eof

:postactivate
    
    :: The global $VIRTUALENVWRAPPER_HOOK_DIR/postactivate script is sourced
    :: after the new environment is enabled. $VIRTUAL_ENV refers to the new 
    :: environment at the time the script runs.
    ::
    :: The local $VIRTUAL_ENV/bin/postactivate script is sourced after 
    :: the new environment is enabled. $VIRTUAL_ENV refers to the new 
    :: environment at the time the script runs.

    :: call global hook
    if defined VIRTUALENVWRAPPER_HOOK_DIR (
        if exist "%VIRTUALENVWRAPPER_HOOK_DIR%\postactivate.bat" (
            endlocal
            call "%VIRTUALENVWRAPPER_HOOK_DIR%\postactivate.bat"
        )
    )
    :: call local hook
    if exist "%WORKON_HOME%\%ENVNAME%\Scripts\postactivate.bat" (
        endlocal
        call "%WORKON_HOME%\%ENVNAME%\Scripts\postactivate.bat"
    )

    goto:eof

:predeactivate
    :: The local $VIRTUAL_ENV/bin/predeactivate script is sourced before
    :: the current environment is deactivated, and can be used to
    :: disable or clear settings in your environment. $VIRTUAL_ENV
    :: refers to the old environment at the time the script runs.

    :: The global $VIRTUALENVWRAPPER_HOOK_DIR/predeactivate script is
    :: sourced before the current environment is
    :: deactivated. $VIRTUAL_ENV refers to the old environment at the
    :: time the script runs.
    if defined VIRTUALENVWRAPPER_HOOK_DIR (
        if exist "%VIRTUALENVWRAPPER_HOOK_DIR%\postdeactivate.bat" (
            endlocal
            call "%VIRTUALENVWRAPPER_HOOK_DIR%\postdeactivate.bat"
        )
    )
    :: call local hook
    if exist "%WORKON_HOME%\%ENVNAME%\Scripts\postdeactivate.bat" (
        endlocal
        call "%WORKON_HOME%\%ENVNAME%\Scripts\postdeactivate.bat"
    )
    goto:eof

:postdeactivate
    :: The $VIRTUAL_ENV/bin/postdeactivate script is sourced after the
    :: current environment is deactivated, and can be used to disable or
    :: clear settings in your environment. The path to the environment
    :: just deactivated is available in
    :: $VIRTUALENVWRAPPER_LAST_VIRTUALENV.

    if defined VIRTUALENVWRAPPER_HOOK_DIR (
        if exist "%VIRTUALENVWRAPPER_HOOK_DIR%\postdeactivate.bat" (
            endlocal
            call "%VIRTUALENVWRAPPER_HOOK_DIR%\postdeactivate.bat"
        )
    )
    :: call local hook
    if exist "%WORKON_HOME%\%ENVNAME%\Scripts\postdeactivate.bat" (
        endlocal
        call "%WORKON_HOME%\%ENVNAME%\Scripts\postdeactivate.bat"
    )
    goto:eof


:premkvirtualenv
    :: $VIRTUALENVWRAPPER_HOOK_DIR/premkvirtualenv is run as an external
    :: program after the virtual environment is created but before the
    :: current environment is switched to point to the new env. The
    :: current working directory for the script is $WORKON_HOME and the
    :: name of the new environment is passed as an argument to the
    :: script.
    set "ENVNAME=%~2"
    if defined VIRTUALENVWRAPPER_HOOK_DIR (
        if exist "%VIRTUALENVWRAPPER_HOOK_DIR%\premkvirtualenv.bat" (
            endlocal
            cd /d %WORKON_HOME%
            call "%VIRTUALENVWRAPPER_HOOK_DIR%\premkvirtualenv.bat" %ENVNAME%
        )
    )
    goto:eof

:postmkvirtualenv
    :: $VIRTUALENVWRAPPER_HOOK_DIR/postmkvirtualenv is sourced after the
    :: new environment is created and activated. If the -a
    :: <project_path> flag was used, the link to the project directory
    :: is set up before this script is sourced.
    if defined VIRTUALENVWRAPPER_HOOK_DIR (
        if exist "%VIRTUALENVWRAPPER_HOOK_DIR%\postmkvirtualenv.bat" (
            endlocal
            call "%VIRTUALENVWRAPPER_HOOK_DIR%\postmkvirtualenv.bat"
        )
    )
    goto:eof

:prermvirtualenv
    :: The $VIRTUALENVWRAPPER_HOOK_DIR/prermvirtualenv script is run as
    :: an external program before the environment is removed. The full
    :: path to the environment directory is passed as an argument to the
    :: script.
    set "ENVNAME=%~2"
    if defined VIRTUALENVWRAPPER_HOOK_DIR (
        if exist "%VIRTUALENVWRAPPER_HOOK_DIR%\prermvirtualenv.bat" (
            endlocal
            call "%VIRTUALENVWRAPPER_HOOK_DIR%\prermvirtualenv.bat" %WORKON_HOME%\%ENVNAME%
        )
    )
    goto:eof


:postrmvirtualenv
    :: The $VIRTUALENVWRAPPER_HOOK_DIR/postrmvirtualenv script is run as
    :: an external program after the environment is removed. The full
    :: path to the environment directory is passed as an argument to the
    :: script.
    set "ENVNAME=%~2"
    if defined VIRTUALENVWRAPPER_HOOK_DIR (
        if exist "%VIRTUALENVWRAPPER_HOOK_DIR%\postrmvirtualenv.bat" (
            endlocal
            call "%VIRTUALENVWRAPPER_HOOK_DIR%\postrmvirtualenv.bat" %WORKON_HOME%\%ENVNAME%
        )
    )
    goto:eof

rem
rem  the mkproject hooks are different than the others.. skipping them for now.
rem
rem :premkproject
rem     :: $WORKON_HOME/premkproject is run as an external program after the
rem     :: virtual environment is created and after the current environment
rem     :: is switched to point to the new env, but before the new project
rem     :: directory is created. The current working directory for the
rem     :: script is $PROJECT_HOME and the name of the new project is passed
rem     :: as an argument to the script.
rem     set "ENVNAME=%~2"
rem     if defined VIRTUALENVWRAPPER_HOOK_DIR (
rem         if exist "%VIRTUALENVWRAPPER_HOOK_DIR%\premkproject.bat" (
rem             endlocal
rem             call "%VIRTUALENVWRAPPER_HOOK_DIR%\premkproject.bat" %PROJECT_HOME% %ENVNAME%
rem         )
rem     )
rem     goto:eof
rem 
rem 
rem :postmkproject
rem     :: $WORKON_HOME/postmkproject is sourced after the new environment
rem     :: and project directories are created and the virtualenv is
rem     :: activated. The current working directory is the project
rem     :: directory.
rem     if defined VIRTUALENVWRAPPER_HOOK_DIR (
rem         if exist "%VIRTUALENVWRAPPER_HOOK_DIR%\postmkproject.bat" (
rem             endlocal
rem             cd %PROJECT_HOME%
rem             call "%VIRTUALENVWRAPPER_HOOK_DIR%\postmkproject.bat"
rem         )
rem     )
rem     goto:eof


    :: the cpvirtualenv command is not implemented yet
    :: global precpvirtualenv(original-env-name, new-env-name)
    :: global postcpvirtualenv()

    :: initialize probably does not make much sense for windows
    :: global initialize()

:exit
exit /b

