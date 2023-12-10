fish_vi_key_bindings

if command -v nsxiv > /dev/null
    abbr -a iv 'nsxiv'
end

if command -v trash > /dev/null
    abbr -a rm 'trash'
end

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

function bintopath
    if test (count $argv) -gt 0;
        if ! test -f (pwd)/$argv[1];
            echo "No such file."
            return
        end
        if test (count $argv) -eq 1;
            ln -sf "$(pwd)/$argv[1]" "$HOME/.bin/"
            echo "Added."
            exa -l $HOME/.bin | grep -E "|$argv[1]" --color='always'
        end
        if test (count $argv) -eq 2;
            ln -sf "$(pwd)/$argv[1]" "$HOME/.bin/$argv[2]"
            echo "Added as '$argv[2]'."
            exa -l $HOME/.bin | grep -E "|$argv[2]" --color='always'
        end
    end
end

# Fish prompt
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

function fish_greeting 
end

# XDG
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

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

# FZF
set -x FZF_DEFAULT_COMMAND 'fd --type file --follow'
set -x FZF_CTRL_T_COMMAND 'fd --type file --follow'
set -x FZF_DEFAULT_OPTS '--height 20%'

# Common env
set -x EDITOR 'nvim'
set -x VISUAL 'nvim'

# Rust env
set -x RUST_BACKTRACE 1
set -x CARGO_TARGET_DIR $HOME/.cargo_target_dir

# Go env
set -x GOPATH $HOME/.go

# Nvm
set -x nvm_default_version latest

# Path
fish_add_path  $HOME/.bin
fish_add_path  $HOME/.cargo/bin
fish_add_path  $HOME/.go/bin
fish_add_path  $HOME/.local/bin
fish_add_path  $HOME/.pub-cache/bin
fish_add_path  $HOME/.config/rofi/scripts
