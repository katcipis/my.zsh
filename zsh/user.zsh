# User configuration
# Set TERM with 256 colors
export TERM=xterm-256color

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

# ls colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"
alias ls='ls --color=tty' || alias ls='ls -G'

# Color grep results
GREP_OPTIONS="--color=auto"
export GREP_OPTIONS="$GREP_OPTIONS"
export GREP_COLOR='1;32'

## pager
export PAGER="less"
export LESS="-R"

export LC_CTYPE=$LANG

alias serve="python -m SimpleHTTPServer"
