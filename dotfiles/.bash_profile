HOME=${HOME:-'/Users/justin'}

export GOPATH=$HOME/go
export PATH="$HOME/bin:$HOME/go/bin:/usr/local/bin:/usr/local/sbin:/usr/local/opt/ruby/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/Library/Python/3.7/bin:$PATH"

# enable and load bash completions (.bash_completion will be sourced if it exists)
[ -r "/usr/local/etc/bash_completion.d" ] && source /usr/local/etc/bash_completion

[ -r $HOME/.bash_aliases ] && . $HOME/.bash_aliases
[ -r $HOME/.bash_aliases.local ] && . $HOME/.bash_aliases.local
[ -r $HOME/.bash_completion ] && . $HOME/.bash_completion
[ -r $HOME/.bash_profile.local ] && . $HOME/.bash_profile.local
[ -r $HOME/.bash_prompt ] && . $HOME/.bash_prompt
[ -r $HOME/.profile ] && . $HOME/.profile

export HH_CONFIG=hicolor                   # get more colors
export HISTCONTROL=erasedups:ignorespace   # hide leading space and duplicates
export HISTFILESIZE=10000                  # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}            # increase history size (default is 500)
export FIGNORE=DS_Store;

export CFLAGS="-march=native -O3 -pipe"
export CXXFLAGS="${CFLAGS}"
export EDITOR="code --wait"

if [[ $- =~ .*i.* ]]; then
  bind '"\e[5C": forward-word'
  bind '"\e[1;5C": forward-word'
  bind '"\e[5D": backward-word'
  bind '"\e[1;5D": backward-word'

  # bind hh to Ctrl-r (for Vi mode check doc)
  bind '"\C-r": "\C-a hh -- \C-j"'
  # bind 'kill last command' to Ctrl-x k
  bind '"\C-xk": "\C-a hh -k \C-j"'
  bind '"\C-r": "\C-ahstr -- \C-j"'
fi

# append new history items to .bash_history
shopt -s histappend
# Make bash check its window size after a process completes
shopt -s checkwinsize

# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# chruby config
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

# fuck
eval "$(thefuck --alias)"
