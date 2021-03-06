gcloudsdk=$LOCALDIR/google-cloud-sdk
gcompletion=$gcloudsdk/completion.zsh.inc
gpath=$gcloudsdk/path.zsh.inc

if [ -f $gcompletion ]; then
    source $gcompletion
fi

if [ -f $gpath ]; then
    source $gpath
fi

function glogs() {
    local project="${1}"
    local severity="${2}"
    local container="${3}"
    local pod="${4}"

    if [[ -z "${project}" ]] then
        echo "project id not informed"
        printf "usage: %s <project id> <severity>(optional) <container>(optional) <pod>(optional)\n" ${0}
        return
    fi

    if [[ -z "${severity}" ]] then
        severity="INFO"
    fi

    local filter="severity>=${severity}"

    if [[ ! -z "${container}" ]] then
        filter="${filter} AND resource.labels.container_name=${container}"
    fi

    if [[ ! -z "${pod}" ]] then
        filter="${filter} AND resource.labels.pod_name=${pod}"
    fi

    gcloud logging read --format=json --project "${project}" "${filter}"
}
