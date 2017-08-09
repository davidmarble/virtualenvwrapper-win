@echo on
setlocal enabledelayedexpansion

set CURDIR=%CD%

:setup
    :: set global hook directory
    set "VIRTUALENVWRAPPER_HOOK_DIR=%CD%\globalhoooks"
    call mkvirtualenv hooktest1 --no-setuptools --no-pip --no-wheel
    cd %CURDIR%
    xcopy localhooks\*.* %VIRTUAL_ENV%\Scripts
    call workon
    call deactivate
    call workon hooktest1
    @echo on
    call tree %config.output%
    @echo on

call _start_test get_env_details_called
    call assertExists %config.output%\get_env_details.local

call _start_test get_env_details_correct_args
    call assertExists %config.output%\get_env_details.local.args hooktest1
