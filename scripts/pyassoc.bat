@echo off

if defined VIRTUAL_ENV (
    call "%VIRTUAL_ENV%\Scripts\deactivate.bat"
)

if defined PYTHONHOME (
	goto MAIN
)
FOR /F "tokens=*" %%i in ('whereis python.exe') do set PYTHONHOME=%%~dpi
SET PYTHONHOME=%PYTHONHOME:~0,-1%

:MAIN
REM Detect if the user is running in elevated mode.
REM Relies on requiring admin privileges to read the LOCAL SERVICE account reg key.
reg query "HKU\S-1-5-19" >NUL 2>NUL
@IF ERRORLEVEL 1 (
	echo.
	echo.    You need elevated privileges to run this command.
	echo.    Launch the command prompt as administrator or turn UAC off.
	echo.
	GOTO END
)

assoc .pyc=Python.CompiledFile >NUL 2>NUL
ftype Python.CompiledFile="%PYTHONHOME%\Scripts\python.bat" "%%1" %%* >NUL 2>NUL

assoc .py=Python.File >NUL 2>NUL
ftype Python.File="%PYTHONHOME%\Scripts\python.bat" "%%1" %%* >NUL 2>NUL
@IF ERRORLEVEL 0 (
	echo.
	echo.    .py files will launch with "%PYTHONHOME%\Scripts\python.bat" "%%1" %%*
	echo.
) ELSE (
	echo.
	echo.    FAILED to set .py files association.
)

:END
