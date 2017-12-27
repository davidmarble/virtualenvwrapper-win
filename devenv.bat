@echo off
::
:: Add scripts and tests directory to front of path.
::
set "VIRTUALENV_WRAPPER_SOURCE=%~dp0%"

path %VIRTUALENV_WRAPPER_SOURCE%scripts;%VIRTUALENV_WRAPPER_SOURCE%tests;%PATH%

:: pick up python files in tests directory
if defined PYTHONPATH (
    set "PYTHONPATH=%VIRTUALENV_WRAPPER_SOURCE%tests;%PYTHONPATH%
) else (
    set "PYTHONPATH=%VIRTUALENV_WRAPPER_SOURCE%tests"
)
