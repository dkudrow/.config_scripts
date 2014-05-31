#!/bin/bash

######################################################################
#
# bash/
#
######################################################################

CONFIG_FILES=(.bash_aliases)
CONFIG_DIR=~/
REPO_DIR=${PWD}/bash/

for CONFIG_FILE in ${CONFIG_FILES[*]}
do
	overwrite ${CONFIG_DIR}${CONFIG_FILE}
	if [ $? == 1 ]
	then
		rm -f ${CONFIG_DIR}${CONFIG_FILE}
		ln -sf ${REPO_DIR}${CONFIG_FILE} ${CONFIG_DIR}${CONFIG_FILE}
	fi
done
