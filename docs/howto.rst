
How do I..?
==============

Q: How do I reset the errorlevel

.. code-block:: dosbatch

    cmd /c "exit /b 0"


Q: How do I check if a directory exists?

.. code-block:: dosbatch

    pushd "%varname%" 2>NUL && pop
    if errorlevel 1 (
        :: directory does not exist
    ) else (
        :: directory exists
    )

Q: How do I "touch" a file?

.. code-block:: dosbatch

    type NUL >> filename
