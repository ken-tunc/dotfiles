#!/bin/bash

readonly DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)"
readonly MACOS_DIR="$DOTFILES_DIR/macOS"

NO_DEPS=

main() {
  cd "$DOTFILES_DIR"
  git submodule update --init --remote

  [[ -z "$NO_DEPS" ]] && install_deps

  setup_main
  setup_gpg
  setup_terminal_app
}

setup_main() {
  install_symlink ".clang-format"
  install_symlink ".config/alacritty/alacritty.yml"
  install_symlink ".config/bat/config"
  install_symlink ".config/fish/config.fish"
  install_symlink ".config/fish/functions/fish_user_key_bindings.fish"
  install_symlink ".config/fish/functions/fzf_key_bindings.fish"
  install_symlink ".config/git/config"
  install_symlink ".config/git/ignore"
  install_symlink ".config/ideavim/ideavimrc"
  install_symlink ".config/iterm2"
  install_symlink ".config/kitty/kitty.conf"
  install_symlink ".config/starship.toml"
  install_symlink ".config/tmux/tmux.conf"
  install_symlink ".local/share/zsh/site-functions"
  install_symlink ".npmrc"
  install_symlink ".vim"
  install_symlink ".zshenv"
  install_symlink ".zshrc"
  install_symlink "Library/Application Support/tabby/config.yaml"
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

setup_terminal_app() {
  local term_profile="Pro_Customized"
  local plist_path="$HOME/Library/Preferences/com.apple.Terminal.plist"

  if [[ "$(defaults read com.apple.terminal 'Default Window Settings')" != "$term_profile" ]]; then
    grep -q "$term_profile" "$plist_path" || open "$MACOS_DIR/$term_profile.terminal"

    defaults write com.apple.Terminal "Default Window Settings" -string "$term_profile"
    defaults write com.apple.Terminal "Startup Window Settings" -string "$term_profile"
    defaults import com.apple.Terminal "$plist_path"
  fi
}

install_deps() {
  echo "Install dependencies..."
  brew update && brew bundle --file "$MACOS_DIR/Brewfile" --no-lock
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

for opt in "$@"; do
  case "$opt" in
    -h|--help)
      print_usage
      ;;
    --no-deps)
      NO_DEPS=1
      shift 1
      ;;
    *) ;;
  esac
done

main
