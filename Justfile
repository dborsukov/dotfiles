# vim: ts=2:sts=2:sw=2

[private]
default:
  @just --list

# link dotfiles, idempotent, removes stale links
stow:
	@stow --verbose --target=$HOME --restow */

# remove all links
unstow:
	@stow --verbose --target=$HOME --delete */

[private]
gen-packages:
	sed '/^#/d;s/+//;s/^[[:space:]]*//;/^[[:space:]]*$/d' packages.md > /tmp/pkglist

# install packages from "packages.md"
install-packages: gen-packages
	paru -S --noconfirm - < /tmp/pkglist

# use "localectl" to create keyboard config
conf-keyboard:
	sudo rm /etc/X11/xorg.conf.d/00-keyboard.conf
	localectl set-x11-keymap us,ru,ua pc105 qwerty grp:win_space_toggle,caps:ctrl_modifier
	sudo sed -i '$i\Option "AutoRepeat" "200 28"' /etc/X11/xorg.conf.d/00-keyboard.conf

archiver		:= 'engrampa'
browser			:= 'chromium'
editor			:= 'nvim'
filemanager	:= 'thunar'
imageviewer	:= 'nsxiv'
mediaplayer	:= 'mpv'
pdfreader		:= 'org.pwmt.zathura'
terminal		:= 'kitty'

# use "handlr" to create MIME associations
conf-mime:
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
