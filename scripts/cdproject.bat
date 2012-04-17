@echo off

goto CHANGEDIR
:USAGE
	echo.
	echo  switches to the project dir of the activated virtualenv
	echo.
	goto END

:CHANGEDIR

	if not defined VIRTUAL_ENV (
	   echo .
	   echo a virtualenv must be activated
	   goto USAGE
	)

	if not defined VIRTUALENVWRAPPER_PROJECT_FILENAME (
			set VIRTUALENVWRAPPER_PROJECT_FILENAME=.project
		)

	set _LAST_DIR=%CD%

		
	if not EXIST "%VIRTUAL_ENV%\%VIRTUALENVWRAPPER_PROJECT_FILENAME%" (
		echo.
		echo No project directory found for current virtualenv
		goto USAGE
	)

		
		set /p ENVPRJDIR=<%VIRTUAL_ENV%\%VIRTUALENVWRAPPER_PROJECT_FILENAME%
		cd /d "%ENVPRJDIR%"

:END
