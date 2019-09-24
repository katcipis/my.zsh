gcloudsdk=$LOCALDIR/google-cloud-sdk
gcompletion=$gcloudsdk/completion.zsh.inc
gpath=$gcloudsdk/path.zsh.inc

if [ $gcompletion ]; then
    source $gcompletion
fi

if [ $gpath ]; then
    source $gpath
fi
