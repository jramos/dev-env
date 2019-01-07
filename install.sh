#!/bin/bash -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! "${1}" = "--yes" ]; then
  echo -e "USAGE: $(basename $0) (--yes)\n\n***dry run***\n"
  __debug() {
    echo -e "\$ $@"
  }
  DEBUG=__debug
fi

read -p 'Setup home directory? (y/N) '
if [[ $REPLY =~ ^[Yy] ]]; then
  $DEBUG mkdir -p $HOME/bin
  $DEBUG cp -r $DIR/bin/*.sh $HOME/bin
  $DEBUG chmod +x $HOME/bin/*.sh
  $DEBUG echo "PATH=\$PATH:\$HOME/bin" | $DEBUG tee -a $HOME/.bashrc

  # bash settings
  $DEBUG echo "export GOPATH=\$HOME/go" | $DEBUG tee -a $HOME/.bashrc
  $DEBUG echo "export HISTCONTROL=erasedups:ignorespace" | $DEBUG tee -a $HOME/.bashrc
  $DEBUG echo "export HISTSIZE=5000" | $DEBUG tee -a $HOME/.bashrc
  $DEBUG echo "shopt -s histappend" | $DEBUG tee -a $HOME/.bashrc

  $DEBUG echo "source $HOME/.bashrc"  | $DEBUG tee -a $HOME/.bash_profile
  $DEBUG echo "source $HOME/.bash_aliases"  | $DEBUG tee -a $HOME/.bash_profile
  $DEBUG echo "[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion" | $DEBUG tee -a $HOME/.bash_profile

  # ssh
  $DEBUG mkdir -p $HOME/.ssh
  $DEBUG chmod 700 $HOME/.ssh
fi

read -p 'Add /etc files? (y/N) '
if [[ $REPLY =~ ^[Yy] ]]; then
  $DEBUG sudo cp -r $DIR/etc/* /etc/
fi

read -p 'Install dotfile symlinks? (y/N) '
if [[ $REPLY =~ ^[Yy] ]]; then
  for FILE in $(find $DIR/dotfiles -type f); do
    FILE_PATH=${FILE#"${DIR}/dotfiles"/}
    $DEBUG rm -f ${HOME}/${FILE_PATH}
    $DEBUG ln -s $FILE ${HOME}/${FILE_PATH}
  done
fi

read -p 'Install homebrew? (y/N) '
if [[ $REPLY =~ ^[Yy] ]]; then
  # homebrew
  if [ -z "$(which brew)" ]; then
    $DEBUG sudo xcode-select --install
    $DEBUG sudo xcodebuild -license
    $DEBUG ruby -e "$($DEBUG curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  $DEBUG brew update

  TAPS=(
    caskformula/caskformula
    homebrew/cask
    homebrew/cask-drivers
    homebrew/cask-versions
  )

  for TAP in "${TAPS[@]}"; do
    $DEBUG brew tap --full ${TAP}
  done

  CASKS=(
    atom
    bettertouchtool
    burp-suite
    copyclip
    docker-edge
    gimp
    google-chrome
    google-cloud-sdk
    gpg-suite
    intel-power-gadget
    istat-menus
    iterm2
    keybase
    kubernetic
    metasploit
    postico
    slack
    sublime-text
    tor-browser
    tunnelblick
    xquartz
  )

  for CASK in "${CASKS[@]}"; do
    $DEBUG brew cask install ${CASK}
  done

  PACKAGES=(
    ark
    autoconf
    automake
    awscli
    bash-completion
    certbot
    cfssl
    circleci
    cmake
    curl
    dep
    dialog
    dive
    docker-completion
    docker-compose
    git
    git-flow
    git-secret
    gnupg
    go
    graphviz
    hh
    htop
    ipfs
    jq
    jsonnet
    kompose
    kops
    ksonnet/tap/ks
    kubernetes-cli
    kubernetes-helm
    make
    makedepend
    netcat
    nvm
    openssl
    openvpn
    pkg-config
    python
    python@2
    qemu
    readline
    ruby
    sshfs
    sqlite
    terraform
    unrar
    vault
    vim
    wagoodman/dive/dive
    watch
    webp
    wget
    xz
    yq
  )

  $DEBUG brew install "${PACKAGES[@]}"
fi

read -p 'Install atom packages? (y/N) '
if [[ $REPLY =~ ^[Yy] ]]; then
  ATOM_PACKAGES=(
    atom-beautify
    atom-clock
    atom-ide-ui
    atom-jinja2
    atom-typescript
    atom-wrap-in-tag
    auto-update-plus
    autocomplete
    autocomplete-json
    autocomplete-modules
    browse
    build
    busy-signal
    ctrl-dir-scroll
    docblockr
    editorconfig
    file-icons
    git-blame
    git-time-machine
    hey-pane
    highlight-selected
    ide-flowtype
    ide-json
    intentions
    json-converter
    json-schema
    language-docker
    language-ejs
    language-jsonnet
    language-markdown
    language-terraform
    linter
    linter-docker
    linter-eslint
    linter-golinter
    linter-js-yaml
    linter-terraform-syntax
    linter-ui-default
    multi-cursor
    plist-converter
    pretty-json
    satisfy-dependencies
    set-syntax
    sort-lines
    split-diff
    sublime
    sublime-block-comment
    Sublime-Style-Column-Selection
    sublime-word-navigation
    sublimify
    tag
    terraform-fmt
    text-manipulation
    todo-show
  )

  $DEBUG apm install "${ATOM_PACKAGES[@]}"
fi

read -p 'Run post-install? (y/N) '
if [[ $REPLY =~ ^[Yy] ]]; then
  # post-install
  $DEBUG gcloud components install beta cloud_sql_proxy cloud-build-local docker-credential-gcr kubectl
  $DEBUG hstr --show-configuration | $DEBUG tee -a $HOME/.bashrc
  $DEBUG echo "bind '\"\C-r\": \"\C-ahstr -- \C-j\"'" | $DEBUG tee -a $HOME/.bashrc
fi
