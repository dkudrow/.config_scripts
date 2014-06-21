#!/bin/bash

######################################################################
#
# pianobar/setup.sh
#
######################################################################

CONFIG_FILES=(config)
LOCAL_FILES=()
CONFIG_DIR=~/.config/pianobar/
REPO_DIR=${PWD}/pianobar/

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

for LOCAL_FILE in ${LOCAL_FILES[*]}
do
	if [ ! -e ${CONFIG_DIR}${LOCAL_FILE} ]
	then
		echo "> Creating '${CONFIG_DIR}${LOCAL_FILE}'"
		>${CONFIG_DIR}${LOCAL_FILE}
	fi
done
