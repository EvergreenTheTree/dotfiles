#!/bin/env bash
script_dir="$(dirname "$(readlink -f "$0")")"
echo "Please enter your github email address:"
read email
echo "Please enter your github username:"
read name
cp "$script_dir/gitconfig" ~/.gitconfig
git config --global user.name "$name"
git config --global user.email "$email"
unset email name
echo "Installed git config with you personal information."
