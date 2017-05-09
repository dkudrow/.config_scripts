# dotfiles/vim/setup.py

from dotfiles.common import *
import os

def setup(params, cfgdir):

    for f in ['.vimrc']:
        src = os.path.join(cfgdir, f)
        dst = os.path.join(HOME, f)
        ln(src, dst, params)

    touch(os.path.join(HOME, '.vimrc.local'), params)

    vimsrc = os.path.join(cfgdir, '.vim')
    vimdst = os.path.join(HOME, '.vim')

    tmplsrc = os.path.join(vimsrc, 'templates')
    tmpldst = os.path.join(vimdst, 'templates')
    mkdirp(tmpldst)
    for f in os.listdir(tmplsrc):
        src = os.path.join(tmplsrc, f)
        dst = os.path.join(tmpldst, f)
        ln(src, dst, params)

    autoloaddst = os.path.join(vimdst, 'autoload')
    mkdirp(autoloaddst)
    plugsrc = os.path.join(cfgdir, 'vim-plug', 'plug.vim')
    plugdst = os.path.join(autoloaddst, 'plug.vim')
    ln(plugsrc, plugdst, params)


