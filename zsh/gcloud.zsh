gcloudsdk=$LOCALDIR/gcloud
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

    if [[ -z "${project}" ]] then
        echo "project id not informed"
        printf "usage: %s <project id>\n" ${0}
        return
    fi

    if [[ -z "${severity}" ]] then
        severity="INFO"
    fi

    gcloud logging read --format=json --project "${project}" "severity>=${severity}"
}
