#!/bin/bash

######################################################################
#
# Install config scripts locally
#
######################################################################

######################################################################
#
# Parse command line arguments
#
######################################################################

FORCE=false
export FORCE
QUIET=false
export QUIET

while getopts :fq OPT; do
	case $OPT in
		f)	# -f	Force all files to be overwritten
			FORCE=true
			;;
		q) # -q	Only write to screen to request user input
			QUIET=true
			;;
		*) # Show usage message
			cat << EOF
Usage: ./setup.sh [OPTION]... [DIR]...
Install configuration scripts from .config_scripts repository

  -f	force all existing files to be overwritten
  -q	suppress output

Each DIR is a directory in .config_scripts/. If no directories are
specified, all directories will be installed by default.
EOF
			exit 1
			;;
	esac
done

# Shift the positional parameters
shift $((OPTIND-1))

######################################################################
#
# Installation functions
#
######################################################################

# If a file already exists, determine whether to overwrite it
function overwrite() {
if [[ -e $1 && "$FORCE" != true ]]
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

######################################################################
#
# Perform the installation
#
######################################################################

# Determine which files to install
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

######################################################################
#
# Clean up
#
######################################################################

unset FORCE
unset QUIET
unset overwrite
