if [ -z "$PS1" ]; then
   return
fi

PS1='\h:\W \u\$ '

[ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"
[ -r $HOME/.bash_profile ] && . $HOME/.bash_profile

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
