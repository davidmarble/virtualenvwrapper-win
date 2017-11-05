.. _standard-layuot:

Standard layout of a .bat file
====================================

.. warning:: This is WIP.

The general layout should normally be:

 - ``@echo off``
 - descriptive comment
 - default values
 - option handling
 - initialize variables
 - the body of the script
 - call cleanup and exit with a zero exit code (no errors)
 - subroutines
 - usage subroutine printing the end-user usage info
 - cleanup subroutine

each point is described below.

Not all scripts need all sections.

Descriptive comment
---------------------
This is a comment giving the name of the command and a short
description of what the command does, targeted at developers developing
virtualenvwrapper-win.

Default values
---------------------
Set any default values here, e.g. default ``WORKON_HOME``, ``PROJECT_HOME`` directories.
For debugging the option handling it can be useful to include the script's parameters
when called (``%*``):

.. code-block:: dosbatch

    :: set default values
        set "prefix.original_args=%*"
        set "prefix.dirname=..default value.."

Writing the section comment in column 0 and indenting the ``set ..`` commands makes
the code easier to grok when you come back to it.


Option Handling
-----------------
All scripts should handle the `-h` and `--help` options. If that is all, it can be
handled by:

.. code-block:: dosbatch

    if "%~1"=="-h"      goto:usage & exit /b 0
    if "%~1"=="--help"  goto:usage & exit /b 0

if calling the command with no arguments should display the usage, add:

.. code-block:: dosbatch

    if "%~1"==""      goto:usage & exit /b 0

This version handles quoted and unquoted arguments, as well as arguments with and
without spaces.

More complex option handling
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
For more complex option handling you'll need to loop over the input parameters.
The looplabel should be named ``:getopts``

.. code-block:: dosbatch

    :getopts
        if "%~1"=="-f"  set /a prefix.flag_var=1

        if "%~1"=="--arg-with-value" (
            set "prefix.arg_with_value=%~2"
            shift
        )
        shift
        if not "%~1"=="" goto:getopts

For even more complex option handling, where you need to mutate variables, use the
following:

.. code-block:: dosbatch

    setlocal
    :getopts
        ...
    (endlocal & rem export from setlocal block
        :: variables set here escape, and variables set in the setlocal
        :: block are still visible.
    )

Initialize variables
----------------------------------------------------------

The body of the script
----------------------------------------------------------
Make sure any error conditions cause an error message to be printed, and a unique
error number to be set (``exit /b n`` where ``n`` is the error number).

A normal exit should set the errorlevel to 0 by ``exit /b 0``.



Call cleanup and exit with a zero exit code (no errors)
----------------------------------------------------------

Subroutines
----------------------------------------------------------

usage subroutine printing the end-user usage info
----------------------------------------------------------

cleanup subroutine
----------------------------------------------------------

.. literalinclude:: _static/stdlayout.bat
    :language: dosbatch
    :linenos:
    :lines: 90-92




Skeleton
========

.. literalinclude:: _static/stdlayout.bat
    :language: dosbatch
    :linenos:
