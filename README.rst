.. image:: https://github.com/davidmarble/virtualenvwrapper-win/actions/workflows/ci-cd.yml/badge.svg
   :target: https://github.com/davidmarble/virtualenvwrapper-win/actions/workflows/ci-cd.yml

.. image:: https://pepy.tech/badge/virtualenvwrapper-win/month
   :target: https://pepy.tech/project/virtualenvwrapper-win


virtualenvwrapper-win
=====================

This is a port of Doug Hellmann's `virtualenvwrapper <http://www.doughellmann.com/projects/virtualenvwrapper/>`_
to Windows batch scripts. The idea behind virtualenvwrapper is to ease usage of
Ian Bicking's `virtualenv <http://pypi.python.org/pypi/virtualenv>`_, a tool
for creating isolated Python virtual environments, each with their own libraries
and site-packages.

These scripts should work on any version of Windows (Windows XP, Windows Vista, Windows 7/8/10).

However, they only work in the **regular command prompt**. They **will not work in Powershell.** There are other virtualenvwrapper projects out there for Powershell.


Installation
------------
**For Windows only**

To use these scripts from any directory, make sure the ``Scripts`` subdirectory of Python is in your PATH. For example, if python is installed in ``C:\Python27\``, you should make sure ``C:\Python27\Scripts`` is in your PATH.

To install, run one of the following::

    # using pip
    pip install virtualenvwrapper-win

    # using easy_install
    easy_install virtualenvwrapper-win

    # from source
    git clone git://github.com/davidmarble/virtualenvwrapper-win.git
    cd virtualenvwrapper-win
    python setup.py install   # or pip install .


**WORKON_HOME (Optional)**
~~~~~~~~~~~~~~~~~~~~~~~~~~
Add an environment variable WORKON_HOME to specify the path to store environments.
By default, this is ``%USERPROFILE%\Envs``.

**pywin (Optional)**
~~~~~~~~~~~~~~~~~~~~
**pywin** python version switcher (not included)

If you use several versions of python, you can switch between them
using a separate project `pywin
<https://github.com/davidmarble/pywin>`_. It's a lightweight
python 2.5-3.3 launcher and switcher I wrote for the Windows
command line and MSYS/MINGW32. It's similar to the `py.exe
launcher/switcher available in python 3.3
<http://docs.python.org/3/using/windows.html#launcher>`_, but
written with basic Windows batch scripts and a shell script for
MSYS/MINGW32 support. I use bash and command line shell tools from
`msysgit <http://msysgit.github.com/>`_, based on MSYS/MINGW32, to
do most of my python development on Windows.

Main Commands
-------------
``mkvirtualenv [mkvirtualenv-options] [virtualenv-options] <name>``
    Create a new virtualenv environment named *<name>*.  The environment will
    be created in WORKON_HOME.

    ``mkvirtualenv`` options:
      -h                    Print help text.
      -a project_path       Associate existing path as project directory
      -i package            Install package in new environment. This option
                            can be repeated to install more than one package.
      -r requirements_file  requirements_file is passed to
                            pip install -r requirements_file

    any other options are passed on to the ``virtualenv`` command.                
    For recent versions of ``virtualenv``, the ``-p`` / ``--python`` 
    can take version numbers instead of the full path to the interpreter,
    e.g. ``mkvirtualenv -p3.5 <name>`` (assuming you have a Python 3.5.x
    interpreter installed).
    
``lsvirtualenv``
    List all of the enviornments stored in WORKON_HOME.

``rmvirtualenv <name>``
    Remove the environment *<name>*.

``workon [<name>]``
    If *<name>* is specified, activate the environment named *<name>* (change
    the working virtualenv to *<name>*). If a project directory has been
    defined, we will change into it. If no argument is specified, list the
    available environments. One can pass additional option -c after
    virtualenv name to cd to virtualenv directory if no projectdir is set.

``deactivate``
    Deactivate the working virtualenv and switch back to the default system
    Python.

``add2virtualenv <full or relative path>``
    If a virtualenv environment is active, appends *<path>* to
    ``virtualenv_path_extensions.pth`` inside the environment's site-packages,
    which effectively adds *<path>* to the environment's PYTHONPATH.
    If a virtualenv environment is not active, appends *<path>* to
    ``virtualenv_path_extensions.pth`` inside the default Python's
    site-packages. If *<path>* doesn't exist, it will be created.

Convenience Commands
--------------------
``cdproject``
    If a virtualenv environment is active and a projectdir has been defined,
    change the current working directory to active virtualenv's project directory.
    ``cd-`` will return you to the last directory you were in before calling
    ``cdproject``.

``cdsitepackages``
    If a virtualenv environment is active, change the current working
    directory to the active virtualenv's site-packages directory. If
    a virtualenv environment is not active, change the current working
    directory to the default Python's site-packages directory. ``cd-``
    will return you to the last directory you were in before calling
    ``cdsitepackages``.

``cdvirtualenv``
    If a virtualenv environment is active, change the current working
    directory to the active virtualenv base directory. If a virtualenv
    environment is not active, change the current working directory to
    the base directory of the default Python. ``cd-`` will return you
    to the last directory you were in before calling ``cdvirtualenv``.

``lssitepackages``
    If a virtualenv environment is active, list that environment's
    site-packages. If a virtualenv environment is not active, list the
    default Python's site-packages. Output includes a basic listing of
    the site-packages directory, the contents of easy-install.pth,
    and the contents of virtualenv_path_extensions.pth (used by
    ``add2virtualenv``).
    
``mkproject``
    If the environment variable PROJECT_HOME is set, create a new project 
    directory in PROJECT_HOME and a virtualenv in WORKON_HOME.  The project path
    will automatically be associated with the virtualenv on creation.

``setprojectdir <full or relative path>``
    If a virtualenv environment is active, define *<path>* as project
    directory containing the source code.  This allows the use of ``cdproject``
    to change the working directory. In addition, the directory will be
    added to the environment using ``add2virtualenv``. If *<path>* doesn't
    exist, it will be created.

``toggleglobalsitepackages``
    If a virtualenv environment is active, toggle between having the
    global site-packages in the PYTHONPATH or just the virtualenv's
    site-packages.

``whereis <file>``
    A script included for convenience. Returns the locations (on `%PATH%`)
    that contain an executable `file`. You can call
    ``whereis python`` to find all executables starting with ``python`` or
    ``whereis python.exe`` for an exact match.


``virtualenvwrapper``
    Print a list of commands and their descriptions as basic help output.
    (added in v.1.2.4)

Hooks
-----
To run some commands after ``mkvirtualenv`` you can use hooks. First
you need to define ``VIRTUALENVWRAPPER_HOOK_DIR`` variable. If it is
set ``mkvirtualenv`` will run ``postmkvirtualenv.bat`` script from
that directory.
