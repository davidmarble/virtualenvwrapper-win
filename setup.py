#!/usr/bin/env python

from distribute_setup import use_setuptools
use_setuptools()

PROJECT = 'virtualenvwrapper-win'
AUTHOR = 'David Marble'
EMAIL = 'davidmarble@gmail.com'
DESCRIPTION = ('Port of Doug Hellmann\'s virtualenvwrapper '
               'to Windows batch scripts')
VERSION = '1.1.2'
PROJECT_URL = 'https://github.com/davidmarble/%s/' % (PROJECT)

import os
import sys
import shutil
from setuptools import setup

long_description = ''
try:
    long_description = open('README.rst', 'rt').read()
except IOError:
    pass

PYTHONHOME = sys.exec_prefix

def _easy_install_marker():
    return (len(sys.argv) == 5 and sys.argv[2] == 'bdist_egg' and
            sys.argv[3] == '--dist-dir' and 'egg-dist-tmp-' in sys.argv[-1])

def _being_installed():
    if "--help" in sys.argv[1:] or "-h" in sys.argv[1:]:
        return False
    return 'install' in sys.argv[1:] or _easy_install_marker()

scripts_loc = 'scripts/'
scripts = [
    'add2virtualenv.bat',
    'cd-.bat',
    'cdproject.bat',
    'cdsitepackages.bat',
    'cdvirtualenv.bat',
    'folder_delete.bat',
    'lssitepackages.bat',
    'lsvirtualenv.bat',
    'mkvirtualenv.bat',
    'rmvirtualenv.bat',
    'setprojectdir.bat',
    'toggleglobalsitepackages.bat',
    'whereis.bat',
    'workon.bat',
]

if _being_installed():
    # pre-install
    pass

setup(
    name = PROJECT,
    version = VERSION,

    description = DESCRIPTION,
    long_description = long_description,

    author = AUTHOR,
    author_email = EMAIL,
    url = PROJECT_URL,

    platforms = ['WIN32', 'WIN64', ],

    classifiers = [
        'Development Status :: 4 - Beta',
        'Environment :: Win32 (MS Windows)',
        'License :: OSI Approved :: BSD License',
        'Programming Language :: Python',
        'Programming Language :: Python :: 2',
        'Programming Language :: Python :: 2.4',
        'Programming Language :: Python :: 2.5',
        'Programming Language :: Python :: 2.6',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.0',
        'Programming Language :: Python :: 3.1',
        'Programming Language :: Python :: 3.2',
        'Programming Language :: Python :: 3.3',
        'Intended Audience :: Developers',
        'Environment :: Console', ],

    scripts = [scripts_loc + script for script in scripts],

    install_requires=['virtualenv==1.9.1',],
    
    # extras
    # pywin==0.2

    zip_safe=False,
    )

if _being_installed():
    # post-install
    # Move scripts to PYTHONHOME
    for script in scripts:
        src = os.path.join(PYTHONHOME, 'Scripts', script)
        dst = os.path.join(PYTHONHOME, script)
        # try:
        #     os.remove(dst)
        # except:
        #     pass
        shutil.move(src, dst)
