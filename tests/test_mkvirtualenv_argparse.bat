
set "config.output=%TMP%\output%config.unique%"
mkdir "%config.output%"

call _start_test argparse_empty
    :: check that we don't set a envname when one is not provided
    set fname=%config.output%\%config.current_test%.output
    call mkvirtualenv  --debug ---stop after-argparse  > %fname%
    call assertContains %fname% venvwrapper.envname NOT


call _start_test argparse_envname
    :: check simple case, only envname (and debug args of course)
    set fname=%config.output%\%config.current_test%.output
    call mkvirtualenv  --debug ---stop after-argparse  foo > %fname%
    call assertContains %fname% venvwrapper.envname=foo

call _start_test argparse_pass_flags
    :: check that a flag is passed through to virtualenv (--debug adds -v)
    set fname=%config.output%\%config.current_test%.output
    call mkvirtualenv  --debug ---stop after-argparse  foo --no-download > %fname%
    call assertContains %fname% "venvwrapper.virtualenv_args= -v --no-download"

call _start_test argparse_pass_params
    :: check that a parameter with value is passed through to virtualenv (--debug adds -v)
    set fname=%config.output%\%config.current_test%.output
    call mkvirtualenv  --debug ---stop after-argparse  foo --extra-search-dir=c:\wheelhouse > %fname%
    :: type %fname%
    call assertContains %fname% "venvwrapper.virtualenv_args= -v --extra-search-dir c:\wheelhouse"


:cleanup
    ::rmdir %config.output% /s/q
