@echo off
::
::  Setup globals used by the tests.
::
set "RVAL=%RANDOM%"
set "WORKON_HOME=%TMP%\WORKON_HOME.%RVAL%"
set "PROJECT_HOME=%TMP%\PROJECT_HOME.%RVAL%"
set "USER=%USERNAME%"
set "HOME=%USERPROFILE%"
set "CURRENT_MODULE=%1"
