alias s := stow
alias u := unstow
alias p := preview

[private]
default:
  @just --list

# preview software
preview:
  @csvlens software.csv

# create links, idempotent, removes stale links
stow:
  mkdir -p $HOME/.config
  mkdir -p $HOME/.local/bin
  @stow --verbose --target=$HOME --restow home
  @stow --verbose --target=$HOME/.config --restow xdg_config
  @stow --verbose --target=$HOME/.local/bin --restow scripts

# remove all links
unstow:
  @stow --verbose --target=$HOME --delete home
  @stow --verbose --target=$HOME/.config --delete xdg_config
  @stow --verbose --target=$HOME/.local/bin --delete scripts

# install software
install-software:
  #!/usr/bin/env bash
  sudo pacman -Sy archlinux-keyring
  packages=($(tail -n +2 software.csv | cut -d ',' -f2))
  paru --noconfirm --needed -S "${packages[@]}"

# generate keyboard configuration
configure-keyboard:
  sudo rm -f /etc/X11/xorg.conf.d/00-keyboard.conf
  sudo localectl set-x11-keymap us,ru,ua pc105 qwerty grp:win_space_toggle,caps:ctrl_modifier
  sudo sed -i '$i\Option "AutoRepeat" "200 28"' /etc/X11/xorg.conf.d/00-keyboard.conf

archiver    := 'engrampa'
browser     := 'chromium'
editor      := 'nvim'
filemanager := 'thunar'
imageviewer := 'nsxiv'
mediaplayer := 'mpv'
pdfreader   := 'org.pwmt.zathura'
terminal    := 'Alacritty'

# use 'handlr' to create MIME associations
configure-mimeapps:
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

# vim: set ft=just ts=2 sts=2 sw=2 et
