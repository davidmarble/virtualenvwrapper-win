@echo off

:: go to tests directory
pushd %~dp0%

call ..\devenv.bat

:: echo VIRTUALENV_WRAPPER_SOURCE=%VIRTUALENV_WRAPPER_SOURCE%

for %%F in (test*.bat) do (
    echo.
    echo Running: %%F
    echo -----------------------------------------
    call %%F
)

popd