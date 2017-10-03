"""
Note: Output written to stdout will be executed in the parent shell.
"""

import sys
import os
import datetime


def log(cmd, args, fname):
    def logwrite(msg):
        with open(fname, 'a') as fp:
            fp.write(msg)

    if cmd == 'begin':
        logfilename = args
        with open(logfilename, 'w') as fp:
            fp.write('start: %s\n' % datetime.datetime.now())
        sys.stdout.write('set "config.logfile=%s"\n' % logfilename)

    elif cmd == 'end':
        logwrite('end: %s\n' % datetime.datetime.now())
        with open(fname, 'r') as fp:
            lines = fp.readlines()
        logwrite(summary(lines))

    elif cmd == 'summary':
        with open(fname, 'r') as fp:
            lines = fp.readlines()
        logwrite(summary(lines))

    elif cmd == 'read':
        with open(fname, 'r') as fp:
            sys.stderr.write(fp.read())

    elif cmd == 'OK':
        msg = '  >> OK   %s\n' % args
        sys.stderr.write(msg)
        logwrite(msg)

    elif cmd == 'FAIL':
        msg = '  >> FAIL %s\n' % args
        sys.stderr.write(msg)
        logwrite(msg)

    else:
        pass

    return 0


def summary(lines):
    ok = fail = 0
    ok = len([line for line in lines if line.startswith('  >> OK   ')])
    fail = len([line for line in lines if line.startswith('  >> FAIL ')])
    msg = "passing: %d  failing: %d:\n" % (ok, fail)
    sys.stderr.write(msg)
    sys.stdout.write('set /a config.passing_tests=%d\n' % ok)
    sys.stdout.write('set /a config.failing_tests=%d\n' % fail)
    return msg


def main():
    cmd = sys.argv[1]
    msg = ' '.join(sys.argv[2:])
    fname = os.environ.get('config.logfile')
    return log(cmd, msg, fname)


if __name__ == "__main__":
    sys.exit(main())
