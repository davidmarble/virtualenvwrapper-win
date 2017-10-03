@echo off
setlocal enableDelayedExpansion

:config
    set config.original_args=%~dp0%~n0 %*
    set config.date=%DATE%
    set config.time=%TIME%
    set config.global_id=%RANDOM%
    set config.single_test=
    set /a config.abort_on_fail=0
    set /a config.supress_output=0
    set /a config.verbose=0
    set /a config.passing_tests=0
    set /a config.failing_tests=0
    set /a config.call_single_test=0

:getopt
    if [%1]==[-v]               set /a config.verbose+=1
    if [%1]==[-h]               goto:usage
    if [%1]==[--help]           goto:usage
    if [%1]==[-x]               set /a config.abort_on_fail+=1
    if [%1]==[-k]  (
        set /a config.call_single_test+=1
        set config.single_test=%2
        shift
    )
    if [%1]==[--abort-on-fail]  set /a config.abort_on_fail+=1
    if [%1]==[-q]               set /a config.supress_output+=1
    if [%1]==[--quiet]          set /a config.supress_output+=1
    if [%1]==[--suppress-output]    set /a config.supress_output+=1

    shift
    if not [%1]==[] goto:getopt

:: go to tests directory
pushd %~dp0
    call _log begin logfile.txt
    pushd ..
        :: add the source and tests directories to the path
        path %CD%\scripts;%CD%\tests;%PATH%
        if defined PYTHONPATH (
            set "PYTHONPATH=%VIRTUALENV_WRAPPER_SOURCE%tests;%PYTHONPATH%
        ) else (
            set "PYTHONPATH=%VIRTUALENV_WRAPPER_SOURCE%tests"
        )
    popd

    ::cls
    echo %config.original_args%
    echo Starting testsuite: %config.date% %config.time%
    echo.

    call:print_config
    if %config.verbose% geq 2   call:print_config
    
    :: use forfiles to filter out directories, and for so we stay in the same shell..
    for /f "tokens=*" %%f in ('forfiles /m test_*.bat /c "cmd /c if @isdir==FALSE echo @file @fname"') do (
        if %config.call_single_test% geq 1 (
            :: echo python -c "import sys;sys.exit('%config.single_test%' in '%%f')"
            python -c "import sys;sys.exit('%config.single_test%' in '%%f')"
            if errorlevel 1 (
                call _run_single_test %%f
            )
        ) else (
            call _run_single_test %%f
        )

        if ERRORLEVEL 1 (
            if %config.abort_on_fail% geq 1  exit /b 99
        )
    )

popd

call _log end

exit /b %config.failing_tests%

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
    echo.   -k str                      run only tests which contain 'str' in their names

    echo.

