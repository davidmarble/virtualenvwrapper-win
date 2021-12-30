# -*- coding: utf-8 -*-
"""
This file defines tasks for the Invoke tool: http://www.pyinvoke.org

Basic usage::

    inv -l               # list all available tasks
    inv --help task      # show help for task

"""
# pragma: nocover
from __future__ import print_function

import glob
import os
import re
import sys
import invoke
from invoke import task       # invoke==1.2.0

DIRNAME = os.path.dirname(__file__)


@task
def version(ctx):
    """Print the current version number.
    """
    os.chdir(DIRNAME)
    ctx.run('python setup.py --version')


@task
def setversion(ctx, version):
    """Set the version number
    """
    os.chdir(DIRNAME)
    with open('setup.py', 'r') as fp:
        txt = fp.read()

    with open('setup.py', 'w') as fp:
        fp.write(re.sub(
            r'^VERSION\s*=\s*.*?$', "VERSION = '%s'" % version,
            txt,
            flags=re.MULTILINE
        ))
    print("Changed version in setup.py to:", version)


@task(
    help={
        'clean': 'remove the build/ and dist/ directory before starting',
        'wheel': 'build wheel (in addition to sdist)',
        'upload': 'upload to PyPI after building'
    }
)
def build(ctx, clean=False, wheel=True, upload=False):
    """Build and publish (inv --help build for details)
    """
    os.chdir(DIRNAME)
    if clean:
        ctx.run('rmdir dist /s /q', warn=True)
        ctx.run('rmdir build /s /q', warn=True)

    targets = 'sdist'
    if wheel:
        targets += ' bdist_wheel'
    ctx.run("python setup.py " + targets)

    print("Check generated .whl files..")
    ctx.run("twine check dist/*")

    # ctx.run("python setup.py build_sphinx")
    if upload:
        ctx.run("twine upload dist/*")


# individual tasks that can be run from this project
ns = invoke.Collection(
    version,
    setversion,
    build
)
ns.configure({
    'run': {
        'echo': True
    }
})
