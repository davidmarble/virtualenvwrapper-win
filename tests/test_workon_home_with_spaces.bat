
:setup_space_dir
    set "WORKON_HOME=%TMP%\workon_home with spaces"


call _start_test space_dir_test
    call mkvirtualenv simple_space_env --no-download --no-wheel --no-setuptools --no-pip
    call assertEquals "%ERRORLEVEL%" "0"

:teardown_space_dir
    rmdir "%WORKON_HOME%" /s /q 2>nul
