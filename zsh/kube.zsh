function kundo() {
    local deploy="${1}"
    local rev="${2}"

    if [[ -z "${deploy}" ]] then
        echo "deployment name not informed"
        printf "usage: %s <deployment name> <rev>\n" ${0}
        return
    fi

    if [[ -z "${rev}" ]] then
        echo "revision not informed"
        printf "usage: %s <deployment name> <rev>\n" ${0}
        return
    fi

    printf "undoing deployment[%s] to revision[%s]\n" ${deploy} ${rev}
    kubectl rollout undo deployment/${deploy} --to-revision=${rev}
}

function kupdate() {
    local name="${1}"
    local imgversion="${2}"

    if [[ -z "${name}" ]] then
        echo "deployment name not informed"
        printf "usage: %s <deployment name> <image version>\n" ${0}
        return
    fi

    if [[ -z "${imgversion}" ]] then
        echo "image version not informed"
        printf "usage: %s <deployment name> <image version>\n" ${0}
        return
    fi

    kubectl set image "deployment/${name}" "${name}=${imgversion}" --record
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

function klogs() {
    local deploy="${1}"
    local container="${2}"

    if [[ -z "${deploy}" ]] then
        printf "usage: %s <deploy name> <container name>(optional,default=deploy name)\n" ${0}
        return
    fi

    if [[ -z "${container}" ]] then
        container="${deploy}"
    fi

    kubectl logs -f "deployment/${deploy}" -c "${container}"
}

function kautocomplete() {
    if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi
}

kautocomplete
