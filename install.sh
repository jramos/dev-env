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

# dotfiles
$DEBUG mkdir -p $HOME/.ssh
$DEBUG chmod 700 $HOME/.ssh
$DEBUG cp $(find $DIR/dotfiles -type f | xargs) $HOME

# homebrew dependencies
$DEBUG sudo xcode-select --install
$DEBUG sudo xcodebuild -license

# homebrew
$DEBUG ruby -e "$($DEBUG curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

TAPS=(
  homebrew/cask
  homebrew/cask-drivers
  homebrew/cask-versions
)

CASKS=(
  atom
  burp-suite
  docker-edge
  gimp
  google-chrome
  google-cloud-sdk
  gpg-suite
  iterm2
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
  docker-completion
  docker-compose
  docker-compose-completion
  git
  git-flow
  go
  htop
  jq
  jsonnet
  kops
  ksonnet/tap/ks
  kubernetes-cli
  kubernetes-helm
  make
  netcat
  nvm
  openssl
  python
  python@2
  vault
  vim
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
