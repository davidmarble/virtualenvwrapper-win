::
:: Setup the venvwrapper global variables.
:: This file should be called and not executed by itself.
::

:set_venvwrapper_globals
    set "venvwrapper._default_workon_home=%USERPROFILE%\Envs"
    :: set "venvwrapper._pypy_scriptsdir=bin"
    :: set "venvwrapper._cpython_scriptsdir=Scripts"

    call:find_scriptsdir


    :: make sure WORKON_HOME has a useful value
    if not defined WORKON_HOME  set "WORKON_HOME=%venvwrapper._default_workon_home%"

    set "venvwrapper.workon_home=%WORKON_HOME%"

    call:find_scriptsdir
    call:find_pyhome

goto:eof

:find_scriptsdir
    if defined VIRTUAL_ENV (
        :: go to virtual env directory so we can use if exist
        pushd "%VIRTUAL_ENV%"
        if exist bin\pypy.exe (
            set "venvwrapper.scripts=%VIRTUAL_ENV%\bin"
            set "venvwrapper.python=%VIRTUAL_ENV%\bin\pypy.exe"
            set "venvwrapper.site_packages=%VIRTUAL_ENV%\site-packages"
        ) else (
            set "venvwrapper.scripts=%VIRTUAL_ENV%\Scripts"
            set "venvwrapper.python=%VIRTUAL_ENV%\Scripts\python.exe"
            set "venvwrapper.site_packages=%VIRTUAL_ENV%\Lib\site-packages"
        )
	popd
    )
    goto:eof

:find_pyhome
    if defined PYTHONHOME (
        set "venvwrapper.pyhome=%PYTHONHOME%"
        goto:eof
    )
    if defined VIRTUAL_ENV (
        set "venvwrapper.pyhome=%VIRTUAL_ENV%"
        goto:eof
    )
    for /f "usebackq tokens=*" %%a in (`%venvwrapper.python% -c "import sys;print(sys.exec_prefix)"`) do (
        set "venvwrapper.pyhome=%%a"
    )
    goto:eof
