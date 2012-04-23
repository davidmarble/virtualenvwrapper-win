#!/usr/bin/env python

PROJECT = 'virtualenvwrapper-win'
AUTHOR = 'davidmarble'
EMAIL = 'davidmarble@gmail.com'
DESCRIPTION = ('Port of Doug Hellmann\'s virtualenvwrapper '
               'to Windows batch scripts')
VERSION = '1.0.7'
PROJECT_URL = 'https://github.com/%s/%s/' % (AUTHOR, PROJECT)

from setuptools import setup
import os
import sys

long_description = ''
try:
    long_description = open('README.rst', 'rt').read()
except IOError:
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
        'Development Status :: 5 - Production/Stable',
        'Environment :: Win32 (MS Windows)',
        'License :: OSI Approved :: BSD License',
        'Programming Language :: Python',
        'Programming Language :: Python :: 2',
        'Programming Language :: Python :: 2.4',
        'Programming Language :: Python :: 2.5',
        'Programming Language :: Python :: 2.6',
        'Programming Language :: Python :: 2.7',
        'Intended Audience :: Developers',
        'Environment :: Console', ],

    scripts = [
        'scripts/add2virtualenv.bat',
        'scripts/cd-.bat',
        'scripts/cdproject.bat',
        'scripts/cdsitepackages.bat',
        'scripts/cdvirtualenv.bat',
        'scripts/folder_delete.bat',
        'scripts/lssitepackages.bat',
        'scripts/lsvirtualenv.bat',
        'scripts/mkvirtualenv.bat',
        'scripts/pyassoc.bat',
        'scripts/python.bat',
        'scripts/rmvirtualenv.bat',
        'scripts/setprojectdir.bat',
        'scripts/toggleglobalsitepackages.bat',
        'scripts/workon.bat',
         ],

    install_requires=['virtualenv', ],

    zip_safe=False,
    )
