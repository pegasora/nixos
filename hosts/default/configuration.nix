{ config, pkgs, lib, inputs, ... }:

{
  imports = [ 
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default

      ../../modules/nixos/packages.nix
      ../../modules/nixos/services.nix
    ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

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
  programs.hyprland.enable = true;
  programs.hyprland.package = inputs.hyprland.packages.${pkgs.system}.default;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];  
  security.rtkit.enable = true;

  # programs
  programs.fish.enable = true;
  programs.niri.enable = false; # disabled in favor of Hyprland
  programs.lazygit.enable = true;

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
    extraSpecialArgs = { inherit inputs; };
    users = {
      pegasora = import ./home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  # NEVER CHANGE THIS
  system.stateVersion = "25.05"; # Did you read the comment?
  # NONONONONONONO DO NOT CHANGE THIS

}
