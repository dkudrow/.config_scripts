######################################################################
#
# .bash_aliases
#
# Daniel Kudrow (dkudrow@cs.ucsb.edu)
#
######################################################################

alias rm='rm -i'

# ls
if [ $(uname) = 'Darwin' ]; then
	alias ls='ls -G -F -v'
else
	alias ls='ls --color=auto -F -v'
fi
alias ll='ls -Al'
alias la='ls -AF'
alias lf='ls -rt -d -1 $PWD/*'
alias l='ls'
lx() {
	local d
	local a
	d="${1:-.}"
	a="${*:2}"
	ls $a $d/*(.x)
}

# grep
alias grep='grep --binary-files=without-match --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
which rgrep &>/dev/null; [[ $? = 0 ]] || alias rgrep='grep -R'
which hgrep &>/dev/null; [[ $? = 0 ]] || alias hgrep='history | grep'
which pgrep &>/dev/null; [[ $? = 0 ]] || alias pgrep='ps -e | grep'

# use ipython when available
which ipython &> /dev/null && alias python='ipython'

# clipboard
alias cclip='xsel -b -i'
