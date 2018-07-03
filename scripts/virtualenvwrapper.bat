@echo off
echo.
echo. virtualenvwrapper is a set of extensions to Ian Bicking's virtualenv
echo. tool.  The extensions include wrappers for creating and deleting
echo. virtual environments and otherwise managing your development workflow,
echo. making it easier to work on more than one project at a time without
echo. introducing conflicts in their dependencies.
echo.
echo. virtualenvwrapper-win is a port of Dough Hellman's virtualenvwrapper to Windows
echo. batch scripts.
echo.
echo. Commands available:
echo.

:: Please keep this list in alphabetical order when adding to it.
:: Entries that have been commented out are commands that the linux
:: version of virtualenvwrapper have and we do not.

echo.   add2virtualenv: add directory to the import path
echo.
:: echo.   allvirtualenv: run a command in all virtualenvs
:: echo.
echo.   cdproject: change directory to the active project
echo.
echo.   cdsitepackages: change to the site-packages directory
echo.
echo.   cdvirtualenv: change to the $VIRTUAL_ENV directory
echo.
::echo.   cpvirtualenv: duplicate the named virtualenv to make a new one
::echo.
echo.   lssitepackages: list contents of the site-packages directory
echo.
echo.   lsvirtualenv: list virtualenvs
echo.
echo.   mkproject: create a new project directory and its associated virtualenv
echo.
::echo.   mktmpenv: create a temporary virtualenv
::echo.
echo.   mkvirtualenv: Create a new virtualenv in $WORKON_HOME
echo.
echo.   rmvirtualenv: Remove a virtualenv
echo.
::echo.   setvirtualenvproject: associate a project directory with a virtualenv
::echo.
echo.   setprojectdir: associate a project directory with a virtualenv
echo.
:: https://bitbucket.org/virtualenvwrapper/virtualenvwrapper/src/36b8050a90192a087d1060f32083249d13d8a215/virtualenvwrapper.sh?at=master&fileviewer=file-view-default#virtualenvwrapper.sh-641
::echo.   showvirtualenv: show details of a single virtualenv
::echo.
echo.   toggleglobalsitepackages: turn access to global site-packages on/off
echo.
echo.   virtualenvwrapper: show this help message
echo.
::echo.   wipeenv: remove all packages installed in the current virtualenv
::echo.
echo.   whereis: return full path to executable on path.
echo.
echo.   workon: list or change working virtualenvs
echo.
echo.
