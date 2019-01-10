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
    $DEBUG mv -f $HOME/$FILE_PATH $HOME/$FILE_PATH.bak-$(date +%Y-%m-%d)
    $DEBUG ln -s $FILE $HOME/$FILE_PATH
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

  BREW_TAP=(
    caskformula/caskformula
    homebrew/cask
    homebrew/cask-drivers
    homebrew/cask-versions
  )

  for TAP in "${BREW_TAP[@]}"; do
    $DEBUG brew tap --full ${TAP}
  done

  BREW_CASK=(
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
    minikube
    osxfuse
    postico
    slack
    sublime-text
    tor-browser
    tunnelblick
    xquartz
  )

  for CASK in "${BREW_CASK[@]}"; do
    $DEBUG brew cask install ${CASK}
  done

  BREW=(
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
    postgresql
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

  $DEBUG brew install "${BREW[@]}"
fi

read -p 'Install apm packages? (y/N) '
if [[ $REPLY =~ ^[Yy] ]]; then
  APM=(
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

  $DEBUG apm install "${APM[@]}"
fi

read -p 'Install npm packages? (y/N) '
if [[ $REPLY =~ ^[Yy] ]]; then
  NPM=(
    aws-profile-switcher
    yarn
  )

  $DEBUG npm install -g "${NPM[@]}"
fi

read -p 'Install pip packages? (y/N) '
if [[ $REPLY =~ ^[Yy] ]]; then
  PIP=(
    gTTS
    jinja2
    numpy
    pandas
    requests
    tensorflow
  )

  $DEBUG pip install "${PIP[@]}"
fi
