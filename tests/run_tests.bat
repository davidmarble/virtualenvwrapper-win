@echo off
setlocal enableDelayedExpansion

:config
    set config.original_args=%~dp0%~n0 %*
    set config.date=%DATE%
    set config.time=%TIME%
    set config.global_id=%RANDOM%
    set /a config.abort_on_fail=0
    set /a config.supress_output=0
    set /a config.verbose=0
    set /a config.passing_tests=0
    set /a config.failing_tests=0

:getopt
    if [%1]==[-v]               set /a config.verbose+=1
    if [%1]==[-h]               goto:usage
    if [%1]==[--help]           goto:usage
    if [%1]==[-x]               set /a config.abort_on_fail+=1
    if [%1]==[--abort-on-fail]  set /a config.abort_on_fail+=1
    if [%1]==[-q]               set /a config.supress_output+=1
    if [%1]==[--quiet]          set /a config.supress_output+=1
    if [%1]==[--suppress-output]    set /a config.supress_output+=1

    shift
    if not [%1]==[] goto:getopt

:: go to tests directory
pushd %~dp0
    pushd ..
        :: add the source and tests directories to the path
        path %CD%\scripts;%CD%\tests;%PATH%
    popd

    cls
    echo %config.original_args%
    echo Starting testsuite: %config.date% %config.time%
    echo.

    if %config.verbose% geq 2   call:print_config
    
    :: use forfiles to filter out directories, and for so we stay in the same shell..
    for /f "tokens=*" %%f in ('forfiles /m test_*.bat /c "cmd /c if @isdir==FALSE echo @file @fname"') do (
        call _run_single_test %%f

        if ERRORLEVEL 1 (
            if %config.abort_on_fail% geq 1  exit /b 99
        )
    )

popd
goto:eof


:print_config
    echo.
    echo.config values
    echo.------------------------
    echo on
    @set config
    @echo off
    echo.
    exit /b

:usage
    echo. run_tests will run all .bat files starting with test_ in the current
    echo. directory.
    echo.
    echo. Usage:  run_tests [options]
    echo.
    echo. where options can be
    echo.   -h, --help                  show this help message
    echo.   -v                          be verbose (can be repeated for increased verboseness)
    echo.   -x, --abort-on-fail         quit the rest of the files on failure
    echo.   -q, --supress-output        supress output from tests

    echo.
