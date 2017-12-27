.. please add any noteable changes here as part of a PR

Changes
=======

Version <next>
--------------

Version 1.2.5
-------------
* Bugfix release.

Version 1.2.4
-------------
* Fixed problems with spaces in workon, rmvirtualenv, mkproject, mkvirtualenv -a
  when the virtualenv name or project directory contained spaces (#89). @thebjorn
* Fixed problems with spaces etc. in add2virtualenv and setprojectdir (#92, #93) @thebjorn
* Added mkproject convenience script (@thehug0naut)
* folder_delete.bat is deprecated and will be removed in a future version.
  You should be using `rmdir %dirname% /s /q` instead.

Version 1.2.3
-------------
* Fixed a problem when the WORKON_HOME folder contained spaces.
* Fixed a bug where cmd.com couldn't pass the Python executable to virtualenv
  if the path included the drive letter.
* Improved publish pipeline.

Version 1.2.2
-------------
*   -a, -i, and -r options are now available (@thebjorn)
*   added rudimentary test-suite (@thebjorn)
*   fix ``rmvirtualenv`` command which didn't delete directory when
    e.g. pip left extra files (@rcutmore)

Version 1.2.1
-------------
*   scripts are now left in Scripts directory (@adamc55)

Version 1.2.0 (16-03-2015)
--------------------------

Thanks to Christian Long (@christianmlong)
*   ``mkvirtualenv`` hooks
