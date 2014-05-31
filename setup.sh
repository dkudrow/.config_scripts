#!/bin/bash

######################################################################
#
# Install config scripts locally
#
######################################################################

function overwrite() {
if [ -e $1 ]
then
	read -p "File '$1' already exists. Overwrite? [y]/n " OVERWRITE
	OVERWRITE=${OVERWRITE:-y}
	OVERWRITE=${OVERWRITE:0:1}
	if [ $OVERWRITE != y ] && [ $OVERWRITE != Y ]
	then
		return 0
	else 
		return 1
	fi
else
	return 1
fi
}

export -f overwrite

for d in `ls -d */`
do
	echo "Setting up ${d%/}"...
	./${d}setup.sh
done
