function kundo() {
    local deploy="${1}"
    local rev="${2}"

    if [[ -z "${deploy}" ]] then
        printf "usage: %s <deployment name> <rev>\n" ${0}
        return
    fi

    if [[ -z "${rev}" ]] then
        printf "usage: %s <deployment name> <rev>\n" ${0}
        return
    fi

    printf "undoing deployment[%s] to revision[%s]\n" ${deploy} ${rev}
    kubectl rollout undo deployment/${deploy} --to-revision=${rev}
}

function krev() {
    local deploy="${1}"

    if [[ -z "${deploy}" ]] then
        printf "usage: %s <deployment name>\n" ${0}
        return
    fi

    printf "listing deployment[%s] revisions\n" ${deploy}
    kubectl rollout history deployment/${deploy}
}
