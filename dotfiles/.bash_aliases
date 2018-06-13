alias .bash_profile="source ~/.bash_profile"
alias .bashrc="source ~/.bashrc"

alias r="sudo reboot now"
alias hard-reboot="sudo reboot -f"
alias poweroff="sudo shutdown -hP now"

alias dc='docker-compose'
alias dcb='docker-compose build'
alias dcbnc='docker-compose build --no-cache'
alias dce='docker-compose exec'
alias dck='docker-compose kill'
alias dcr='docker-compose rm -f'
alias dcru='docker-compose run'
alias dcrbu='docker-compose kill && docker-compose rm -f && docker-compose build --no-cache && docker-compose up'
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

alias kc='kubectl config'
alias kcc='kubectl config current-context'
alias kd='kubectl config use-context docker-for-desktop'
alias ke='kubectl exec -it'
alias kg='kubectl get'
alias kga='kubectl get all'
alias kgaa='kubectl get all --all-namespaces'
alias kgp='kubectl get events'
alias kgn='kubectl get namespaces'
alias kgp='kubectl get pods'
alias kgpan='kubectl get pods --all-namespaces'
alias kl='kubectl logs'
alias klf='kubectl logs -f'
