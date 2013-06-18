#!/usr/bin/env python

from distribute_setup import use_setuptools
use_setuptools()

PROJECT = 'virtualenvwrapper-win'
AUTHOR = 'David Marble'
EMAIL = 'davidmarble@gmail.com'
DESCRIPTION = ('Port of Doug Hellmann\'s virtualenvwrapper '
               'to Windows batch scripts')
VERSION = '1.1.5'
PROJECT_URL = 'https://github.com/davidmarble/%s/' % (PROJECT)
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

import os
import sys
import shutil
import codecs
from setuptools import setup
from setuptools.command.install import install as _setuptools_install

long_description = ''
try:
    long_description = open('README.rst', 'rt').read()
except IOError:
    pass

PYTHONHOME = sys.exec_prefix

class install(_setuptools_install):
    def run(self):
        # pre-install
        _setuptools_install.run(self)
        # post-install
        # Re-write install-record to take into account new file locations
        if self.record:
            newlist = []
            with codecs.open(self.record, 'r', 'utf-8') as f:
                files = f.readlines()
            for f in files:
                fname = f.strip()
                for script in scripts:
                    if fname.endswith(script):
                        newname = fname.replace('Scripts\\','')
                        # try:
                        #     os.remove(dst)
                        # except:
                        #     pass
                        shutil.move(fname, newname)
                        fname = newname
                newlist.append(fname)
            with codecs.open(self.record, 'w', 'utf-8') as f:
                f.write('\n'.join(newlist))

setup(
    cmdclass={'install': install},
    name=PROJECT,
    version=VERSION,

    description=DESCRIPTION,
    long_description=long_description,

    author=AUTHOR,
    author_email=EMAIL,
    url=PROJECT_URL,
    license="BSD 3-clause",
    keywords="setuptools deployment installation distutils virtualenv virtualenvwrapper",

    platforms=['WIN32', 'WIN64',],

    classifiers=[
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

    scripts=[scripts_loc + script for script in scripts],

    install_requires=['virtualenv==1.9.1',],
    
    # extras
    # pywin==0.2

    zip_safe=False,
)