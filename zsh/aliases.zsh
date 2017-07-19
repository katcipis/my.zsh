# Show history
if [ "$HIST_STAMPS" = "mm/dd/yyyy" ]
then
    alias history='fc -fl 1'
elif [ "$HIST_STAMPS" = "dd.mm.yyyy" ]
then
    alias history='fc -El 1'
elif [ "$HIST_STAMPS" = "yyyy-mm-dd" ]
then
    alias history='fc -il 1'
else
    alias history='fc -l 1'
fi

#XClip magic
alias tox='xclip -selection clipboard'
alias fromx='xclip -selection clipboard -o'

#git
alias gclean='git remote prune origin'

#VPN
alias vpnstart='sudo systemctl start openvpn-client@client.service'
alias vpnstop='sudo systemctl stop openvpn-client@client.service'

#Update arch
alias archupdate='sudo pacman -Sy archlinux-keyring && sudo pacman -Syyu'

#Generate password
alias genpassword="openssl rand -base64 32"

#Stats
alias io="iostat -xmdz 1"

# Neoway Network
alias netstart="sudo systemctl start dhcpcd@enp1s0"

# Go
alias gohub="cd $HOME/workspace/go/src/github.com/NeowayLabs"
alias golab="cd $HOME/workspace/go/src/gitlab.neoway.com.br"
