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

# base16 theme
source ~/.config/fish/theme.fish

# path
fish_add_path  $HOME/.bin
fish_add_path  $HOME/.cargo/bin
fish_add_path  $HOME/.go/bin
fish_add_path  $HOME/.local/bin
fish_add_path  $HOME/.pub-cache/bin
fish_add_path  $HOME/.config/rofi/scripts

# aliases & abbreviations
abbr -a lf '~/.config/lf/lf-img'
if command -v nsxiv > /dev/null; abbr -a iv 'nsxiv'; end
if command -v trash > /dev/null; abbr -a rm 'trash'; end
if command -v lazygit > /dev/null; abbr -a lg 'lazygit'; end
if command -v exa > /dev/null
    abbr -a ls 'exa --group-directories-first'
    abbr -a ll 'exa -l --group-directories-first'
    abbr -a lla 'exa -la --group-directories-first'
else
    abbr -a ls 'ls'
    abbr -a ll 'ls -l'
    abbr -a lla 'ls -la'
end
if test -f /usr/share/autojump/autojump.fish;
    source /usr/share/autojump/autojump.fish;
end

# environment
set -x EDITOR 'nvim'
set -x VISUAL 'nvim'
# xdg
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state
# xdg-ninja
set -x ANDROID_HOME $XDG_DATA_HOME/android
set -x GNUPGHOME $XDG_DATA_HOME/gnupg
set -x GRADLE_USER_HOME $XDG_DATA_HOME/gradle
set -x GTK2_RC_FILES $XDG_CONFIG_HOME/gtk-2.0/gtkrc
set -x LESSHISTFILE $XDG_CACHE_HOME/less/history
set -x NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -x NVM_DIR $XDG_DATA_HOME/nvm
set -x PYTHONSTARTUP $XDG_CONFIG_HOME/python/pythonrc
set -x WINEPREFIX $XDG_DATA_HOME/wine
set -x XAUTHORITY $XDG_RUNTIME_DIR/Xauthority
set -x _JAVA_OPTIONS -Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java
# rust
set -x RUST_BACKTRACE 1
set -x CARGO_TARGET_DIR $HOME/.cargo_target_dir
# go
set -x GOPATH $HOME/.go
# nvm
set -x nvm_default_version latest
# bun
set -x BUN_INSTALL "$HOME/.bun"
set -x PATH $BUN_INSTALL/bin $PATH
# pnpm
set -gx PNPM_HOME "/home/db/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# sxhkd
set -x SXHKD_SHELL /usr/bin/bash

# autostart x
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end
