
:setup
    call mkvirtualenv cd-test


call _start_test cdvirtualenv
    call cdvirtualenv
    call assertEquals %CD% %VIRTUAL_ENV%

call _start_test cdsitepackage
    call cdsitepackages
    call assertEquals %CD% %VIRTUAL_ENV%\Lib\site-packages

