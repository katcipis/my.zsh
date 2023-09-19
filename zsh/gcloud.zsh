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

function gke_config() {
    local project="${1}"
    local zone="${2}"
    local cluster="${3}"

    if [[ -z "${project}" ]] then
        echo "project is required"
        printf "usage: %s <project> <zone> <cluster>\n" ${0}
        return
    fi
    if [[ -z "${zone}" ]] then
        echo "zone is required"
        printf "usage: %s <project> <zone> <cluster>\n" ${0}
        return
    fi
    if [[ -z "${cluster}" ]] then
        echo "cluster is required"
        printf "usage: %s <project> <zone> <cluster>\n" ${0}
        return
    fi

    gcloud container clusters get-credentials ${cluster} --zone ${zone} --project ${project}
}

function gsecrets_list() {
    local project="${1}"
    local name="${2}"

    if [[ -z "${project}" ]] then
        echo "project name not informed"
        printf "usage: %s <project name> <secret name>\n" ${0}
        return
    fi

    if [[ -z "${name}" ]] then
        echo "secret name not informed"
        printf "usage: %s <project name> <secret name>\n" ${0}
        return
    fi

    gcloud secrets versions list ${name} --project ${project}
}

function gsecret_last() {
    local project="${1}"
    local name="${2}"

    if [[ -z "${project}" ]] then
        echo "project name not informed"
        printf "usage: %s <project name> <secret name>\n" ${0}
        return
    fi

    if [[ -z "${name}" ]] then
        echo "secret name not informed"
        printf "usage: %s <project name> <secret name>\n" ${0}
        return
    fi

    local last_version
    last_version=$(gcloud secrets versions list ${name} --format='value(name)' --project "${project}" --limit=1)

    if [[ -z "${last_version}" ]]; then
        echo "No versions found for secret ${name} in project ${project}"
        return
    fi

    gcloud secrets versions access "${last_version}" --project "${project}" --secret "${name}"
}

function gsecret_add() {
    local project="${1}"
    local name="${2}"
    local file="${3}"

    if [[ -z "${project}" ]]; then
        echo "project name not informed"
        printf "usage: %s <project name> <secret name> <file name>\n" ${0}
        return
    fi

    if [[ -z "${name}" ]]; then
        echo "secret name not informed"
        printf "usage: %s <project name> <secret name> <file name>\n" ${0}
        return
    fi

    if [[ -z "${file}" ]]; then
        echo "file name not informed"
        printf "usage: %s <project name> <secret name> <file name>\n" ${0}
        return
    fi

    gcloud secrets versions add "${name}" --data-file="${file}" --project "${project}"
}
