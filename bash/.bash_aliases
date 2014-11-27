######################################################################
#
# .bash_aliases
#
# Daniel Kudrow (dkudrow@cs.ucsb.edu)
#
######################################################################

# ssh
alias csil='ssh dkudrow@$(ssh dkudrow@csil.cs.ucsb.edu "~/bin/csil_hosts")'

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

# ps
alias ps='ps -o user,pid,args'

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
alias cclip='xclip -selection "clipboard"'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Documentation that doesn't install to /usr/share/man
vman() {
	eval "$@ | vim - "
}
