@echo off
::
::  find the loacation of an executable
::
if "%~1"=="" goto:usage

SETLOCAL 
set "P2=.;%PATH%"
for %%e in (%PATHEXT%) do @for %%i in (%1%%e) do @if NOT "%%~$P2:i"=="" echo %%~$P2:i
for %%i in (%1) do @if NOT "%%~$P2:i"=="" echo %%~$P2:i
goto:eof

:usage
    echo.
    echo.Find the location of an executable on %%PATH%%.
    echo.
    echo.Usage:  whereis FILE
    echo.
    echo.    whereis python         finds python.bat, python.exe, python.cmd, etc.
    echo.    whereis python.exe     finds only python.exe
    echo.
