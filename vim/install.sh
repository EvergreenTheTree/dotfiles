#!/usr/bin/env bash
usage="Usage: install.sh [-h] [-vn]"
read -r -d '' help <<EOF
$usage

  -h, --help  show this help message
  -v          install vim config files
  -n          install nvim config files
EOF

if (($# < 1)); then
	echo >&2 "Invalid number of arguments.  At least 1 argument required."
	echo >&2 "$usage"
	exit 1
elif [[ $# -eq 1 ]] && [[ "$1" = "-h" || "$1" = "--help" ]]; then
	echo "$help"
	exit 0
fi

# Determine what the install type is.
install_type="" # v=vim, n=nvim, nv/vn=vim and nvim
while getopts ":vn" opt; do
	case "$opt" in
		v)
			install_type+="v"
			;;
		n)
			install_type+="n"
			;;
	esac
done

check_exists() {
	# Check if file exists.
	if [[ -e $1 ]]; then
		echo >&2 "Error: $1 already exists.  Please remove it and try again."
		exit 1
	fi
}

install_config() {
	# Install vim config files to given path.
	check_exists "$1"
	echo
	script_dir="$(dirname "$(readlink -f "$0")")"
	ln -s "$script_dir" "$1"
	echo "Installed config files at $1."
}

if [[ $install_type = *"v"* ]]; then # install_type contains 'v'
	echo "Installing vim config files."
	echo
	check_exists ~/.vimrc
	install_config ~/.vim
fi

if [[ $install_type = *"n"* ]]; then # install_type contains 'n'
	echo "Installing nvim config files."
	echo
	install_config ~/.config/nvim
fi

echo
echo "Done."
