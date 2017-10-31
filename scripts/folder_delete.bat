@echo off
::
:: this file is deprecated and will be removed in a future version
::
SETLOCAL EnableDelayedExpansion

if [%1]==[] goto USAGE
goto FDEL

:USAGE
echo.
echo Usage: folder_delete PATTERN
echo.
goto END

:FDEL
for /d /r "%CD%" %%d in (%1) do @if exist "%%d" rd /s/q "%%d"
REM for /d /r %CD% %d in (.svn) do @if exist "%d" rd /s/q "%d"
REM for /d /r . %d in (%1) do @if exist "%d" rd /s/q "%d"
REM for /f "usebackq" %%d in ("dir %1 /ad/b/s") do rd /s/q "%%d"

:END
