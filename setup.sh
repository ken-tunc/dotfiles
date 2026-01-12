#!/bin/zsh

readonly DOTFILES_DIR="${0:A:h}"
readonly SOURCE_DIR="$DOTFILES_DIR/home"

main() {
  install_configs
  install_deps
}

install_deps() {
  echo "Install dependencies..."
  brew update && brew bundle --file "$DOTFILES_DIR/Brewfile" --upgrade
}

install_configs() {
  local rel dir
  for src in "$SOURCE_DIR"/**/*(DN.); do
    rel=${src#"$SOURCE_DIR"/}

    dir=$(dirname "$HOME/$rel")
    [[ -d "$dir" ]] || mkdir -p "$dir"

    ln -snf "$src" "$HOME/$rel"
  done
}

main
