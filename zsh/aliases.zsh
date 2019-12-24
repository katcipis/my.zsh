# Show history
if [ "$HIST_STAMPS" = "mm/dd/yyyy" ]
then
    alias history='fc -fl 1'
elif [ "$HIST_STAMPS" = "dd.mm.yyyy" ]
then
    alias history='fc -El 1'
elif [ "$HIST_STAMPS" = "yyyy-mm-dd" ]
then
    alias history='fc -il 1'
else
    alias history='fc -l 1'
fi

# git
alias gclean='git remote prune origin'

# Update arch
alias archupdate='sudo pacman -Sy archlinux-keyring && sudo pacman -Syyu'

# Generate password
alias genpassword="openssl rand -base64 32"

# Stats
alias io="iostat -xmdz 1"

alias vi="vim"

alias sx='ssh-agent startx'
