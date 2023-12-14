## Installation

1. Install arch using `archinstall`, select `minimal` configuration.
2. Reboot and run everything else as user.
4. Use `pacman` to install `base-devel git vim vi`.
3. (optional) Edit sudoers(`sudo visudo`) file to allow passwordless elevation. Don't forget to change it back later.
5. Download and install `paru` AUR helper:

```
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

6. Clone this repo and `cd` into it.
7. Run `install.sh`.
8. Manual configuration:

    - Install latest `node` and `npm` using `nvm` (for neovim)
    - Add `Option "AutoRepeat" "200 40"` to `/etc/X11/xorg.conf.d/00-keyboard.conf`
