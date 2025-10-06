{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # system
    curl
    wget
    blueman # services.blueman.enable = true; in home-manager
    brightnessctl
    cmake
    go
    gcc
    kanata
    networkmanager
    networkmanagerapplet
    nodejs
    libnotify
    unzip
    stow
    python3
    home-manager
    xwayland-satellite
    kdePackages.dolphin
    exfat
    displaylink
    tailscale
    system-config-printer
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    qt6.qtwayland
    libsecret
    appimage-run
    nmap
    aravis
    gtk3
    gtk4
    pipewire

    # applications
    obsidian
    btop
    pcmanfm
    firefox
    onlyoffice-bin
    swaybg
    ydotool
    polkit_gnome
    gparted
    woeusb
    pavucontrol
    spotify
    discord
    brave
    #vivaldi

    # wayland / hyprland
    cliphist
    hyprland
    hyprlock
    hyprpaper
    hyprshot
    waybar # configure in hm
    swaynotificationcenter
    wlogout

    # git
    git
    gh
    lazygit

    # shell
    fuzzel
    fzf
    eza
    bat
    fastfetch
    zoxide
    zellij
    uv
    opencode
    starship
    nixfmt-rfc-style
    nixd
    yazi

    # neovim
    inputs.nvf-flake.packages.${pkgs.system}.default
    neovim
    ripgrep
    gnumake
    ruff
    lua-language-server
    (pkgs.catppuccin-sddm.override {flavor = "mocha";})
  ];

  environment.localBinInPath = true;
}
