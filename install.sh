#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! "${1}" = "--yes" ]; then
  echo -e "USAGE: $(basename $0) (--yes)\n\n***dry run***\n"
  __debug() {
    echo -e "\$ $@"
  }
  DEBUG=__debug
fi

# bin
$DEBUG mkdir -p $HOME/bin
$DEBUG cp -r $DIR/bin/*.sh $HOME/bin
$DEBUG chmod +x $HOME/bin/*.sh
$DEBUG echo "PATH=\$PATH:\$HOME/bin" | $DEBUG tee -a $HOME/.bashrc

# bash settings
$DEBUG echo "export GOPATH=\$HOME/go" | $DEBUG tee -a $HOME/.bashrc
$DEBUG echo "export HISTCONTROL=erasedups:ignorespace" | $DEBUG tee -a $HOME/.bashrc
$DEBUG echo "export HISTSIZE=5000" | $DEBUG tee -a $HOME/.bashrc
$DEBUG echo "shopt -s histappend" | $DEBUG tee -a $HOME/.bashrc

# etc
$DEBUG sudo cp -r $DIR/etc/* /etc/

# dotfiles
$DEBUG mkdir -p $HOME/.ssh
$DEBUG chmod 700 $HOME/.ssh

read -p 'Link dotfiles? (y/N) '

if [[ $REPLY =~ ^[Yy] ]]; then
  for FILE in $(find $DIR/dotfiles -type f); do
    FILE_PATH=${FILE#"${DIR}/dotfiles"/}
    $DEBUG rm -f ${HOME}/${FILE_PATH}
    $DEBUG ln -s $FILE ${HOME}/${FILE_PATH}
  done
else
  $DEBUG cp $(find $DIR/dotfiles -type f | xargs) $HOME
fi

# homebrew
if [ -z "$(which brew)" ]; then
  $DEBUG sudo xcode-select --install
  $DEBUG sudo xcodebuild -license
  $DEBUG ruby -e "$($DEBUG curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

$DEBUG brew update

TAPS=(
  homebrew/cask
  homebrew/cask-drivers
  homebrew/cask-versions
)

CASKS=(
  atom
  burp-suite
  cleanmymac
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
  postico
  slack
  sublime-text
  tunnelblick
  xquartz
)

PACKAGES=(
  autoconf
  automake
  awscli
  bash-completion
  certbot
  cfssl
  cmake
  curl
  dep
  dialog
  docker-completion
  docker-compose
  docker-compose-completion
  git
  git-flow
  git-secret
  gnupg
  go
  graphviz
  hh
  htop
  jq
  jsonnet
  kops
  ksonnet/tap/ks
  kubernetes-cli
  kubernetes-helm
  make
  makedepend
  netcat
  nvm
  openssl
  pkg-config
  python
  python@2
  qemu
  readline
  ruby
  sqlite
  terraform
  unrar
  vault
  vim
  wagoodman/dive/dive
  watch
  wget
  xz
  yq
)

for TAP in "${TAPS[@]}"; do
  $DEBUG brew tap --full ${TAP}
done

for CASK in "${CASKS[@]}"; do
  $DEBUG brew cask install ${CASK}
done

$DEBUG brew install "${PACKAGES[@]}"

# post-install
$DEBUG hstr --show-configuration | $DEBUG tee -a $HOME/.bashrc
$DEBUG echo "bind '\"\C-r\": \"\C-ahstr -- \C-j\"'" | $DEBUG tee -a $HOME/.bashrc
