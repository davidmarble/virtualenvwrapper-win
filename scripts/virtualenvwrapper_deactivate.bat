@echo off

call virtualenvwrapper_run_hook "predeactivate"
call virtualenv_deactivate.bat

if defined _OLD_VIRTUAL_PYTHONPATH (
    set "PYTHONPATH=%_OLD_VIRTUAL_PYTHONPATH%"
)
call virtualenvwrapper_run_hook "postdeactivate"
