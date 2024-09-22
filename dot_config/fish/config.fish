fish_vi_key_bindings

function fish_greeting;end

function fish_prompt
    set_color blue
    echo -n (hostname)
    if [ $PWD != $HOME ]
        set_color grey
        echo -n ':'
        set_color yellow
        echo -n (basename $PWD)
    end
    set_color green
    printf '%s ' (__fish_git_prompt)
    set_color red
    echo -n '| '
    set_color normal
end

function fish_right_prompt
    set last_status "$status"
    if test "$last_status" -gt 0 -a "$last_status" -ne 127 # command not found
        set_color red
        echo "failed $last_status"
    end
    set_color normal
    if test "$CMD_DURATION" -gt 3000
        echo " took: "
        set_color yellow
        echo "$(math $CMD_DURATION / 1000)s"
    end
    set_color normal
end

abbr -a v 'nvim'
abbr -a lg 'lazygit'
abbr -a e 'exa --group-directories-first'

set -x EDITOR 'nvim'
set -x VISUAL 'nvim'

set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state

fish_add_path  $HOME/.local/bin
fish_add_path  $HOME/.cargo/bin

zoxide init fish | source
