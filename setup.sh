#!/bin/bash

######################################################################
#
# Install config scripts locally
#
######################################################################

DIRS=

# Make this check available to all of the setup scripts
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

# Allow user to select which configs to include
if [ $# -eq 0 ]
then
	DIRS="`ls -d */`"
else
	DIRS=$@
fi

# Run the desired setup scripts
for d in $DIRS
do
	echo "Setting up ${d%/}"...
	./${d}/setup.sh
done
