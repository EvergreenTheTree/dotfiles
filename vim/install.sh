#!/bin/sh
usage="Usage: install.sh [-h] [-nv]"
help=$(cat <<EOF
Install Evergreen's vim configuration.

$usage

  -h  show this help message
  -n  install nvim config files
  -v  install vim config files
EOF
)
optstring=":hnv"
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)

### FUNCTIONS ###
# Show an error message along with a short usage message and exit.
error() {
    printf 'ERROR: %s\n' "$1" >&2
    printf '%s\n' "$usage" >&2
    exit 1
}

fexists() {
    if [ -e "$1" ]; then
        error "$1 already exists, not overwriting"
    fi
}

# Install vim config files to given path.
install_config() {
    if [ -e "$1" ]; then
        printf '\n'
        ln -s "$SCRIPT_DIR" "$1"
        printf 'Installed config files at %s' "$1"
    fi
}

### OPTION HANDLING ###
if [ $# -lt 1 ]; then
    error "at least 1 argument required"
fi

install_neovim=false
install_vim=false
while getopts $optstring opt; do
    case $opt in
        v)
            install_vim=true
            ;;
        n)
            install_neovim=true
            ;;
        h)
            printf '%s\n' "$help"
            exit 0
            ;;
        \?)
            error "invalid option: \"-$OPTARG\""
            ;;
        :)
            error "option \"-$OPTARG\" requires an argument"
            ;;
    esac
done

### SCRIPT ###
if [ $install_vim = true ]; then
    printf 'Installing vim config files.\n'
    printf '\n'
    fexists ~/.vim
    fexists ~/.vimrc
    install_config ~/.vim
fi

if [ $install_neovim = true ]; then
    printf 'Installing neovim config files.\n'
    printf '\n'
    fexists ~/.config/nvim
    install_config ~/.config/nvim
fi

printf '\n'
printf 'Done.\n'

## vim:fdm=expr:fdl=0:fdc=3:
## vim:fde=getline(v\:lnum)=~'^##'?'>'.(matchend(getline(v\:lnum),'##*')-2)\:'='
