[private]
default:
  @just --list

# create links, idempotent, removes stale links
stow:
  mkdir -p $HOME/.config
  mkdir -p $HOME/.local/bin
  stow --verbose --target=$HOME --restow home
  stow --verbose --target=$HOME/.config --restow xdg_config
  stow --verbose --target=$HOME/.local/bin --restow scripts

# remove links
unstow:
  stow --verbose --target=$HOME --delete home
  stow --verbose --target=$HOME/.config --delete xdg_config
  stow --verbose --target=$HOME/.local/bin --delete scripts

# only user configs and packages (for use with existing DEs)
deploy-lite:
  just stow
  cat pkglist-user.txt | xargs sudo zypper install --no-confirm

# custom system deployment
deploy-full:
  just stow
  just init-keyboard
  cat pkglist-user.txt pkglist-system.txt | xargs sudo zypper install --no-confirm

[private]
init-keyboard:
  sudo rm -f /etc/X11/xorg.conf.d/00-keyboard.conf
  sudo localectl set-x11-keymap us,ru,ua pc105 qwerty grp:win_space_toggle,caps:ctrl_modifier
  sudo sed -i '$i\Option "AutoRepeat" "200 28"' /etc/X11/xorg.conf.d/00-keyboard.conf

# vim: set ft=just ts=2 sts=2 sw=2 et
