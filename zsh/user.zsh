# User configuration
# Load color names
autoload colors; colors;

setopt no_beep
setopt auto_cd
setopt multios
setopt cdablevarS

## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

## jobs
setopt long_list_jobs

# Setup the prompt with pretty colors
setopt prompt_subst

## pager
export PAGER="less"
export LESS="-R"

export LC_CTYPE=$LANG
export LC_ALL=en_US.UTF-8
export EDITOR=vim
export NASHROOT=$HOME/nashroot
export NASHPATH=$HOME/nash
export PATH=$LOCALDIR/bin:$LOCALDIR/go/bin:$HOME/go/bin:$NASHROOT/bin:$NASHPATH:/bin:$PATH
export SHELL=$NASHROOT/bin/nash
