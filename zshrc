# Path to your oh-my-zsh installation.
export ZSH=$HOME/.zsh

# Load Theme
source $ZSH/themes/katcipis.zsh

# Load Aliases
source $ZSH/aliases.zsh

# Load History Prefs
source $ZSH/history.zsh

# Load Complete Prefs
source $ZSH/completion.zsh

# Load User Prefs
source $ZSH/user.zsh

# Load golang Prefs
source $ZSH/golang.zsh
source $ZSH/nash.zsh

export PLAN9=/usr/local/plan9
export PATH=$PATH:$PLAN9/bin
