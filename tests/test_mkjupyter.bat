@echo off

set config.output=%TMP%\output%config.unique%
mkdir %config.output%


call _start_test mkjupyter_usage_from_noargs
    :: check that we find parts of the usage string when
    :: run without any arguments
    set fname=%config.output%\%config.current_test%.output

    call mkjupyter > %fname%

    set "usage=The new environment is automatically"
    call assertContains %fname% "%usage%


call _start_test mkjupyter_happy
    set fname=%config.output%\%config.current_test%.output
    pushd .
        call mkjupyter mkjupyter_test_happy
        set /a errno=%ERRORLEVEL%
        set "curdir=%CD%"
    popd

    call assertEquals %errno% 0
    call assertEquals "%VIRTUAL_ENV%" "%WORKON_HOME%\mkjupyter_test_happy"
    call assertExist %VIRTUAL_ENV%\Lib\site-packages\ipykernel\ipkernel.py


:cleanup
    set fname=
    set usage=
    rmdir "%config.output%" /s/q
    call rmvirtualenv mkjupyter_test_happy
