
import sys
import os

CURRENT_MODULE = os.environ['config.current_module']
CURRENT_TEST = os.environ['config.current_test']


def log(cmd, args=''):
    os.system('_log %s %s:%s %s' % (
        cmd,
        CURRENT_MODULE,
        CURRENT_TEST,
        args
    ))
    return 0 if cmd == 'OK' else 1


def assert_contains(fname, text, NOT=''):
    """Returns True if ``text`` occurs in ``fname``.
    """
    with open(fname) as fp:
        contents = fp.read()
        if NOT == 'NOT':
            if text not in contents:
                return log('OK', "didn't find [%s]" % text)
            else:
                return log('FAIL', 'found ' + text + ' in ' + contents)
        else:
            if text in contents:
                return log('OK', 'found [%s]' % text)
            else:
                return log('FAIL', '[%s] not in %s' % (text, contents))


if __name__ == "__main__":
    # print 'SYS>ARGV', sys.argv
    sys.exit(assert_contains(*sys.argv[1:]))
