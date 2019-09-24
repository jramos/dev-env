alias .~="cd ${HOME}"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias c="code"
alias c.="code ."
alias cw="code --wait"

alias .ba="source ${HOME}/.bash_aliases"
alias .bal="source ${HOME}/.bash_aliases.local"
alias .bp="source ${HOME}/.bash_profile"
alias .bpl="source ${HOME}/.bash_profile.local"
alias .brc="source ${HOME}/.bashrc"
alias v.ba="vi ${HOME}/.bash_aliases"
alias v.bal="vi ${HOME}/.bash_aliases.local"
alias v.bp="vi ${HOME}/.bash_profile"
alias v.bpl="vi ${HOME}/.bash_profile.local"
alias v.brc="vi ${HOME}/.bashrc"

alias bup="brew update && brew upgrade && brew cask upgrade"
alias bci="brew cask install"
alias bi="brew install"

alias ya="yarn add"
alias ycr="yarn create react-app"
alias yd="yarn dev"
alias yi="yarn install"
alias yl="yarn lint"
alias yr="yarn remove"
alias ys="yarn start"
alias yt="yarn test" 
alias yui="yarn upgrade-interactive"

alias disable-tm-local="sudo tmutil disablelocal"
alias dns-flush="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias generate-mac="openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/:$//' | tr a-f A-F"
alias hard-reboot="sudo reboot -f"
alias mac-switch="sudo ifconfig en0 down && sudo ifconfig en0 ether \$(generate-mac) && sudo ifconfig en0 up"
alias nmap-scan="nmap --spoof-mac \$(generate-mac) -v -Pn"
alias open-ports="lsof -P -i -n"
alias poweroff="sudo shutdown -hP now"

alias db="docker build"
alias dbnc="docker build --no-cache"
alias de="docker exec"
alias dk="docker kill"
alias dr="docker run"
alias drf="docker rm -f"

alias dc="docker-compose"
alias dcb="docker-compose build"
alias dcbnc="docker-compose build --no-cache"
alias dce="docker-compose exec"
alias dck="docker-compose kill"
alias dcr="docker-compose rm -f"
alias dcrbu="docker-compose kill && docker-compose rm -f && docker-compose build --no-cache && docker-compose up"
alias dcru="docker-compose run"
alias dcu="docker-compose up"
alias dcub="docker-compose up --build"

alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gbl="git branch -l"
alias gblr="git branch -lr"
alias gc="git commit"
alias gcl="git clean -d -f"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gcom"=git checkout master"
alias gd="git diff"
alias gdh="git diff HEAD"
alias gf="git fetch"
alias gfp="git fetch --prune"
alias gl="git log"
alias glp="git log -p"
alias gp="git pull"
alias gpu="git push"
alias gpuf="git push --force"
alias gpusuo="git push --set-upstream origin \$(git rev-parse --abbrev-ref HEAD)"
alias gmnff="git merge --no-ff"
alias gmmnff="current_branch=\$(git rev-parse --abbrev-ref HEAD) && git checkout master && git pull && git checkout \$current_branch && git merge --no-ff master"
alias gmdnff="current_branch=\$(git rev-parse --abbrev-ref HEAD) && git checkout development && git pull && git checkout \$current_branch && git merge --no-ff development"
alias gr="git reset"
alias grh="git reset HEAD"
alias grhh="git reset HEAD --hard"
alias grm="git rm"
alias grmr="git rm -r"
alias gs="git status"
alias gt="git tag"
alias gtd="git tag delete"
alias gtl="git tag -l"
alias gtp="git pull --tags"

alias k="kubectl"
alias ka="kubectl apply"
alias kc="kubectl config"
alias kcc="kubectl config current-context"
alias kcuc="kubectl config use-context"
alias kd="kubectl describe"
alias kdel="kubectl delete"
alias kdelf="kubectl delete --force --grace-period=0"
alias kexec="kubectl exec -it"
alias kg="kubectl get"
alias kga="kubectl get all"
alias kgaan="kubectl get all --all-namespaces"
alias kgapi="kubectl api-resources"
alias kgd="kubectl get deployments"
alias kgdan="kubectl get deployments --all-namespaces"
alias kge="kubectl get events"
alias kgean="kubectl get events --all-namespaces"
alias kgi="kubectl get ingress"
alias kgian="kubectl get ingress --all-namespaces"
alias kgn="kubectl get namespaces"
alias kgp="kubectl get pods"
alias kgpan="kubectl get pods --all-namespaces"
alias kgs="kubectl get services"
alias kgsan="kubectl get services --all-namespaces"
alias kgsec="kubectl get secrets"
alias kgsecan="kubectl get secrets --all-namespaces"
alias kl="kubectl logs"
alias klf="kubectl logs -f"
alias krun="kubectl run -it"

alias kshell="kubectl run -R --rm -it alpine --image=alpine --restart=Never -- sh"
alias kgcloud="kubectl run -R --rm -it cloud-sdk --image=google/cloud-sdk:alpine --restart=Never -- sh"
alias kdash="((sleep 2; open http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/) &) && kubectl proxy"

alias y="yes"
alias n="yes "N""

b64d () {
  echo -n "$1" | base64 -D ; echo
}

b64e () {
  echo -n "$1" | base64
}

docker-delete() {
  # Delete all containers
  [ -n "$(docker ps -a -q)" ] && docker rm --force --volumes $(docker ps -a -q)

  # Delete all images
  [ -n "$(docker images -q)" ] && docker rmi --force $(docker images -q)

  # Remove dangling volumes
  [ -n "$(docker volume ls -qf dangling=true)" ] && docker volume rm --force $(docker volume ls -qf dangling=true)
}
