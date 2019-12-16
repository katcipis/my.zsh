
function aur() {
    local packagename="$1"

    if [[ -z "${packagename}" ]] then
        echo "package name not informed"
        printf "usage: %s <package name>\n" ${0}
        return
    fi

    local origdir=$(pwd)
    local workdir=$(mktemp -d)

    cd "${workdir}"
    git clone "https://aur.archlinux.org/${packagename}.git"
    cd "${packagename}"
    makepkg -sri
    cd "${origdir}"
    rm -rf "${workdir}"
}
