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

alias own='sudo chown -R "${USER}:${USER}" .'

# git
alias gclean='git remote prune origin'

# Update arch
alias archupdate='sudo pacman -Sy archlinux-keyring && sudo pacman -Syyu'

# Generate password
alias genpassword="openssl rand -base64 32"

alias vi="vim"

alias sx='ssh-agent startx'

alias movies='cd /mnt/media/movies/todo && nautilus . && cd -'

alias series='cd /mnt/media/series && nautilus . && cd -'

function pdfmerge() {
    gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=${1} ${@:2}
}

function pdfreduce() {
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=${1} ${2}
}
