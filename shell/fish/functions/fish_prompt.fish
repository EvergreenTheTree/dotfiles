# name: Default Modified
# author: Evergreen (based on "Default" by Lily Ballard)

function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)
    set -q fish_color_status
    or set -g fish_color_status red

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l suffix '>'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    # Write pipestatus
    # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

    set -l duration $CMD_DURATION
    set -l duration_hr (math -s0 $duration / 3600000)
    set -l duration (math "$duration - ($duration_hr * 3600000)")
    set -l duration_min (math -s0 $duration / 60000)
    set -l duration (math "$duration - ($duration_min * 60000)")
    set -l duration_sec (math -s0 $duration / 1000)
    set -l duration (math "$duration - ($duration_sec * 1000)")
    set -l duration_msec $duration
    if test $CMD_DURATION -ge 3600000
        echo "time: $duration_hr hr $duration_min min $duration_sec sec $duration_msec ms"
    else if test $CMD_DURATION -ge 60000
        echo "time: $duration_min min $duration_sec sec $duration_msec ms"
    else if test $CMD_DURATION -ge 1000
        echo "time: $duration_sec sec $duration_msec ms"
    end
    echo -n -s (fish_default_mode_prompt) (prompt_login)' ' (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal " "$prompt_status $suffix " "
end
