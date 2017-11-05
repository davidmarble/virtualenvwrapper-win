.. _coding-style:

Coding style
==============

This document is an explanation of the coding style I've used, and not necessarily
prescriptive.

See the companion doc :doc:`stdlayout` for layout of the entire file.


Simulated blocks
---------------------------------------
DOS doesn't care about indentation in most cases, so we're free to use it to
simulate structure, e.g.:

.. code-block:: dosbatch

    :error_message
        echo.
        echo.  Error: %*
        echo.
        goto:eof

the indentation is not syntactically needed, but it makes the subroutine easier to
find in a large script.

For commands that come in pairs it is natural to indent the block between them, e.g.:

.. code-block:: dosbatch

    pushd "%WORKON_HOME%"
        dir /ad /w
    popd

where ``dir`` is indented.

A comment can also be used as an indentation tool:

.. code-block:: dosbatch

    :: set default values
        set "prefix.foo=%~1"


Handling paths with spaces
----------------------------------
Newer Pythons are likely to be installed in paths with spaces, and ``%USERPROFILE%``
is also likely to contain spaces for many users.  Our code must therefore handle spaces
gracefully.

.. warning:: This section is WIP as I'm learning..

Convert to quoteless on input
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I.e. remove the quotes when assigning to a variable:

.. code-block:: dosbatch

    set "myvar=%~1"

and then add quotes when using the variable:

.. code-block:: dosbatch

    mkdir "%myvar%"


Prefixed local variables
-----------------------------

Each file should store their local variables (variables that shouldn't escape
into the calling environment) in variables that have a prefix that is unique
amongst all ``virtualenvrapper-win`` .bat files.


.. literalinclude:: _static/stdlayout.bat
    :language: dosbatch
    :linenos:
    :lines: 7-9

This makes it easy to clean them up before exiting the script, and makes obviates
the need to use ``setlocal`` on most of the script.


.. literalinclude:: _static/stdlayout.bat
    :language: dosbatch
    :linenos:
    :lines: 90-92

