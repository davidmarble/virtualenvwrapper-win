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

DIRNAME = os.path.dirname(__file__)

# unfortunately invoke is currently a bit broken on windows..
try:
    from invoke import ctask as _task
except ImportError:
    from invoke import task as _task

if invoke.__version_info__ < (0, 22):
    _should_patch = True
elif invoke.__version_info__ < (0, 22 + 22-13):  # broken since 13..
    from invoke import run as _run
    try:
        _run('rem')
        _should_patch = False
    except WindowsError:
        _should_patch = True


if _should_patch:
    # https://github.com/pyinvoke/invoke/pull/407
    from invoke import Context

    if not getattr(Context, '_patched', False):
        Context._patched = True
        _orig_run = Context.run

        def run(self, command, **kwargs):
            if sys.platform == 'win32':
                kwargs['shell'] = os.environ['COMSPEC']
            return _orig_run(self, command, **kwargs)

        Context.run = run

task = _task


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
    with open('setup.py', 'rb') as fp:
        txt = fp.read()

    with open('setup.py', 'wb') as fp:
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
        'sign': 'sign the wheel',
        'upload': 'upload to PyPI after building'
    }
)
def build(ctx, clean=False, wheel=True, sign=True, upload=False):
    """Build and publish (inv --help build for details)
    """
    os.chdir(DIRNAME)
    if clean:
        ctx.run('rmdir dist /s /q', warn=True)
        ctx.run('rmdir build /s /q', warn=True)

    print("check README.rst syntax..")
    r = ctx.run("python setup.py check --restructuredtext --strict")

    targets = 'sdist'
    if wheel:
        targets += ' bdist_wheel'
    ctx.run("python setup.py " + targets)

    if wheel and sign:
        for fname in glob.glob('dist/*.whl'):
            ctx.run('wheel sign ' + fname)

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
