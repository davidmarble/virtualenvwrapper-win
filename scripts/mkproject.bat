@echo off

if [%1]==[] goto USAGE
goto MKVIRTUALENV


:USAGE
echo.
echo.    Pass a name to create a new virtualenv and linked project
goto END


:LINKPROJECT
call setprojectdir.bat "%PROJ%"
call cdproject.bat
goto END


:MKPROJECT
if not defined PROJECT_HOME (
    set "PROJECT_HOME=%USERPROFILE%\Projects"
)

pushd %PROJECT_HOME% 2>NUL && popd
if errorlevel 1 (
    mkdir %PROJECT_HOME%
)

set "PROJ=%PROJECT_HOME%\%1"

pushd %PROJ% 2>NUL && popd
if errorlevel 1 (
    mkdir %PROJ%
    goto LINKPROJECT
) else (
    echo.
    echo.    project "%PROJ%" already exists
    goto END
)


:MKVIRTUALENV
call mkvirtualenv.bat %1

if not defined VIRTUAL_ENV (
    goto END
)

goto MKPROJECT


:END
set PROJ=
