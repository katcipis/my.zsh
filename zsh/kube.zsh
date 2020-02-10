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
        printf "usage: %s <deployment name> <revision (optional)\n" ${0}
        return
    fi

    local rev="${2}"

    if [[ -z "${rev}" ]] then
        printf "listing deployment[%s] revisions\n" ${deploy}
        kubectl rollout history deployment/${deploy}
        return
    fi

    printf "detailing deployment[%s] revision[%s]\n" ${deploy} ${rev}
    kubectl rollout history deployment/${deploy} --revision=${rev}
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
    local label="${1}"
    local name="${2}"
    local container="${3}"

    if [[ -z "${label}" ]] then
        printf "usage: %s <label> <label value> <container name>(optional,default=<label value>)\n" ${0}
        return
    fi

    if [[ -z "${name}" ]] then
        printf "usage: %s <label> <label value> <container name>(optional,default=<label value>)\n" ${0}
        return
    fi

    if [[ -z "${container}" ]] then
        container="${name}"
    fi

    kubectl logs -f -l${label}=${name} -c ${container}
}

function kautocomplete() {
    if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi
}

function kimgver() {
    local deploy="${1}"
    local container="${2}"

    if [[ -z "${deploy}" ]] then
        printf "usage: %s <deploy name> <container name>(optional,default=<deploy name>)\n" ${0}
        return
    fi

    if [[ -z "${container}" ]] then
        container="${deploy}"
    fi

    local filter=$(printf '.spec.template.spec.containers[] | if .name == "%s" then .image else empty end' "${container}")

    kubectl -o json get "deployment/${deploy}" | jq -r "${filter}"
}

kautocomplete
