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
    sniffnet
    zoom-us
    kdePackages.okular
    lazyjj
    timeshift

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
    poppler-utils
    platformio
    avrdude

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
    todoist-electron
    ticktick
    woeusb
    gparted
    onlyoffice-desktopeditors
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
    nixfmt
    nixd
    yazi
    just
    devenv
    superfile

    # NOTE: Deprecated packages
    #nixfmt-rfc-style
    #displaylink
    #freecad
    #openscad

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
