fzfkeys=/usr/share/fzf/key-bindings.zsh
fzfcomp=/usr/share/fzf/completion.zs

if [ -f $fzfkeys ]; then
    source $fzfkeys
fi

if [ -f $fzfcomp ]; then
    source $fzfcomp
fi
