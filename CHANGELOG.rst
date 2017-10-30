.. please add any noteable changes here as part of a PR

-------
Changes
-------

Version 1.2.4
=====================================


Version 1.2.3
=====================================
* Fixed a problem when the WORKON_HOME folder contained spaces.
* Fixed a bug where cmd.com couldn't pass the Python executable to virtualenv
  if the path included the drive letter.
* Improved publish pipeline.

Version 1.2.2
=====================================
*   -a, -i, and -r options are now available (@thebjorn)
*   added rudimentary test-suite (@thebjorn)
*   fix ``rmvirtualenv`` command which didn't delete directory when
    e.g. pip left extra files (@rcutmore)

Version 1.2.1
=====================================
*   scripts are now left in Scripts directory (@adamc55)

Version 1.2.0 (16-03-2015)
=====================================

Thanks to Christian Long (@christianmlong)
*   ``mkvirtualenv`` hooks
