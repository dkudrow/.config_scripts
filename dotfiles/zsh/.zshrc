export DOTFILES=$HOME/.dotfiles/dotfiles/zsh
# Path to your oh-my-zsh installation.
export ZSH=$DOTFILES/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="dkudrow"

# zsh options
setopt noincappendhistory
setopt appendhistory

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$DOTFILES/custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
    #zsh-autosuggestions     \
	#zsh-syntax-highlighting \
plugins=(                   \
    brew                    \
    git                     \
    ruby                    \
    tmux                    \
)

source $ZSH/oh-my-zsh.sh

# Adjust PATH
export PATH=$HOME/bin:$PATH
export PATH=/usr/local/bin:$PATH

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# User configuration
export EDITOR=vi

# Get local config optinos
source $HOME/.zshrc.local

bindkey '^U' backward-kill-line

# zsh-autosuggestions
#zle-line-init() {
    #zle autosuggest-start
#}
#zle -N zle-line-init
#AUTOSUGGESTION_ACCEPT_RIGHT_ARROW=1
#bindkey '^t' autosuggest-toggle

# Make sure we get .bash_aliases
source ~/.bash_aliases
