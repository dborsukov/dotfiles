# vim: set ft=just ts=2 sts=2 sw=2 et

[private]
default:
  @just --list

# create links, idempotent, removes stale links
stow:
  mkdir -p $HOME/.config
  mkdir -p $HOME/.local/bin
  stow --verbose --target=$HOME --restow home
  sudo stow --verbose --target=/etc --restow etc
  stow --verbose --target=$HOME/.config --restow xdg_config
  stow --verbose --target=$HOME/.local/bin --restow scripts

# remove links
unstow:
  stow --verbose --target=$HOME --delete home
  sudo stow --verbose --target=/etc --delete etc
  stow --verbose --target=$HOME/.config --delete xdg_config
  stow --verbose --target=$HOME/.local/bin --delete scripts

[private]
bootstrap:
  # packages
  sudo xbps-install -Sy void-repo-nonfree void-repo-multilib
  cat pkglist.txt | xargs sudo xbps-install -Sy
  # configs
  just stow
  # services
  sudo ln -s /etc/sv/dbus /var/service
  sudo ln -s /etc/sv/crond /var/service
  sudo ln -s /etc/sv/chronyd /var/service
  sudo ln -s /etc/sv/elogind /var/service
  sudo ln -s /etc/sv/polkitd /var/service
  sudo ln -s /etc/sv/bluetoothd /var/service
  # network
  sudo sv down dhcpcd
  sudo touch /var/service/dhcpcd/down
  sudo ln -s /etc/sv/NetworkManager /var/service
  # audio
  sudo mkdir -p /etc/pipewire/pipewire.conf.d
  sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
  sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/
