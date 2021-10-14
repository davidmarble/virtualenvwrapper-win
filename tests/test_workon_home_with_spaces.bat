
set config.output=%TMP%\output%config.unique%
mkdir %config.output%


:setup_space_dir
    set "WORKON_HOME=%TMP%\workon_home%RANDOM% with spaces"
    echo WORKON_HOME=%WORKON_HOME%
    echo "%WORKON_HOME%\venv with spaces"


call _start_test space_dir_test
    call mkvirtualenv simple_space_env --no-download --no-wheel --no-setuptools --no-pip
    call assertEquals "%ERRORLEVEL%" "0"


call _start_test space_dir_test2
    call mkvirtualenv regular_space_env
    call assertEquals "%ERRORLEVEL%" "0"


call _start_test venv_with_space
    call mkvirtualenv "venv with spaces" --no-download --no-wheel --no-setuptools --no-pip
    pushd .
        call cdvirtualenv
        set "CURDIR=%CD%"
    popd
    call assertSamePath "%CURDIR%" "%WORKON_HOME%\venv with spaces"


:teardown_space_dir
    set CURDIR=
    rmdir "%WORKON_HOME%" /s /q 2>nul
