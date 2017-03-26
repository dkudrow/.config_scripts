# dotfiles/__main__.py

from argparse import ArgumentParser
from common import *
import imp
import os

def main():

    params = {}

    parser = ArgumentParser()
    parser.add_argument('-f', action='store_true',
            help='Force all existing files to be overwritten')
    parser.add_argument('-p', action='store_true', help='Pull upstream changes')
    parser.add_argument('-q', action='store_true', help='Quiet output')
    parser.add_argument('-d', default='', help='Directory containing dotfiles')
    parser.add_argument('-v', action='store_true', help='Verbose output')
    parser.add_argument('configs', nargs='*',
            help='Configurations to update, omit to update all')
    args = parser.parse_args()

    params['force'] = args.f
    params['pull'] = args.p
    params['quiet'] = args.q
    params['verbose'] = args.v
    params['cfgs'] = args.configs

    if not args.d:
        params['root'] = os.path.dirname(__file__)
    else:
        params['root'] = args.d
    params['root'] = os.path.abspath(params['root'])

    if params['pull']:
        try:
            check_call(params, 'git pull', shell=True)
            check_call(params, 'git submodule init',  shell=True)
            check_call(params, 'git submodule update',  shell=True)
        except Exception as e:
            print 'Update failed with:'
            print e

    if params['cfgs']:
        dirs = [os.path.join(params['root'], d) for d in params['cfgs']]
    else:
        dirs = [os.path.join(params['root'], d) for d in os.listdir(params['root'])]
    dirs = filter(os.path.isdir, dirs)
    dirs = filter(lambda d: not os.path.basename(d).startswith('.'), dirs)
    params['cfgs'] = dirs

    for d in params['cfgs']:
        path = os.path.join(d, 'setup.py')
        if not os.path.exists(path):
            print 'Did not find setup.py in {}. Skipping.'.format(d)
            continue
        m = imp.load_source('setup', path)
        m.setup(params, d)

if __name__ == '__main__':
    main()
