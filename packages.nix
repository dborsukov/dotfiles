# vim: ts=2:sts=2:sw=2
with import <nixpkgs> {};
{
  packages = [
    # gui
    gedit
    keepassxc 
    megasync
    mpv
    nsxiv
    obsidian
    telegram-desktop
    ungoogled-chromium
    zathura
    # terminal
    autojump
    broot
    eza
    fish
    handlr
    inetutils
    kitty
    lazygit
    scrot
    trashy
    # neovim + deps
    neovim
    fd
    fzf
    ripgrep
    tree-sitter
    # lf + deps
    lf
    atool
    djvulibre
    ffmpegthumbnailer
    imagemagick
    jq
    lynx
    pandoc
    poppler
    sourceHighlight
    ueberzugpp
    # secrets
    gnupg
    libsecret
    # file management
    ffmpegthumbnailer
    gvfs
    mate.engrampa
    udiskie
    udisks
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
    xfce.tumbler
    # environment: core
    bspwm
    lxde.lxsession
    rofi
    sxhkd
    xclip
    xorg.xinit
    xorg.xorgserver
    xorg.xsetroot
    yad
    # environment: extra
    dunst
    networkmanagerapplet
    polybar
    unclutter
    # environment: eye candy
    comixcursors
    gnome.gnome-themes-extra 
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    nitrogen
    nwg-look
    papirus-icon-theme
    # fonts
    font-awesome
    noto-fonts
    noto-fonts-color-emoji
    ubuntu_font_family 
  ];
}
