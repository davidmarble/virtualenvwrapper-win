@echo off


call virtualenv_activate.bat

:: In case user makes changes to PYTHONPATH
if defined _OLD_VIRTUAL_PYTHONPATH (
    set "PYTHONPATH=%_OLD_VIRTUAL_PYTHONPATH%"
) else (
    set "_OLD_VIRTUAL_PYTHONPATH=%PYTHONPATH%"
)
