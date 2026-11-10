#!/usr/bin/env bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Basics and command line tools
mkdir -p "$HOME/.config"
mkdir "$HOME/.config/git"
for f in "$DIR/git"/*; do
    ln -s "$f" "$HOME/.config/git/${f##*/}"
done
ln -s "$DIR/shell/fish" "$HOME/.config/fish"
mkdir "$HOME/.config/tmux"
ln -s "$DIR/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
ln -s "$DIR/nvim" "$HOME/.config/nvim"
ln -s "$DIR/bin" "$HOME/bin"

# TODO: Niri installation
# TODO: Other stuff installation
