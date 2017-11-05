@echo off
::
::  This script runs `make html` whenever a .bat or .rst file under the
::  docs directory changes.
::
::  This script requires:  `pip install watchdog`
::

watchmedo shell-command --patterns="*.bat;*.rst" --recursive --command="make html" %~dp0
