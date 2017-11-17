
set config.output=%TMP%\output%config.unique%
mkdir %config.output%


call _start_test setproject_basic
    set fname=%config.output%\%config.current_test%.output
    pushd .
        call mkvirtualenv setproj_basic --no-download --no-wheel --no-setuptools --no-pip
    popd
    mkdir "%PROJECT_HOME%\nospace\pdir"
    call setprojectdir "%PROJECT_HOME%\nospace\pdir"
    pushd .
        call cdproject
        call assertEquals "%CD%" "%PROJECT_HOME%\nospace\pdir"
    popd

call _start_test setproject_spaces
    mkdir "%PROJECT_HOME%\with space\pdir"
    call setprojectdir "%PROJECT_HOME%\with space\pdir"
    pushd .
        call cdproject
        call assertEquals "%CD%" "%PROJECT_HOME%\with space\pdir"
    popd


:cleanup
    set fname=
    set usage=
    rmvirtualenv setproj_basic
    rmdir "%config.output%" /s/q
