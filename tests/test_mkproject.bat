@echo off

set config.output=%TMP%\output%config.unique%
mkdir %config.output%


call _start_test mkproject_usage_from_noargs
    :: check that we find parts of the usage string when
    :: run without any arguments
    set fname=%config.output%\%config.current_test%.output

    call mkproject > %fname%

    set "usage=Pass a name to create a new"
    call assertContains %fname% "%usage%


call _start_test mkproject_happy
    set fname=%config.output%\%config.current_test%.output
    pushd .
        call mkproject happy

        :: no errors
        call assertEquals %ERRORLEVEL% 0

        :: we should end up in the new project dir
        call assertEquals "%CD%" "%PROJECT_HOME%\happy"
    popd

    echo.PROJECT_HOME = %PROJECT_HOME%
    echo.-----------------------------
    pushd "%PROJECT_HOME%"
        dir /s
    popd

    echo.VIRTUAL_ENV = %VIRTUAL_ENV%
    echo.-----------------------------
    pushd "%VIRTUAL_ENV%"
        dir
    popd

    type "%VIRTUAL_ENV%\.project"

:cleanup
    set fname=
    set usage=
    rmdir "%config.output%" /s/q
