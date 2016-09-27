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

#Docker magic
## Kill all running containers.
alias dockerkillall='docker kill $(docker ps -q)'
## Delete all stopped containers.
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'
## Delete all images.
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi -f $(docker images -q)'
## Delete all stopped containers and untagged images.
alias dockerclean='dockercleanc || true && dockercleani'
## Delete orphaned volumes
alias dockercleanv='printf "\n>>> Deleting orphaned volumes.\n\n" && docker volume rm $(docker volume ls -qf dangling=true)'

#XClip magic
alias tox='xclip -selection clipboard'
alias fromx='xclip -selection clipboard -o'

#git
alias git-clean='git remote prune origin'

#VPN
alias vpnstart='sudo systemctl start openvpn@client.service'
alias vpnstop='sudo systemctl stop openvpn@client.service'

#Update arch
alias archupdate='sudo pacman -Syu'

#Instant http server
alias httpserver="python -m http.server"

#Generate password
alias genpassword="openssl rand -base64 32"

#Poweroff
alias poff="sudo systemctl poweroff"
