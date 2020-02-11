#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)"

main() {
  cd "$DOTFILES_DIR"

  git submodule update --init --remote

  install_symlink ".config/fish/config.fish"
  install_symlink ".config/fish/functions/fish_user_key_bindings.fish"
  install_symlink ".config/fish/functions/fzf_key_bindings.fish"
  install_symlink ".config/git/config"
  install_symlink ".config/git/ignore"
  install_symlink ".local/share/zsh/site-functions"
  install_symlink ".npmrc"
  install_symlink ".tmux.conf"
  install_symlink ".vim"
  install_symlink ".zshenv"
  install_symlink ".zshrc"

  # Setup GnuPG
  if [[ ! -d ~/.gnupg ]]; then
    mkdir ~/.gnupg
  fi
  chmod 700 ~/.gnupg

  chmod 700 "$DOTFILES_DIR/home/.gnupg"
  chmod 600 "$DOTFILES_DIR/home/.gnupg/gpg.conf"
  chmod 600 "$DOTFILES_DIR/home/.gnupg/gpg-agent.conf"

  install_symlink ".gnupg/gpg.conf"
  install_symlink ".gnupg/gpg-agent.conf"
}

install_symlink() {
  local dir="$(dirname "$HOME/$1")"
  [[ ! -d "$dir" ]] && mkdir -p "$dir"

  ln -snf "$DOTFILES_DIR/home/$1" "$HOME/$1"
}

main
