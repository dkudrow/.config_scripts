######################################################################
#
# .bash_aliases
#
# Daniel Kudrow (dkudrow@cs.ucsb.edu)
#
######################################################################

# SSH aliases
alias csil='ssh dkudrow@csil.cs.ucsb.edu'
alias ec2='ssh -i ~/.ssh/dani-aws -l ec2-user '
alias ub='ssh -i ~/.ssh/dani-aws -l ubuntu '

alias rm='rm -i'

# Mac's ls is stupid
if [ $(uname) = 'Darwin' ]; then
	alias ls='ls -G -F -v'
else
	alias ls='ls --color=auto -F -v'
fi

alias ll='ls -Al'
alias la='ls -AF'
alias lf='ls -rt -d -1 $PWD/*'
alias l='ls'

alias grep='grep --binary-files=without-match --color=auto'
alias rgrep='grep -R'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias hgrep='history | grep'
alias pgrep='ps -e | grep'

alias cclip='xclip -selection "clipboard"'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

