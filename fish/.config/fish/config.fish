fish_vi_key_bindings

function fish_greeting;end

function fish_prompt
    set_color grey
    echo -n "["(date "+%H:%M")"] "
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

if test -f /usr/share/autojump/autojump.fish;
    source /usr/share/autojump/autojump.fish;
end

# path
fish_add_path  $HOME/.local/bin
fish_add_path  $HOME/.cargo/bin
fish_add_path  $HOME/.config/rofi/scripts

# aliases & abbreviations
abbr -a v 'nvim'
abbr -a lg 'lazygit'
abbr -a tp 'trash put'
abbr -a lf '~/.config/lf/lf-img'
abbr -a e 'eza --git --group-directories-first'

# environment
set -x EDITOR 'nvim'
set -x VISUAL 'nvim'
set -x SXHKD_SHELL /usr/bin/bash
set -x QT_QPA_PLATFORMTHEME qt5ct

set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state

# autostart x
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end
