#!/bin/bash

######################################################################
#
# Install config scripts locally
#
######################################################################

export CONFIG_SCRIPTS=~/.config_scripts/

######################################################################
#
# Parse command line arguments
#
######################################################################

export FORCE=false
export FORCENO=false
export QUIET=false
export UPDATE=false
export VERBOSE=false

while getopts :fnquv OPT; do
	case $OPT in
		f) # -f	Force all files to be overwritten
			FORCE=true
			;;
		n) # -n	Force all files NOT to be overwritten
			FORCENO=true
			;;
		q) # -q	Only write to screen to request user input
			QUIET=true
			;;
		u) # -u	Pull changes from the git repositories
			UPDATE=true
			;;
		v) # -v	Print every shell command
			VERBOSE=true
			;;
		*) # Show usage message
			cat << EOF
Usage: ./setup.sh [OPTION]... [DIR]...
Install configuration scripts from .config_scripts repository

  -f	force all existing files to be overwritten
  -q	suppress output
  -n	do not overwrite any existing files
  -u	pull changes from the git repositories
  -v	print all shell commands executed

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
function check_exists() {
[ "$FORCE" = true ] && return 1
if [ -e $1 ]
then
	[ "$FORCENO" = true ] && return 0
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

function install_file() {
check_exists ${CONFIG_DIR}$1
if [ $? == 1 ]
then
	[ $QUIET != true ] && echo "-- Linking '${CONFIG_DIR}$1'"
	[ $VERBOSE = true ] && echo "rm -f ${CONFIG_DIR}$1"
	rm -f ${CONFIG_DIR}$1
	[ $VERBOSE = true ] && echo "ln -sf ${REPO_DIR}$1 ${CONFIG_DIR}$1"
	ln -sf ${REPO_DIR}$1 ${CONFIG_DIR}$1
fi
}

# Install a list of files	
function install_files() {
for f in ${CONFIG_FILES[@]}
do
	# TODO
	[ $VERBOSE = true ] && echo mkdir -p $CONFIG_DIR
	mkdir -p $CONFIG_DIR
	# If the path ends with a '/' it's a directory
	if [ ${f:$((${#f}-1)):1} = '/' ]
	then
		[ $VERBOSE = true ] && echo mkdir -p $CONFIG_DIR$f
		mkdir -p $CONFIG_DIR$f
		for g in `ls $REPO_DIR$f`
		do
			install_file "$f$g"
		done
	else
		# Build path if required
		IFS='/' read -a split <<< "$f"
		STRLEN=${#split[@]}
		if [ $STRLEN -gt 1 ]
		then
			PATH_TO=${split[*]::$((STRLEN-1))}
			PATH_TO=${PATH_TO// /\/}
			[ $VERBOSE = true ] && echo mkdir -p ${CONFIG_DIR}$PATH_TO
			mkdir -p ${CONFIG_DIR}$PATH_TO
		fi
		install_file $f
	fi
done
}

function mk_local_stubs() {
for f in ${LOCAL_FILES[@]}
do
	if [ ! -e ${CONFIG_DIR}${f} ]
	then
		[ $QUIET != true ] && echo "> Creating '${CONFIG_DIR}${f}'"
		[ $VERBOSE = true ] && echo ">${CONFIG_DIR}${f}"
		>${CONFIG_DIR}${f}
	fi
done
}

######################################################################
#
# Perform the installation
#
######################################################################

# Pull the submodules from git
if [ $UPDATE = true ]
then
	git pull
	git submodule init
	git submodule update
fi

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
	export CONFIG_FILES=
	export LOCAL_FILES=
	export CONFIG_DIR=
	export REPO_DIR=
	source ${d}/setup.sh
	install_files
	mk_local_stubs
done

######################################################################
#
# Clean up
#
######################################################################

unset FORCE
unset QUIET
unset FORCENO
unset VERBOSE
