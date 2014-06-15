######################################################################
#
# .bashrc
#
# Daniel Kudrow (dkudrow@cs.ucsb.edu)
#
######################################################################

alias csil='ssh dkudrow@csil.cs.ucsb.edu'

alias rm='rm -i'

alias ls='ls --color=auto -F -v'
alias ll='ls -Al'
alias la='ls -AF'
alias l='ls'

alias grep='grep --binary-files=without-match'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias hgrep='history | grep'
alias pgrep='ps -e | grep'

alias cclip='xclip -selection "clipboard"'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
