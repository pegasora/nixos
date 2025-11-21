{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    ## ## ## ## ##
    ##  system  ##
    ## ## ## ## ##
    # utils
    kanata
    appimage-run
    unzip
    stow
    nix-search-tv
    nix-output-monitor
    nurl
    nh
    zotero
    slack
    rustscan
    typst

    # plcs
    bridge-utils

    # noctalia
    roboto
    inter
    gpu-screen-recorder
    ddcutil
    cava
    wlsunset
    evolution-data-server
    inputs.noctalia.packages.${system}.default
    winboat
    docker-compose

    # software/coding/packaging
    nmap
    aravis
    cmake
    go
    gcc
    nodejs
    system-config-printer
    python3

    # system
    curl
    wget
    blueman
    brightnessctl
    networkmanager
    networkmanagerapplet
    libnotify
    home-manager
    kdePackages.dolphin
    exfat
    #displaylink

    # portals
    xwayland-satellite
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr

    # theming
    gtk3
    gtk4
    qt6.qtwayland

    # audio
    pipewire
    pavucontrol

    # secrets
    libsecret
    age
    sops
    tailscale

    ## ## ## ## ## ## ##
    ##  applications  ##
    ## ## ## ## ## ## ##
    # browser
    brave
    firefox

    # messaging/messaging/music
    spotify
    discord
    bolt-launcher

    # tools
    obsidian
    openscad
    todoist-electron
    ticktick
    woeusb
    gparted
    onlyoffice-desktopeditors
    freecad
    pcmanfm

    # other
    btop
    ydotool
    swaybg
    polkit_gnome

    ## ## ## ## ## ## ## ##
    # wayland / hyprland ##
    ## ## ## ## ## ## ## ##
    cliphist
    hyprland
    hyprlock
    grim
    slurp
    waybar # configure in hm
    swaynotificationcenter
    wlogout

    ## ## ## ##
    ##  git  ##
    ## ## ## ##
    git
    gh
    lazygit

    ## ## ## ## ##
    ##   shell  ##
    ## ## ## ## ##
    fuzzel
    fzf
    nushell
    eza
    bat
    fastfetch
    zoxide
    zellij
    uv
    opencode
    nixfmt-rfc-style
    nixd
    yazi
    just
    devenv

    ## ## ## ## ##
    ##  neovim  ##
    ## ## ## ## ##
    inputs.nvf-flake.packages.${pkgs.system}.default
    ripgrep
    gnumake
    ruff
    lua-language-server
  ];

  # recommended per uv
  environment.localBinInPath = true;
}
