#!/bin/bash

######################################################################
#
# bash/
#
######################################################################

CONFIG_FILES=(.bashrc .bash_aliases)
CONFIG_DIR=~/
REPO_DIR=${PWD}/bash/

if [ ! -e ${HOME}.bashrc.local ]
then
	echo "> Creating '${HOME}.bashrc.local"
	>${HOME}.bashrc.local
fi

for CONFIG_FILE in ${CONFIG_FILES[*]}
do
	overwrite ${CONFIG_DIR}${CONFIG_FILE}
	if [ $? == 1 ]
	then
		echo "> Linking '${CONFIG_DIR}${CONFIG_FILE}'"
		rm -f ${CONFIG_DIR}${CONFIG_FILE}
		ln -sf ${REPO_DIR}${CONFIG_FILE} ${CONFIG_DIR}${CONFIG_FILE}
	fi
done
