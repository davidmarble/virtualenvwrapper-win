@echo off
SETLOCAL 
set "P2=.;%PATH%"
for %%e in (%PATHEXT%) do @for %%i in (%1%%e) do @if NOT "%%~$P2:i"=="" echo %%~$P2:i
for %%i in (%1) do @if NOT "%%~$P2:i"=="" echo %%~$P2:i