
set config.output=%TMP%\output%config.unique%
mkdir %config.output%


call _start_test mkvirtualenv_r
    set fname=%config.output%\%config.current_test%.output
    > %fname%.requirements (
        echo.virtualenv-clone
        echo.
    )
    echo requirements file: "%fname%.requirements"
    type %fname%.requirements
    pushd .
        call mkvirtualenv venv_r -r %fname%.requirements --no-download --no-wheel
    popd
    call %VIRTUAL_ENV%\Scripts\pip freeze > %fname%.pipfreeze
    echo fname [%fname%.pipfreeze] contents:
    type %fname%.pipfreeze
    call assertContains "%fname%.pipfreeze" "virtualenv-clone"


call _start_test mkvirtualenv_i
    set fname=%config.output%\%config.current_test%.output
    pushd .
        call mkvirtualenv venv_i -i virtualenv-clone -i virtualenv-api --no-download --no-wheel
    popd
    call %VIRTUAL_ENV%\Scripts\pip freeze > %fname%.pipfreeze
    echo fname [%fname%.pipfreeze] contents:
    type %fname%.pipfreeze
    call assertContains "%fname%.pipfreeze" "virtualenv-clone"
    call assertContains "%fname%.pipfreeze" "virtualenv-api"


call _start_test mkvirtualenv_a
    set fname=%config.output%\%config.current_test%.output
    set projdir=%config.output%\venv_a_projdir
    echo making project directory [%projdir%]
    mkdir "%projdir%"
    call assertExist "%projdir%"
    pushd .
        call mkvirtualenv venv_a -a %projdir% --no-download --no-wheel --no-setuptools --no-pip
    popd
    call assertExist %VIRTUAL_ENV%\.project
    set /p env_projdir=<%VIRTUAL_ENV%\.project
    call assertEquals "%env_projdir%" "%projdir%"


call _start_test make_simple_env
    call mkvirtualenv simpleenv --no-download --no-wheel --no-setuptools --no-pip
    call assertExist %VIRTUAL_ENV%\Scripts\python.exe
    call assertNotExist %VIRTUAL_ENV%\Scripts\pip.exe
    call assertNotExist %VIRTUAL_ENV%\Scripts\wheel.exe
    echo %PROMPT% > %fname%.prompt
    call assertContains %fname%.prompt "(simpleenv)"


call _start_test make_default_env
    call mkvirtualenv defaultenv
    :: dir %VIRTUAL_ENV%\Scripts
    call assertExist %VIRTUAL_ENV%\Scripts\python.exe
    call assertExist %VIRTUAL_ENV%\Scripts\pip.exe
    call assertExist %VIRTUAL_ENV%\Scripts\wheel.exe
    echo %PROMPT% > %fname%.prompt
    call assertContains %fname%.prompt "(defaultenv)"


:cleanup
    ::rmdir %config.output% /s/q 
