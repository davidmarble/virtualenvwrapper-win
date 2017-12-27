@echo off

set config.output=%TMP%\output%config.unique%
mkdir %config.output%


call _start_test mkproject_usage_from_noargs
    :: check that we find parts of the usage string when
    :: run without any arguments
    set fname=%config.output%\%config.current_test%.output

    call mkproject > %fname%

    set "usage=The new environment is automatically"
    call assertContains %fname% "%usage%


call _start_test mkproject_happy
    set fname=%config.output%\%config.current_test%.output
    pushd .
        call mkproject happy
        set /a errno=%ERRORLEVEL%
        set "curdir=%CD%"
    popd

    call assertEquals %errno% 0
    call assertEquals "%curdir%" "%PROJECT_HOME%\happy"
    call assertContains "%VIRTUAL_ENV%\.project" "%curdir%"


:cleanup
    set fname=
    set usage=
    rmdir "%config.output%" /s/q
