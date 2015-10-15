######################################################################
#
# .bash_aliases
#
# Daniel Kudrow (dkudrow@cs.ucsb.edu)
#
######################################################################

alias rm='rm -i'

# Force tmux to assume the terminal supports 256 colours. 
alias tmux='tmux -2'

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

# List only executables
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

# Use ipython when available.
which ipython &> /dev/null && alias python='ipython'

# clipboard
alias cclip='xsel -b -i'

# rc editors
zshed() {
	[[ $1 = '-l' ]] && vim ~/.zshrc.local || vim ~/.zshrc
}

bashed() {
	[[ $1 = '-l' ]] && vim ~/.bashrc.local || vim ~/.bashrc
}

tmuxed() {
	[[ $1 = '-l' ]] && vim ~/.tmux.conf.local || vim ~/.tmux.conf
}
