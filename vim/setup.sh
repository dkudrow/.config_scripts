#!/bin/bash

######################################################################
#
# vim
#
######################################################################

HOME=~/
VIM=$HOME.vim/
REPO=${PWD}/vim/

overwrite ${HOME}.vimrc
if [ $? == 1 ]
then
	echo "> Linking '.vimrc'"
	rm -f ${HOME}.vimrc
	ln -sf ${REPO}.vimrc ${HOME}.vimrc
fi

overwrite ${HOME}.vimrc.local
if [ $? == 1 ]
then
	echo "> Linking '.vimrc.local'"
	rm -f ${HOME}.vimrc.local
	ln -sf ${REPO}.vimrc.local ${HOME}.vimrc.local
fi

mkdir -p ${VIM}autoload/
overwrite ${VIM}autoload/pathogen.vim
if [ $? == 1 ]
then
	echo "> Linking '${VIM}autoload/pathogen.vim'"
	rm -f ${VIM}autoload/pathogen.vim
	ln -sf ${REPO}pathogen/autoload/pathogen.vim ${VIM}autoload/pathogen.vim
fi

mkdir -p ${VIM}bundle/
overwrite ${VIM}bundle/
if [ $? == 1 ]
then
	echo "> Linking '${VIM}bundle/'"
	rm -rf ${VIM}bundle/
	ln -sf ${REPO}bundle ${VIM}
fi
