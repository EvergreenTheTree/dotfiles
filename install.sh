#!/bin/bash
# TODO: update this
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ln -s "$DIR/shell/dir_colors" "$HOME/.dir_colors"
ln -s "$DIR/shell/environment" "$HOME/.environment"
ln -s "$DIR/zsh/zshrc" "$HOME/.zshrc"
ln -s "$DIR/git/gitconfig" "$HOME/.gitconfig"
ln -s "$DIR/git/gitignore" "$HOME/.gitignore"
