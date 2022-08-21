vim
===

My vim files.  There be Ents here, so don't be hasty.

For a while I tried to keep these files vim/neovim agnostic. While they should
still work with vim (minus a few plugins), my current main editor is neovim
and I have not checked to see how well they work with vim in a while.

# Installation

    ln -s ~/.vim $XDG_CONFIG_HOME/nvim

# A brief guide

It's not immediately obvious what all the files in this directory are for, so
here is a brief rundown:

- `autocommands.vim` - Pretty self explanatory, might want to dissolve this file
  and disperse everything into the other files at some point
- `autoload/` - For now just contains the code for the `plug.vim` and pathogen
  plugin managers. I use `plug.vim` for most plugins and pathogen for anything
  I write myself or want to modify the source code of.
- `colors/` - Themes (including a modified version of onedarkhc by myself)
- `colorscheme.vim` - Additional theme configuration
- `ftplugin/` - All language specific settings and/or mini plugins go here
- `gvimrc` - gvim specific configuration
- `indent/` - Automatic indentation single file plugins
- `init.vim` - neovim specific configuration
- `mappings.vim` - Keybindings
- `options.vim` - Built-in vim options plus plugin configuration
- `plugin/` - Single file mini plugins, great for grabbing and using :-)
- `plugins/` - The directory where `plug.vim` clones plugin repositories
- `plugins-dev/` - Plugins I develop or modified external plugins (managed by pathogen)
- `plugins-local/` - Machine local plugins
- `plugins.vim` - Where plugins are loaded
- `statusline.vim` - My custom statusline configuration (eat your heart out airline)
- `syntax.vim` - Miscellaneous syntax highlighting files
- `UltiSnips` - UltiSnips snippets
- `vimrc` - Main configuration entry point for both vim and neovim
