@echo off
::
::  sample test file
::
goto:eof
:: the test files are run from run_tests.bat

rem first call setup.bat to define the testing environment %1 is the current
rem file name

call _start_test testname1
    echo. do something here..
    echo. sample output from testing activities
    call assertEquals 42 42
    call assertEquals 42 43
    
call _start_test testname2
    call assertEquals hello world
