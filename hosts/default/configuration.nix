{ config, pkgs, lib, inputs, ... }:

{
  imports = [ 
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default

    ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;
  services.blueman.enable = true;

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

   # Configure keymap in X11
   services.xserver.xkb = {
     layout = "us";
     variant = "";
   };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  ## ## ## ## ##
  ## HYPRLAND ##
  ## ## ## ## ##
  programs.hyprland.enable = true;
  programs.hyprland.package = inputs.hyprland.packages.${pkgs.system}.default;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];  

  # SDDM
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.theme = "catppuccin-mocha-mauve";

  # sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
  };

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

  environment.systemPackages = with pkgs; [
     # system
     curl 
     wget
     blueman # services.blueman.enable = true; in home-manager
     brightnessctl
     cmake
     go
     gcc
     #gruvbox-plus-icons
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

     # applications
     obsidian
     btop
     pcmanfm
     firefox
     onlyoffice-bin
     swaybg
     ydotool
     polkit_gnome

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
     alacritty
     fzf
     eza
     bat
     fastfetch
     zoxide
     tmux
     uv
     opencode
     starship

     # neovim
     neovim
     ripgrep
     gnumake
     ruff
      kitty
      (pkgs.catppuccin-sddm.override { flavor = "mocha"; })
   ];

  environment.localBinInPath = true;

  # List services that you want to enable:
  #services.bluetooth.enable = true;

  services.kanata = {
      enable = true;
      keyboards = {
          internalKeyboard = {
              devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];
              extraDefCfg = "process-unmapped-keys yes";
              config = ''
                  (defsrc
                      caps
                  )

                  (defalias
                      escctrl (tap-hold 100 125 esc lctrl)
                  )

                  (deflayer base
                      @escctrl
                  )
              '';
          };
      };
  };

  # NEVER CHANGE THIS
  system.stateVersion = "25.05"; # Did you read the comment?
  # NONONONONONONO DO NOT CHANGE THIS

}
