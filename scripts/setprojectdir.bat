@echo off

if [%1]==[] goto USAGE
goto SETPROJECTDIR


:USAGE
	echo.
	echo pass a full path to project directory while target virtualenv is activated
	echo.
	goto END


:SETPROJECTDIR


	if not defined WORKON_HOME (
		set WORKON_HOME=%USERPROFILE%\Envs
	)
	
	if not defined VIRTUALENVWRAPPER_PROJECT_FILENAME (
		set VIRTUALENVWRAPPER_PROJECT_FILENAME=.project
	)

	if not defined VIRTUAL_ENV (
		echo.
		echo No novirtualenv activated.
		goto USAGE
		
	) else (
	
		pushd %1 2>NUL && popd
		@if errorlevel 1 (
			mkdir "%1"
		)
		REM echo project directory = "%1"
		REM echo PRJfile = "%VIRTUAL_ENV%\%VIRTUALENVWRAPPER_PROJECT_FILENAME%"
		echo configured project directory for %VIRTUAL_ENV%.
		
		set /p =%1>%VIRTUAL_ENV%\%VIRTUALENVWRAPPER_PROJECT_FILENAME% <NUL
		call add2virtualenv.bat %1
		
	)


	



:END
