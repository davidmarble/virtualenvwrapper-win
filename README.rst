virtualenvwrapper-win
=====================

This is a port of Doug Hellmann's `virtualenvwrapper <http://www.doughellmann.com/projects/virtualenvwrapper/>`_ to Windows batch scripts. The idea behind virtualenvwrapper is to ease usage of Ian Bicking's `virtualenv <http://pypi.python.org/pypi/virtualenv>`_, a tool for creating isolated Python virtual environments, each with their own libraries and site-packages.

These should work on any version of Windows (Windows XP, Windows Vista, Windows 7). They do not require Powershell.

Installation
------------
**For Windows only**

Installed scripts are placed in ``%PYTHONHOME%\Scripts``.

To install, run the following in an elevated command prompt::

    pip install virtualenvwrapper-win
    pyassoc

or download the source and run the following in an elevated command prompt::

    python setup.py install
    pyassoc

**Optional**: Add an environment variable WORKON_HOME to specify the path to store environments. By default, this is ``%USERPROFILE%\Envs``.

**Note**: ``pyassoc``
    Note that the batch script ``pyassoc`` requires an elevated command prompt or that UAC is disabled. This script associates .py files with ``python.bat``, a simple batch file that calls the right ``python.exe`` based on whether you have an active virtualenv. This allows you to call python scripts from the command line and have the right python interpreter invoked. Take a look at the source -- it's incredibly simple but the best way I've found to handle conditional association of a file extension.

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
    the working virtualenv to *<name>*). If a project directory has been defined,
	we will change into it. 
	If no argument is specified, list the available environments. 

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

``setprojectdir <full_path>``
    If a virtualenv environment is active, define *<full_path>* as project 
    directory containing the source code.  This allows the use of ``cdproject``
    to change the working directory. In addition, the directory will be 
    added to the environment using ``add2virtualenv``.

``cdproject``
    If a virtualenv environment is active and a projectdir has been defined,
    change the current working directory to active virtualenv's project directory.
    ``cd-`` will return you to the last directory you were in before calling 
    ``cdproject``.

