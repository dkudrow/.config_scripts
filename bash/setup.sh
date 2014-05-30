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
	if [ -e ${CONFIG_DIR}${CONFIG_FILE} ]
	then
		read -p "File '${CONFIG_DIR}${CONFIG_FILE}' already exists. Overwrite? [y]/n " OVERWRITE
		OVERWRITE=${OVERWRITE:-y}
		OVERWRITE=${OVERWRITE:0:1}
		if [ $OVERWRITE != y ] && [ $OVERWRITE != Y ]
		then
			exit
		fi
	fi

	rm -f ${CONFIG_DIR}${CONFIG_FILE}
	ln -sf ${REPO_DIR}${CONFIG_FILE} ${CONFIG_DIR}${CONFIG_FILE}
done
