@echo off
setlocal enabledelayedexpansion


:setup
    :: set global hook directory
    set "VIRTUALENVWRAPPER_HOOK_DIR=%CD%\testhooks"
    call mkvirtualenv workon-test1
    xcopy localhooks\*.* %VIRTUAL_ENV%\Scripts
    call workon
    call deactivate
    call workon workon-test1

call _start_test get_env_details_hook
    call assertExsists %config.output%\get_env_details.global
    call assertExsists %config.output%\get_env_details.global.args
    
call _start_test mkvirtualenv_hook
    

call _start_test workon_activate_hook
    call :setup
    call workon workon-test1
    set /p hookoutput=<%OUTPUT_DIR%\hookoutput.txt
    call assertEquals test_workon_activate_hooks "%hookoutput%" "GLOBAL_post_activate_hook"
