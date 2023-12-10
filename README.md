## Installation

1. Install arch using `archinstall` with `minimal` config
2. Install `base-devel`, then install `paru`:

```
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

3. Run `install.sh`
4. Manual steps:

    - Install latest `node` and `npm` using `nvm` (for neovim)
    - Add `Option "AutoRepeat" "200 40"` to `/etc/X11/xorg.conf.d/00-keyboard.conf`
