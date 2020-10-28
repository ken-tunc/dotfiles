#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)"
BREWFILE="$DOTFILES_DIR/Brewfile"

main() {
  local no_deps=0

  for opt in "$@"; do
    case "$opt" in
      -h|--help)
        print_usage
        ;;
      --no-deps)
        no_deps=1
        shift 1
        ;;
      *) ;;
    esac
  done

  cd "$DOTFILES_DIR"
  git submodule update --init --remote

  [[ "$no_deps" = 1 ]] || install_deps

  setup_main
  setup_gpg
}

setup_main() {
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
}

install_deps() {
  echo "Install dependencies..."
  brew update && brew bundle --file "$BREWFILE" --no-lock
}

install_symlink() {
  local dir="$(dirname "$HOME/$1")"
  [[ ! -d "$dir" ]] && mkdir -p "$dir"

  ln -snf "$DOTFILES_DIR/home/$1" "$HOME/$1"
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

main "$@"
