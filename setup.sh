#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)"

main() {
  cd "$DOTFILES_DIR"

  git submodule update --init --remote

  setup_gpg
  setup_shell
  setup_vim
  setup_misc

  install_deps
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
  install_symlink ".bash_profile"
  install_symlink ".bashrc"
  install_symlink ".inputrc"
  install_symlink ".local/opt"
  install_symlink ".local/share/zsh/site-functions"
  install_symlink ".zshenv"
  install_symlink ".zshrc"
}

setup_vim() {
  install_symlink ".vim"

  # Override system vim
  local mvim_dir=/usr/local/bin
  pushd "$mvim_dir" > /dev/null
  for cmd in vi vim vimdiff view vimex; do
    if [[ -x "$mvim_dir/mvim" ]]; then
      ln -s mvim $cmd
    else
      [[ -L "$cmd" ]] && rm "$cmd"
    fi
  done
  popd > /dev/null
}

setup_misc() {
  install_symlink ".config/git/config"
  install_symlink ".config/git/ignore"
  install_symlink ".config/latexmk/latexmkrc"
  install_symlink ".ideavimrc"
  install_symlink ".npmrc"
  install_symlink ".screenrc"
  install_symlink ".tern-config"
  install_symlink ".tmux.conf"
  install_symlink "Library/Application Support/Code/User/locale.json"
  install_symlink "Library/Application Support/Code/User/settings.json"

  # vscode
  chmod 700 ~/Library/Application\ Support/Code
}

install_deps() {
  brew update && brew install \
    docker-completion \
    fd \
    fzf \
    reattach-to-user-namespace \
    zsh-completions \
    zsh-syntax-highlighting

  vim +PlugUpdate +qall
}

install_symlink() {
  local dir="$(dirname ~/"$1")"
  [[ ! -d "$dir" ]] && mkdir -p "$dir"
  pushd "$dir" > /dev/null
  ln -s "$(python -c "import os; print(os.path.relpath('$DOTFILES_DIR/home/$1'))")" .
  popd > /dev/null
}

main
