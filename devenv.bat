@echo off
::
:: For developent it is useful to have the file versions in the source/tests
:: directories be first in path..
::
:: Add scripts and tests directory to front of path.
::
set "VIRTUALENV_WRAPPER_SOURCE=%~dp0%"
path %VIRTUALENV_WRAPPER_SOURCE%scripts;%VIRTUALENV_WRAPPER_SOURCE%tests;%PATH%
exit /b