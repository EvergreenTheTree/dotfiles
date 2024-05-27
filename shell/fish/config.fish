if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/bin"

set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_STATE_HOME "$HOME/.local/state"
set -gx XDG_CACHE_HOME "$HOME/.cache"

set -gx ANDROID_USER_HOME "$XDG_DATA_HOME/android"
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
fish_add_path "$CARGO_HOME/bin"
set -gx GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -gx GOPATH "$XDG_DATA_HOME/go"
fish_add_path "$GOPATH/bin"
set -gx GRADLE_USER_HOME "$XDG_DATA_HOME/gradle"
set -gx IPYTHONDIR "$XDG_DATA_HOME/ipython"
set -gx JUPYTER_CONFIG_DIR "$XDG_CONFIG_HOME/jupyter"
set -gx LESSHISTFILE "$XDG_CACHE_HOME/less/history"
set -gx MYPY_CACHE_DIR "$XDG_CACHE_HOME/mypy"
set -gx _JAVA_OPTIONS -Djava.utils.prefs.userRoot="$XDG_CONFIG_HOME/java"
set -gx PYLINTHOME "$XDG_CACHE_HOME/pylint"
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -gx DOT_SAGE "$XDG_CONFIG_HOME/sage"
set -gx TEXMFVAR "$XDG_CACHE_HOME/texlive/texmf-var"
set -gx VAGRANT_HOME "$XDG_DATA_HOME/vagrant"

function progexists
    return (type -q $argv[1])
end

if progexists nvim
    set -gx EDITOR "nvim"
else if progexists vim
    set -gx EDITOR "vim"
end

fish_vi_key_bindings
bind -M insert \cr history-pager
bind -M insert \ce end-of-line
bind -M insert \ca beginning-of-line
bind -M insert \cu kill-line

set -U fish_greeting ""
function fish_mode_prompt
end
# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block
# Set the insert mode cursor to a line
set fish_cursor_insert line
# Set the replace mode cursor to an underscore
set fish_cursor_replace_one underscore

alias ncdu="ncdu --color off"
alias e="$EDITOR"
if progexists eza
    alias ls="eza"
    alias l="eza -lbF --git"
    alias ll="eza -lbGF --git"
    alias llm="eza -lbGd --git --sort=modified"
    alias la="eza -lbhHigmuSa --time-style=long-iso --git --color-scale size"
    alias lx="eza -lbhHigmuSa@ --time-style=long-iso --git --color-scale size"
    alias lS="eza -1"
    alias lt="eza --tree --level=2"
else
    alias l='ls -halt --color=always'
    alias ll='ls -halt --color=always'
    alias la='ls -halt --color=always'
end
alias cp="cp -i"
alias df="df -h"
# TODO: more clipboard "providers"
if progexists xsel
    alias cpaste="xsel -bo"
    alias ccopy="xsel-bi"
end
alias t="tmux new -A -s $USER"

if progexists fzf
    fzf --fish | source
end

function cdr -a relative_path
    if not git rev-parse --is-inside-work-tree &>/dev/null
        echo "error: not in a git repository" >&2
        return 1
    end

    cd "$(git rev-parse --show-toplevel)/$relative_path"
end
function __cdr_complete_directories -d "Complete directories for cdr"
    # HACK: We call into the file completions by using an empty command
    # If we used e.g. `ls`, we'd run the risk of completing its options or another kind of argument.
    # But since we default to file completions, if something doesn't have another completion...
    # (really this should have an actual complete option)
    set -l dirs (complete -C"'' $(git rev-parse --show-toplevel)/" | string match -r '.*/$' | path basename | string replace -r '$' '/')

    if set -q dirs[1]
        printf "%s\n" $dirs\tDirectory
    end
end
complete --no-files --exclusive --command cdr --arguments "(__cdr_complete_directories)"

function launch
    $argv &>/dev/null &
    disown $last_pid
end
complete -c launch -x -a "(__fish_complete_subcommand)"

function notify
    $argv
    notify-send -a fish -i clock "Command Finished" "$argv"
end
complete -c notify -x -a "(__fish_complete_subcommand)"

function c -w z
    if test (count $argv) -gt 0
        z $argv
    else
        cd (z -l 2>&1 | fzf --height=40% --scheme=path --reverse +s +m --tac --bind=ctrl-z:ignore | sed 's/^[0-9,.]* *//')
    end
end

if test -f "$XDG_DATA_HOME/fish/config.fish.local"
    source "$XDG_DATA_HOME/fish/config.fish.local"
end

# vim:et:sts=4:ts=4:sw=4
