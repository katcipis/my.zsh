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

function kevents_json_all() {
    kubectl get events --sort-by='.lastTimestamp' --output=json
}

function kevents() {
    local evtype="${1}"

    if [[ -z "${evtype}" ]] then
        kevents_json_all
        return
    fi

    local filter=$(printf '.items[] | select(.type=="%s")' "${evtype}")
    kevents_json_all | jq "${filter}"
}