@echo off
setlocal enabledelayedexpansion

call setup %~n0%

set "CURRENT_DIR=%~p0%"
set "OUTPUT_DIR=%TMP%\output.%RVAL%"
mkdir "%OUTPUT_DIR%"
touch %OUTPUT_DIR%\hookoutput.txt


:onetime_setup
    mkdir %WORKON_HOME%
    set VIRTUAL_ENV=
    call mkvirtualenv workon-test1 2>NUL
    call deactivate
    set "VIRTUALENVWRAPPER_HOOK_DIR=%CURRENT_DIR%testhooks"

goto:tests

:setup
    del %OUTPUT_DIR%\hookoutput.txt
    touch %OUTPUT_DIR%\hookoutput.txt
    goto:eof

:tests

:test_workon_activate_hooks
    call :setup
    call workon workon-test1
    set /p hookoutput=<%OUTPUT_DIR%\hookoutput.txt
    call assertEquals test_workon_activate_hooks "%hookoutput%" "GLOBAL_post_activate_hook"