HOME=${HOME:-'/Users/justin'}

[ -f $HOME/.bashrc ] && . $HOME/.bashrc
[ -f $HOME/.profile ] && . $HOME/.profile
[ -f $HOME/.bash_aliases ] && . $HOME/.bash_aliases
[ -f $HOME/.bash_aliases.local ] && . $HOME/.bash_aliases.local
[ -f $HOME/.iterm2_shell_integration.bash && . $HOME/.iterm2_shell_integration.bash
[ -f $HOME/.kube-completions ] && . $HOME/.kube-completions

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

export GOROOT=$HOME/go
export GOPATH=$HOME/go
export PATH=$HOME/bin:$HOME/go/bin:$PATH
export PATH=$PATH:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin

export HISTCONTROL=erasedups:ignorespace
export HISTSIZE=10000

shopt -s histappend

bind '"\e[5C": forward-word'
bind '"\e[1;5C": forward-word'
bind '"\e[5D": backward-word'
bind '"\e[1;5D": backward-word'
