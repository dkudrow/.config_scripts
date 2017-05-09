# dotfiles/common.py

import json
import os
import subprocess as sp

HOME = os.path.expanduser('~')
DEVNULL = open(os.path.devnull, 'w')

def check_call(params, *args, **kwargs):
    quiet = params['quiet']
    verbose = params['verbose']
    if verbose:
        print '>>> {}'.format(' '.join(args[0]))
    try:
        if quiet:
            rc = sp.check_call(*args, stdout=DEVNULL, stderr=sp.STDOUT, **kwargs)
        else:
            rc = sp.check_call(*args, **kwargs)
    except OSError as e:
        rc = e.errno
        print e
    except sp.CalledProcessError as e:
        rc = e.returncode
        print e
    except Exception as e:
        rc = -1
        print e
    return rc

def mkdirp(path):
    if os.path.isdir(path):
        return
    os.makedirs(path)

def ln(src, dst, params):
    force = params['force']
    cmd = 'ln -s {} {}'.format(src, dst).split()

    # lexists() returns True for broken symlinks
    if not force and os.path.lexists(dst):
        resp = raw_input('Overwrite {} (Y/n)? [Y] '.format(dst))
        if resp and resp not in ['Y', 'y']:
            return
        else:
            force = True

    if force:
        try:
            # If the destination exists and is a symlink we must remove it.
            # Otherwise ln will try to follow the link.
            os.remove(dst)
            print 'remove succeeded'
        except OSError:
            print 'remove failed'
            pass
        cmd.insert(1, '-f')

    rc = check_call(params, cmd)

    if not rc and not params['quiet']:
        print '{} -> {}'.format(dst, src)
        

def touch(path, params):
    with open(path, 'a'):
        os.utime(path, None)

