######################################################################
#
# .bashrc
#
# Daniel Kudrow (dkudrow@cs.ucsb.edu)
#
######################################################################

# If not running interactively, don't do anything
case $- in
	*i*)
		;;
	*) return
		;;
esac

######################################################################
#
# Includes
#
######################################################################

# Alias definitions
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# Global settings
[ -f /etc/bashrc ] && . /etc/bashrc

######################################################################
#
# History
#
######################################################################

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend

######################################################################
#
# Colors
#
######################################################################

ORIG_TERM=$TERM

COLORS=( '' '16' '88' '256' )

TERMINFO_DIRS=( /usr/share/terminfo /lib/terminfo /etc/terminfo )

# Check whether a this terminal is supported
CheckTerminfo() {
	for d in "${TERMINFO_DIRS[@]}"; do
		[ -e $d/${1:0:1}/$1 ] && return 1
	done
	return 0
}

# Set TERM to the most colorful terminal available
SetTermColor() {
	TERMBASE=$1
	for color in "${COLORS[@]}"; do 
		CheckTerminfo "$TERMBASE-${color}color"
		if [ $? -eq 1 ]; then
			TERM=$TERMBASE-${color}color
		fi
	done
}

case "$TERM" in
	xterm) SetTermColor "xterm"
		;;
	screen) SetTermColor "screen"
		;;
	*)
		;;
esac

#echo "TERM: '$ORIG_TERM' -> '$TERM'"

######################################################################
#
# Prompt
#
######################################################################

# set variable identifying the chroot you work in
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

force_color_prompt=yes	# force a color prompt if possible

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
	xterm*|rxvt*) PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
		;;
	*)
		;;
esac

######################################################################
#
# Miscellaneous options
#
######################################################################

shopt -s checkwinsize	# check the window size after each command
shopt -s globstar	# pattern "**" matches subdirs recursively 

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable programmable completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

######################################################################
#
# Local overrides
#
######################################################################

# Local configuration
[ -f ~/.bashrc.local ] && . ~/.bashrc.local

######################################################################
#
# Last words?
#
######################################################################

#date
#echo
