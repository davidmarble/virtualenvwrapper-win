@echo off
goto:eof

call setup %~n0% 

:onetime_setup
    mkdir %WORKON_HOME%
    set VIRTUAL_ENV=
    call mkvirtualenv cd-test 2>NUL
    call deactivate

:setup
    call workon cd-test


:test_cdvirtualenv
    call cdvirtualenv 2>NUL
    call assertEquals test_cdvirtualenv "%CD%" "%VIRTUAL_ENV%"

:test_cdsitepackage
    call cdvirtualenv 2>NUL
    call cdsitepackages
    call assertEquals test_cdsitepackage "%CD%" "%VIRTUAL_ENV%\Lib\site-packages"



:cleanup
    rmdir %WORKON_HOME% /s /q

