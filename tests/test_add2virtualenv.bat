

set config.output=%TMP%\output%config.unique%
mkdir %config.output%


:: setup
    pushd .
        call mkvirtualenv add2virtualenv_basic --no-download --no-wheel --no-setuptools --no-pip
    popd
    mkdir "%PROJECT_HOME%"
    subst w: "%PROJECT_HOME%"

call _start_test add2virtualenv_nospace
    set fname=%config.output%\%config.current_test%.output

    set "dname=%PROJECT_HOME%\nospace\pdir"

    echo. add2virtualenv "%dname%"
    call add2virtualenv "%dname%"

    echo.     python -c "import sys;sys.exit(r'%dname%' in sys.path)"
    python -c "import sys;sys.exit(r'%dname%' in sys.path)"
    echo. ERRORLEVEL = %ERRORLEVEL%

    call assertErrorlevel 1


call _start_test add2virtualenv_space
    set fname=%config.output%\%config.current_test%.output

    set "dname=%PROJECT_HOME%\with space\pdir"
    call add2virtualenv "%dname%"
    python -c "import sys;sys.exit(r'%dname%' in sys.path)"
    call assertErrorlevel 1


call _start_test add2virtualenv_other_drive_direxists
    set fname=%config.output%\%config.current_test%.output

    set "dname=w:\nospace\pdir"
    call add2virtualenv "%dname%"
    python -c "import sys;sys.exit(r'%dname%' in sys.path)"
    call assertErrorlevel 1


call _start_test add2virtualenv_other_drive_newdir
    set fname=%config.output%\%config.current_test%.output

    set "dname=w:\nospace\pdir\new"
    call add2virtualenv "%dname%"
    python -c "import sys;sys.exit(r'%dname%' in sys.path)"
    call assertErrorlevel 1


:cleanup
    set fname=
    set usage=
    subst w: /d

    rmvirtualenv add2virtualenv_basic
    rmdir "%config.output%" /s/q
