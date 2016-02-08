#!/bin/env bash
script_dir="$(dirname "$(readlink -f "$0")")"
if [[ -e ~/.gitconfig ]]; then
    echo "Warning: ~/.gitconfig already exists, and will be overwritten,"
    read -p "Overwrite? [y/n] " yn
    case $yn in
        [Yy]*)
            ;;
        *)
            exit 1
            ;;
    esac
fi
echo "Please enter your github email address:"
read email
echo "Please enter your github username:"
read name
cp "$script_dir/gitconfig" ~/.gitconfig
git config --global user.name "$name"
git config --global user.email "$email"
unset email name
echo "Installed git config with your personal information."
