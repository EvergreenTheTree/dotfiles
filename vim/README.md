dotvim
======

My vim files.  There be Ents here, so don't be hasty.

NOTE: I _do not_ recommend using these out of the box.  These are _my_ personal
settings, and some of the options I set may do some unexpected things for you.

# Neovim

These config files should work with neovim as well, you just need to link the
vim config directory to the nvim config directory.

    ln -s ~/.vim $XDG_CONFIG_HOME/nvim

# Installation

I have written an install script that will install for both vim and nvim.  You
can choose which program to install for with `-v` for vim and `-n` for nvim.
You can also pass both arguments if you want to install for both vim and nvim.
The script will fail if `~/.vim`, `~/.vimrc` or `~/.config/nvim` already exist.
For example:

    ./install.sh -v -n # installs config files for both vim and nvim

Also make sure to run `git submodule --init --recursive` to pull in plugins.
