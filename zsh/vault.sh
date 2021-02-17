function vault() {
    local vaultdir=${HOME}/.vault
    local name="${1}"

    if [[ -z "${name}" ]] then
        printf "usage: %s <name>\n" ${0}
        return
    fi

    local file="${vaultdir}/${name}"
    if [ ! -e "${file}" ]
    then
        printf "no vault file [%s]\n" "${file}"
        return
    fi

    local tmpfile=""
    tmpfile=$(mktemp)

    gpg --batch --yes -d -o "${tmpfile}" "${file}" 
    source "${tmpfile}"
    rm $tmpfile
}
