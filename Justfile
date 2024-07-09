alias s := stow
alias u := unstow
alias p := preview-software

[private]
default:
  @just --list

# create links, idempotent, removes stale links
stow:
  mkdir -p $HOME/.config
  mkdir -p $HOME/.local/bin
  @stow --verbose --target=$HOME --restow home
  @stow --verbose --target=$HOME/.config --restow xdg_config
  @stow --verbose --target=$HOME/.local/bin --restow scripts

# remove links
unstow:
  @stow --verbose --target=$HOME --delete home
  @stow --verbose --target=$HOME/.config --delete xdg_config
  @stow --verbose --target=$HOME/.local/bin --delete scripts

# init new system
full-system-init:
  just stow
  just init-keyboard
  just init-mimeapps
  nitrogen --set-zoom-fill --save wallpaper.png

# generate keyboard configuration
init-keyboard:
  sudo rm -f /etc/X11/xorg.conf.d/00-keyboard.conf
  sudo localectl set-x11-keymap us,ru,ua pc105 qwerty grp:win_space_toggle,caps:ctrl_modifier
  sudo sed -i '$i\Option "AutoRepeat" "200 28"' /etc/X11/xorg.conf.d/00-keyboard.conf

archiver    := 'engrampa'
browser     := 'firefox'
editor      := 'nvim'
filemanager := 'thunar'
imageviewer := 'nsxiv'
mediaplayer := 'mpv'
pdfreader   := 'org.pwmt.zathura'
terminal    := 'Alacritty'

# use 'handlr' to create MIME associations
init-mimeapps:
	handlr set 'application/gzip'              {{archiver}}.desktop
	handlr set 'application/pdf'               {{pdfreader}}.desktop
	handlr set 'application/x-7z-compressed'   {{archiver}}.desktop
	handlr set 'application/x-apple-diskimage' {{archiver}}.desktop
	handlr set 'application/x-cpio'            {{archiver}}.desktop
	handlr set 'application/x-gtar'            {{archiver}}.desktop
	handlr set 'application/x-rar-compressed'  {{archiver}}.desktop
	handlr set 'application/x-tar'             {{archiver}}.desktop
	handlr set 'application/x-xz'              {{archiver}}.desktop
	handlr set 'application/zip'               {{archiver}}.desktop
	handlr set 'audio/*'                       {{mediaplayer}}.desktop
	handlr set 'image/*'                       {{imageviewer}}.desktop
	handlr set 'inode/directory'               {{filemanager}}.desktop
	handlr set 'text/*'                        {{editor}}.desktop
	handlr set 'video/*'                       {{mediaplayer}}.desktop
	handlr set 'x-scheme-handler/http'         {{browser}}.desktop
	handlr set 'x-scheme-handler/https'        {{browser}}.desktop
	handlr set 'x-scheme-handler/terminal'     {{terminal}}.desktop

# preview software
preview-software:
  @csvlens software.csv

# install software
install-software: install-aur-helper
  #!/usr/bin/env bash
  sudo pacman -Sy archlinux-keyring
  packages=($(tail -n +2 software.csv | cut -d ',' -f2))
  paru --noconfirm --needed -S "${packages[@]}"

# install aur helper
install-aur-helper:
  #!/usr/bin/env bash
  if ! command -v paru &> /dev/null; then
    sudo pacman -Sy --needed base-devel
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
    cd ..
    rm -rf paru
  fi

# show package diff
@software-differences:
  paru -Q | cut -d' ' -f1 | sort > /tmp/system-pkgs.list
  paru -Qe | cut -d' ' -f1 | sort > /tmp/system-pkgs-manual.list
  tail -n +2 software.csv | cut -d',' -f2 | sort > /tmp/declared-pkgs.list
  printf "\033[1;32m%s\033[0m\n" "Added?:"
  comm -13 /tmp/declared-pkgs.list /tmp/system-pkgs-manual.list
  printf "\033[1;31m%s\033[0m\n" "Removed?:"
  comm -23 /tmp/declared-pkgs.list /tmp/system-pkgs.list

# vim: set ft=just ts=2 sts=2 sw=2 et
