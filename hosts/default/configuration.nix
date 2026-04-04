{
  config,
  pkgs,
  lib,
  inputs,
  nixpkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    inputs.spicetify-nix.nixosModules.default
    inputs.fw-fanctrl.nixosModules.default
    ../../modules/nixos/default.nix
    #../../modules/nixos/packages.nix
    #../../modules/nixos/services.nix
    #./plcs-extra-config.nix
  ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "pegasora"
    ];
  };

  nixpkgs.overlays = [
    inputs.niri.overlays.niri
    inputs.claude-desktop.overlays.default
    inputs.claude-code.overlays.default
    #(import ../../overlays/winboat-fixes.nix)
    # winboat overlay no longer needed — nixpkgs now hardcodes electron_40 and dropped nodejs_24/Go fixes
    #(import ../../overlays/winboat-e3c7fb8.nix)
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    polarity = "dark";
  };

  #nix.gc = {
  #  automatic = true;
  #  dates = "weekly";
  #  options = "--delete-older-than 10d";
  #};

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # LocalSend
  networking.firewall.allowedTCPPorts = [53317];
  networking.firewall.allowedUDPPorts = [53317];
  programs.nm-applet.enable = true;
  programs.xwayland.enable = true;
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle # shuffle+ (special characters are sanitized out of extension names)
    ];
    enabledCustomApps = with spicePkgs.apps; [
      newReleases
      ncsVisualizer
    ];
    enabledSnippets = with spicePkgs.snippets; [
      rotatingCoverart
      pointer
    ];

    # theme/colorScheme managed by stylix — see modules/nixos/stylix.nix
    # theme = spicePkgs.themes.catppuccin;
    # colorScheme = "mocha";
  };

  # Ensure Wayland support for Electron
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Force Electron to use Wayland
    ELECTRON_OZONE_PLATFORM_HINT = "auto"; # Let Electron pick Wayland/X11
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_DESKTOP = "niri"; # Optional, for extra compatibility
    QT_QPA_PLATFORMTHEME = "qt5ct"; # Let stylix/Kvantum theme Qt apps (Dolphin, etc.)
  };

  # bluetooth
  hardware.bluetooth.enable = true;
  hardware.graphics.enable = true;

  hardware.graphics.extraPackages = with pkgs; [
    mesa
  ];

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  ## ## ## ## ##
  ## HYPRLAND ##
  ## ## ## ## ##
  programs.hyprland.enable = false;
  # programs.hyprland.package = inputs.hyprland.packages.${pkgs.system}.default;
  security.rtkit.enable = true;

  # Enable XDG portals for Wayland (required for Snaps to access display/file dialogs)
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        #xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ]; # For GNOME; use xdg-desktop-portal-kde for KDE
      wlr.enable = true; # General Wayland support (safe even on GNOME)
      #config.common.default = [
      #  "gtk"
      #];
    };
    mime.enable = true; # Enable MIME and URL handler registration
  };

  # programs
  programs.fish.enable = true;
  #programs.nushell.enable = true;
  programs.niri.enable = true;
  programs.niri.package = pkgs.niri-unstable;
  programs.lazygit.enable = true;
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # fw-fanctrl
  programs.fw-fanctrl = {
    enable = true;
    config = {
      defaultStrategy = "deaf";
    };
  };
  # nixpkgs hardware.fw-fanctrl kept for reference — reverted due to fan control issues
  # hardware.fw-fanctrl = {
  #   enable = true;
  #   config = {
  #     defaultStrategy = "deaf";
  #   };
  # };

  # group
  users.groups.pegasora = {};

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pegasora = {
    isNormalUser = true;
    description = "pegasora";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "flatpak"
      "input"
      "video"
      "plugdev"
      "dialout"
      "docker"
    ];
    packages = with pkgs; [];
    shell = pkgs.fish;
    #shell = pkgs.nushell;
    group = "pegasora";
  };

  virtualisation.docker.enable = true;

  fonts = {
    packages = with pkgs; [
      corefonts
      vista-fonts
      stix-two
      vollkorn

      #(stdenv.mkDerivation {
      #  pname = "monolisa-fonts";
      #  version = "2025-09-13";
      #  src = inputs.monolisa;
      #  dontBuild = true;
      #  installPhase = ''
      #    mkdir -p "$out/share/fonts/truetype/MonoLisa"
      #    for f in "$src"/*.ttf; do
      #      [ -e "$f" ] || continue
      #      cp -v "$f" "$out/share/fonts/truetype/MonoLisa/"
      #    done
      #  '';
      #})
      # managed by stylix.fonts — see modules/nixos/stylix.nix
      #(stdenv.mkDerivation {
      #  pname = "comiccode-font";
      #  version = "2025-09-13";
      #  src = inputs.comic-code;
      #  dontBuild = true;
      #  installPhase = ''
      #    mkdir -p "$out/share/fonts/truetype/Comic-Code"
      #    for f in "$src"/*.ttf; do
      #      [ -e "$f" ] || continue
      #      cp -v "$f" "$out/share/fonts/truetype/Comic-Code/"
      #    done
      #  '';
      #})
    ];

    fontDir.enable = true;
    fontconfig = {
      enable = true;
    };
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    users = {
      pegasora = import ./home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  security.polkit.enable = true;
  environment.systemPackages = with pkgs; [polkit_gnome];
  environment.variables.EDITOR = "nvim";
  services.dbus.packages = with pkgs; [polkit_gnome];

  services.displayManager.sddm = {
    wayland.enable = true;
    enable = true;
  };

  # NEVER CHANGE THIS
  system.stateVersion = "25.05"; # Did you read the comment?
  # NONONONONONONO DO NOT CHANGE THIS
}
