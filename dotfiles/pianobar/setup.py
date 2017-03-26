# dotfiles/pianobar/setup.py

from dotfiles.common import *
import os

def setup(params, cfgdir):
    src = os.path.join(cfgdir, 'config')
    dstdir = os.path.join(HOME, '.config', 'pianobar')
    dst = os.path.join(dstdir, 'config')

    mkdirp(dstdir)
    ln(src, dst, params)

