# dotfiles/bash/setup.py

from dotfiles.common import *
import os

def setup(params, cfgdir):

    for f in ['.bashrc', '.bash_aliases']:
        src = os.path.join(cfgdir, f)
        dst = os.path.join(HOME, f)
        ln(src, dst, params)

    touch(os.path.join(HOME, '.bashrc.local'), params)

