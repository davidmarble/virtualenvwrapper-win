virtualenvwrapper-win
=====================

This is a port of Doug Hellmann's 'virtualenvwrapper <http://www.doughellmann.com/projects/virtualenvwrapper/>`_ to Windows batch scripts. The idea behind virtualenvwrapper is to ease usage of Ian Bicking's `virtualenv <http://pypi.python.org/pypi/virtualenv>`_, a tool for creating isolated Python virtual environments, each with their own libraries and site-packages.

Note: These scripts have only been tested on Windows 7. They will probably work on other Windows versions. They do not require Powershell.

Installation
------------
Put all virtualenvwrapper-win scripts somewhere in your path.

Optional: Add an environment variable WORKON_HOME to specify the path to store environments. By default, this is ``%USERPROFILE%\Envs``.

Main Commands
-------------
``mkvirtualenv <name>``
    Create a new virtualenv environment named *<name>*.  The environment will 
    be created in WORKON_HOME.

``lsvirtualenv``
    List all of the enviornments stored in WORKON_HOME.

``rmvirtualenv <name>``
    Remove the environment *<name>*. Uses ``folder_delete.bat``.

``workon [<name>]``
    If *<name>* is specified, activate the environment named *<name>* (change 
    the working virtualenv to *<name>*). If no argument is specified, list 
    the available environments.

``deactivate``
    Deactivate the working virtualenv and switch back to the default system 
    Python.

``add2virtualenv <full_path>``
    If a virtualenv environment is active, appends *<full_path>* to 
    ``virtualenv_path_extensions.pth`` inside the environment's site-packages,
    which effectively adds *<full_path>* to the environment's PYTHONPATH. 
    If a virtualenv environment is not active, appends *<full_path>* to
    ``virtualenv_path_extensions.pth`` inside the default Python's 
    site-packages.
    
Convenience Commands
--------------------
``cdvirtualenv``
    If a virtualenv environment is active, change the current working 
    directory to the active virtualenv base directory. If a virtualenv 
    environment is not active, change the current working directory to 
    the base directory of the default Python. ``cd-`` will return you 
    to the last directory you were in before calling ``cdvirtualenv``.

``cdsitepackages``
    If a virtualenv environment is active, change the current working 
    directory to the active virtualenv's site-packages directory. If 
    a virtualenv environment is not active, change the current working 
    directory to the default Python's site-packages directory. ``cd-`` 
    will return you to the last directory you were in before calling 
    ``cdsitepackages``.

``lssitepackages``
    If a virtualenv environment is active, list that environment's 
    site-packages. If a virtualenv environment is not active, list the 
    default Python's site-packages. Output includes a basic listing of 
    the site-packages directory, the contents of easy-install.pth, 
    and the contents of virtualenv_path_extensions.pth (used by 
    ``add2virtualenv``).
