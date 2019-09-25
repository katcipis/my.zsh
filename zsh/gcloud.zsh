gcloudsdk=$LOCALDIR/gcloud
gcompletion=$gcloudsdk/completion.zsh.inc
gpath=$gcloudsdk/path.zsh.inc

if [ -f $gcompletion ]; then
    source $gcompletion
fi

if [ -f $gpath ]; then
    source $gpath
fi
