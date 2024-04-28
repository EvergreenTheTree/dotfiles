if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting ""
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/bin"
set -gx EDITOR "nvim"
fish_vi_key_bindings
bind -M insert \cr history-pager
bind -M insert \ce end-of-line
bind -M insert \ca beginning-of-line
bind -M insert \cu kill-line
# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block
# Set the insert mode cursor to a line
set fish_cursor_insert line
# Set the replace mode cursor to an underscore
set fish_cursor_replace_one underscore

fzf --fish | source

alias ncdu="ncdu --color off"
alias v="nvim"

function fish_mode_prompt
end
