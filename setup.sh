#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)"

main() {
  cd "$DOTFILES_DIR"

  git submodule update --init --remote

  setup_gpg
  setup_shell
  setup_misc

  brew update && brew install \
    docker-completion \
    fd \
    fzf \
    reattach-to-user-namespace \
    zsh-completions \
    zsh-syntax-highlighting
}

setup_gpg() {
  if [[ ! -d ~/.gnupg ]]; then
    mkdir ~/.gnupg
  fi
  chmod 700 ~/.gnupg

  chmod 700 "$DOTFILES_DIR/home/.gnupg"
  chmod 600 "$DOTFILES_DIR/home/.gnupg/gpg.conf"
  chmod 600 "$DOTFILES_DIR/home/.gnupg/gpg-agent.conf"

  install_symlink ".gnupg/gpg.conf"
  install_symlink ".gnupg/gpg-agent.conf"
  install_symlink "Library/LaunchAgents/org.gnupg.gpg-agent.plist"
}

setup_shell() {
  install_symlink ".inputrc"
  install_symlink ".local/opt/fzf.zsh"
  install_symlink ".zshenv"
  install_symlink ".zshrc"
}

setup_misc() {
  install_symlink ".config/git/config"
  install_symlink ".config/git/ignore"
  install_symlink ".config/latexmk/latexmkrc"
  install_symlink ".tmux.conf"
  install_symlink ".vim"
  install_symlink "Library/Application Support/Code/User/locale.json"
  install_symlink "Library/Application Support/Code/User/settings.json"

  # vscode
  chmod 700 ~/Library/Application\ Support/Code
}

install_symlink() {
  local dir="$(dirname ~/"$1")"
  [[ ! -d "$dir" ]] && mkdir -p "$dir"
  pushd "$dir" > /dev/null
  ln -s "$(python -c "import os; print(os.path.relpath('$DOTFILES_DIR/home/$1'))")" .
  popd > /dev/null
}

main
