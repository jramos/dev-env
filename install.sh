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
  $DEBUG mkdir -p $HOME/bin $HOME/.ssh
  $DEBUG chmod 700 $HOME/.ssh

  read -p 'Install dotfile symlinks? (y/N) '
  if [[ $REPLY =~ ^[Yy] ]]; then
    for FILE in $(find $DIR/dotfiles -type f); do
      FILE_PATH=${FILE#"${DIR}/dotfiles"/}
      [ -f $HOME/$FILE_PATH ] && \
        $DEBUG mv -f $HOME/$FILE_PATH $HOME/$FILE_PATH.bak-$(date +%Y-%m-%d)
      $DEBUG ln -s $FILE $HOME/$FILE_PATH
    done
  fi
fi

read -p 'Add /etc files? (y/N) '
if [[ $REPLY =~ ^[Yy] ]]; then
  $DEBUG sudo cp -rf $DIR/etc/* /etc/
fi

read -p 'Install homebrew and packages? (y/N) '
if [[ $REPLY =~ ^[Yy] ]]; then
  # homebrew
  if [ -z "$(which brew)" ]; then
    $DEBUG sudo xcode-select --install
    $DEBUG sudo xcodebuild -license
    $DEBUG ruby -e "$($DEBUG curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  $DEBUG brew update
  $DEBUG brew bundle install
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
    kube-shell
    numpy
    pandas
    requests
    tensorflow
  )

  $DEBUG pip3 install "${PIP[@]}"
fi

read -p 'Install Visual Studio Code packages? (y/N) '
if [[ $REPLY =~ ^[Yy] ]]; then
  VS_EXTS=(
    bajdzis.vscode-database
    christian-kohler.npm-intellisense
    dbaeumer.vscode-eslint
    donjayamanne.githistory
    eamodio.gitlens
    EditorConfig.EditorConfig
    esbenp.prettier-vscode
    HookyQR.beautify
    mauve.terraform
    mgmcdermott.vscode-language-babel
    ms-kubernetes-tools.vscode-kubernetes-tools
    ms-vscode.atom-keybindings
    ms-vscode.sublime-keybindings
    msjsdiag.debugger-for-chrome
    passionkind.prettier-vscode-with-tabs
    PKief.material-icon-theme
    redhat.vscode-yaml
    VisualStudioExptTeam.vscodeintellicode
    wix.glean
    zhuangtongfa.Material-theme
  )

  VS_PATH="/Applications/Visual Studio Code.app/Contents"
  VS_CODE="\"${VS_PATH}/MacOS/Electron\" \"${VS_PATH}/Resources/app/out/cli.js\""
  for VS_EXT in "${VS_EXTS[@]}"; do
    $DEBUG eval /usr/bin/env ELECTRON_RUN_AS_NODE=1 "$VS_CODE" --install-extension "${VS_EXT[@]}"
  done
fi
