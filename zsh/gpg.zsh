function gpg_export() {
    gpg --armor --export tiagokatcipis@gmail.com
}

function gpgc() {
    local filepath="${1}"

    if [[ -z "${filepath}" ]] then
        echo "file to be encrypted is obligatory"
        printf "usage: %s <file path>\n" ${0}
        return
    fi

    gpg --encrypt --recipient tiagokatcipis@gmail.com "${filepath}"
}
