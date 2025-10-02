{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    inputs.spicetify-nix.nixosModules.default

    ../../modules/nixos/packages.nix
    ../../modules/nixos/services.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nixpkgs.overlays = [inputs.niri.overlays.niri];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 10d";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;
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

    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };

  # Ensure Wayland support for Electron
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Force Electron to use Wayland
    ELECTRON_OZONE_PLATFORM_HINT = "auto"; # Let Electron pick Wayland/X11
  };

  # bluetooth
  hardware.bluetooth.enable = true;

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
  programs.hyprland.package = inputs.hyprland.packages.${pkgs.system}.default;
  security.rtkit.enable = true;

  # Enable XDG portals for Wayland (required for Snaps to access display/file dialogs)
  xdg = {
    portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk]; # For GNOME; use xdg-desktop-portal-kde for KDE
      wlr.enable = true; # General Wayland support (safe even on GNOME)
    };
    mime.enable = true; # Enable MIME and URL handler registration
  };

  # programs
  programs.fish.enable = true;
  programs.niri.enable = true;
  programs.lazygit.enable = true;
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

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
    ];
    packages = with pkgs; [];
    shell = pkgs.fish;
    #shell = pkgs.nushell;
    group = "pegasora";
  };

  fonts = {
    packages = with pkgs; [
      corefonts
      vistafonts

      (stdenv.mkDerivation {
        pname = "monolisa-fonts";
        version = "2025-09-13";
        src = inputs.monolisa;
        dontBuild = true;
        installPhase = ''
          mkdir -p "$out/share/fonts/truetype/MonoLisa"
          for f in "$src"/*.ttf; do
            [ -e "$f" ] || continue
            cp -v "$f" "$out/share/fonts/truetype/MonoLisa/"
          done
        '';
      })
      (stdenv.mkDerivation {
        pname = "comiccode-font";
        version = "2025-09-13";
        src = inputs.comic-code;
        dontBuild = true;
        installPhase = ''
          mkdir -p "$out/share/fonts/truetype/Comic-Code"
          for f in "$src"/*.ttf; do
            [ -e "$f" ] || continue
            cp -v "$f" "$out/share/fonts/truetype/Comic-Code/"
          done
        '';
      })
    ];

    fontDir.enable = true;
    fontconfig = {
      enable = true;
    };
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
      "split-monitor-workspaces" = inputs."split-monitor-workspaces";
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
