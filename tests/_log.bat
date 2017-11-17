@echo off
pushd %~dp0
    set "config.log.output=%TMP%\config.log.output%RANDOM%.bat"
    python -u _log.py %* > %config.log.output%
    call %config.log.output%
    del %config.log.output%
    set config.log.output=
popd
