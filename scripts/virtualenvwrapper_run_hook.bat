@echo off
:: Call a hook if defined. Usage:
:: 
::     call virtualenvwrapper_run_hook "postactivate"
::
if not defined WORKON_HOME ( 
   echo WORKON_HOME not set
   goto:eof
)
set HOOK_NAME=%~1
shift
call :%HOOK_NAME% %*
goto :exit


:get_env_details

    :: $VIRTUALENVWRAPPER_HOOK_DIR/get_env_details.bat is run when workon is run
    :: with no arguments and a list of the virtual environments is
    :: printed. The hook is run once for each environment, after the name is
    :: printed, and can print additional information about that environment.

    :: call global hook
    if defined VIRTUALENVWRAPPER_HOOK_DIR (
        if exist "%VIRTUALENVWRAPPER_HOOK_DIR%\get_env_details.bat" (
	    :: echo args=%*
            call "%VIRTUALENVWRAPPER_HOOK_DIR%\get_env_details.bat" %~2
        )
    )


goto:eof

    :: both get_env_details(env-name)
    :: global initialize()
    :: global premkvirtualenv(name-of-new-environment)
    :: global postmkvirtualenv()
    :: global precpvirtualenv(original-env-name, new-env-name)
    :: global postcpvirtualenv()
    :: both preactivate(env-name)
    :: both postactivate()
    :: both predeactivate()
    :: both postdeactivate()
    :: global prermvirtualenv(env-name)
    :: global postrmvirtualenv(env-name)
    :: global premkproject(name-of-new-project)
    :: global postmkproject()

:exit
exit /b

