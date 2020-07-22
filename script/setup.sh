#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
NO_DEPS=

main() {
  cd "$DOTFILES_DIR"

  git submodule update --init --remote

  install_symlink ".clang-format"
  install_symlink ".config/fish/config.fish"
  install_symlink ".config/fish/functions/fish_user_key_bindings.fish"
  install_symlink ".config/fish/functions/fzf_key_bindings.fish"
  install_symlink ".config/git/config"
  install_symlink ".config/git/ignore"
  install_symlink ".config/iterm2"
  install_symlink ".config/starship.toml"
  install_symlink ".local/share/zsh/site-functions"
  install_symlink ".npmrc"
  install_symlink ".tmux.conf"
  install_symlink ".vim"
  install_symlink ".zshenv"
  install_symlink ".zshrc"

  [[ -z "$NO_DEPS" ]] && install_deps

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

install_deps() {
  echo "Install dependencies..."
  brew update && brew bundle --file "$SCRIPT_DIR/Brewfile" --no-lock
}

print_usage() {
  cat << EOF
  usage: $0 [options]

  options:
    -h, --help  Print help messages.
    --no-deps   Setup without installing dependencies.
EOF

  exit
}

for opt in "$@"; do
  case "$opt" in
    -h|--help) print_usage ;;
    --no-deps) NO_DEPS=1 ;;
    *) ;;
  esac
done

main
