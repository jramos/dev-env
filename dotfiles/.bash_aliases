alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias .bash_aliases="source ~/.bash_aliases"
alias .bash_profile="source ~/.bash_profile"
alias .bashrc="source ~/.bashrc"

alias hard-reboot="sudo reboot -f"
alias poweroff="sudo shutdown -hP now"

alias db='docker build'
alias dbnc='docker build --no-cache'
alias de='docker exec'
alias dk='docker kill'
alias dr='docker run'
alias drf='docker rm -f'

alias dc='docker-compose'
alias dcb='docker-compose build'
alias dcbnc='docker-compose build --no-cache'
alias dce='docker-compose exec'
alias dck='docker-compose kill'
alias dcr='docker-compose rm -f'
alias dcrbu='docker-compose kill && docker-compose rm -f && docker-compose build --no-cache && docker-compose up'
alias dcru='docker-compose run'
alias dcu='docker-compose up'
alias dcub='docker-compose up --build'

alias dns-flush='dscacheutil -flushcache && sudo killall -HUP mDNSResponder'

alias gita='git add'
alias gitaa='git add --all'
alias gitb='git branch'
alias gitc='git commit'
alias gitco="git checkout"
alias gitd="git diff"
alias gitdh="git diff HEAD"
alias gitf='git fetch'
alias gitl='git log'
alias gitp='git pull'
alias gitpu='git push'
alias gitmnff='git merge --no-ff'
alias gitr='git reset'
alias gitrh='git reset HEAD'
alias gitrhh='git reset HEAD --hard'
alias gitrm='git rm'
alias gitrmr="git rm -r"
alias gits='git status'

alias ka='kubectl apply'
alias kc='kubectl config'
alias kcc='kubectl config current-context'
alias kd='kubectl describe'
alias kdel='kubectl delete'
alias kexec='kubectl exec -it'
alias kg='kubectl get'
alias kga='kubectl get all'
alias kgaan='kubectl get all --all-namespaces'
alias kgd='kubectl get deployments'
alias kgdan='kubectl get deployments --all-namespaces'
alias kge='kubectl get events'
alias kgean='kubectl get events --all-namespaces'
alias kgi='kubectl get ingress'
alias kgian='kubectl get ingress --all-namespaces'
alias kgn='kubectl get namespaces'
alias kgp='kubectl get pods'
alias kgpan='kubectl get pods --all-namespaces'
alias kgs='kubectl get services'
alias kgsan='kubectl get services --all-namespaces'
alias kgsec='kubectl get secrets'
alias kgsecan='kubectl get secrets --all-namespaces'
alias kl='kubectl logs'
alias klf='kubectl logs -f'
alias krun='kubectl run -it'

alias run-k8s-gcloud='kubectl run cloud-sdk --rm -it --image google/cloud-sdk:latest -- bash'
