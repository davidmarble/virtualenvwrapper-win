@echo off

if not defined WORKON_HOME (
    set WORKON_HOME=%USERPROFILE%\Envs
)

set _LAST_DIR=%CD%

if defined VIRTUAL_ENV (
    cd %VIRTUAL_ENV%\Lib\site-packages
) else (
    if defined PYTHONHOME (
        goto KEEPON
    )
    for %%i in (python.exe) do set PYTHONHOME=%%~dp$PATH:i

    :KEEPON
    cd %PYTHONHOME%\Lib\site-packages
)

:END
