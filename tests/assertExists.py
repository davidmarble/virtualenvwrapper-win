
import sys, os


current_module = os.environ.get('config.current_module')
current_test = os.environ.get('config.current_test')


def writemsg(status, msg):
    sys.stderr.write("  >> %-4s %s:%s  %s\n" % (
        status,
        current_module,
        current_test,
        msg
    ))
    sys.stderr.flush()


def assertExists(fname, text=None):
    if os.path.exists(fname):
        if text is None:
            writemsg('OK', '[%s] exists' % fname)
        elif open(fname).read().strip() == text.strip():
            writemsg('OK', '[%s] exists' % fname)
        else:
            writemsg('FAIL', '[%s] exists, but contains [%s], not [%s]' % (
                fname, open(fname).read().strip(), text.strip()
            ))
    else:
        writemsg('FAIL', '[%s] does not exist' % fname)


if __name__ == "__main__":
    print "in PYTHON [{}]".format(sys.argv)
    assertExists(*sys.argv[1:])
