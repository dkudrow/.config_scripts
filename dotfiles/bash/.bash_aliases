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
	alias ls='ls -G'
else
	alias ls='ls --color=auto'
fi
alias ll='ls -Al'
alias la='ls -AF'
alias lf='ls -rt -d -1 $PWD/*'
alias l='ls -F -v'

# List only executables
lx() {
	ls -F $@ | grep '\*$' | sed 's/.$//'
}



# git
alias gad='git add'
alias gbr='git branch'
alias gch='git checkout'
alias gcl='git clone'
alias gco='git commit'
alias gcp='git cp'
alias gdi='git diff'
alias gin='git init'
alias gme='git merge'
alias gmv='git mv'
alias gpl='git pull'
alias gps='git push'
alias grb='git rebase'
alias grs='git reset'
alias grm='git rm'
alias gst='git status'
alias gig='vim .gitignore'

#svn
alias svnst='svn st --ignore-externals'

# grep
alias grep='grep --binary-files=without-match --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
which rgrep &>/dev/null || alias rgrep='grep -R'
which hgrep &>/dev/null || alias hgrep='history | grep'
which pgrep &>/dev/null || alias pgrep='ps -e | grep'
which ag    &>/dev/null || alias    ag='ack-grep'
which ack   &>/dev/null || alias   ack='ack-grep'

# Use ipython when available.
#which ipython &> /dev/null && alias python='ipython'
alias ipy='ipython'

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

vimed() {
	[[ $1 = '-l' ]] && vim ~/.vimrc.local || vim ~/.vimrc
}

