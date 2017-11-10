@echo off

set config.output=%TMP%\output%config.unique%
mkdir %config.output%


call _start_test setproject_basic
    set fname=%config.output%\%config.current_test%.output
    pushd .
        call mkvirtualenv setproj_basic --no-download --no-wheel --no-setuptools --no-pip
    popd
    mkdir "%PROJECT_HOME%\nospace\pdir"
    call setprojectdir "%PROJECT_HOME%\nospace\pdir"
    call assertEquals "%CD%" "%PROJECT_HOME%\nospace\pdir"

    mkdir "%PROJECT_HOME%\with space\pdir"
    call setprojectdir "%PROJECT_HOME%\with space\pdir"
    call assertEquals "%CD%" "%PROJECT_HOME%\with space\pdir"


:cleanup
    set fname=
    set usage=
    rmvirtualenv add2virtualenv_basic
    rmdir "%config.output%" /s/q
