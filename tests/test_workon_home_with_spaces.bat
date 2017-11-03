
:setup_space_dir
    set "WORKON_HOME=%TMP%\workon_home%RANDOM% with spaces"


call _start_test space_dir_test
    call mkvirtualenv simple_space_env --no-download --no-wheel --no-setuptools --no-pip
    call assertEquals "%ERRORLEVEL%" "0"


call _start_test space_dir_test
    call mkvirtualenv regular_space_env
    call assertEquals "%ERRORLEVEL%" "0"


:: call _start_test mkproject_space_test


:teardown_space_dir
    rmdir "%WORKON_HOME%" /s /q 2>nul
