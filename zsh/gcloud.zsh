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

    if [[ -z "${project}" ]] then
        echo "project id not informed"
        printf "usage: %s <project id>\n" ${0}
        return
    fi

    gcloud logging read --order=asc --format=json --project "${project}"
}
