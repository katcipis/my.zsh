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

# Update arch
alias archupdate='sudo pacman -Sy archlinux-keyring && sudo pacman -Syyu'

alias vi="vim"

alias sx='ssh-agent startx'

function pdfmerge() {
    gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=${1} ${@:2}
}

function pdfreduce() {
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=${1} ${2}
}

alias lg="lazygit"

alias nt="alacritty --working-directory $(pwd) &> /dev/null & disown"
