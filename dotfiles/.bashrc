if [ -z "$PS1" ]; then
   return
fi

PS1='\h:\W \u\$ '

[ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"
[ -r $HOME/.bash_profile ] && . $HOME/.bash_profile

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# heroku autocomplete setup
HEROKU_AC_BASH_SETUP_PATH=$HOME/Library/Caches/heroku/autocomplete/bash_setup && \
    test -f $HEROKU_AC_BASH_SETUP_PATH && \
    source $HEROKU_AC_BASH_SETUP_PATH
