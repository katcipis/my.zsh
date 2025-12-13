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
alias archpkgs='pacman -Slq | fzf'

alias vi="vim"

alias sx='ssh-agent startx'

function pdfmerge() {
    gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=${1} ${@:2}
}

function pdfreduce() {
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=${1} ${2}
}

alias lg="lazygit"

function nt() {
    alacritty --working-directory "$(pwd)" &> /dev/null & disown
}

function godbg() {
    local pkg="${1}"
    local testname="${2}"

    if [[ -z "${pkg}" ]] then
        echo "pkg name not informed"
        printf "usage: %s <pkg name> <test name>\n" ${0}
        return
    fi
    dlv test "${pkg}" -- -test.run="${testname}"
}

function excalidraw() {
    echo "open http://localhost:5000"
    docker run --rm -it --name excalidraw -p 5000:80 docker.io/excalidraw/excalidraw:latest
}

function pyenv() {
    local name="${1}"
    local basepath="${HOME}/pyenvs"

    if [[ -z "${name}" ]] then
        name=$(pwd)
    fi

    envpath="${basepath}/${name}"
    python -m venv "${envpath}"
    source "${envpath}/bin/activate"
}

function retrier() {
    until $@
    do
      echo "Try again make image"
    done
}
