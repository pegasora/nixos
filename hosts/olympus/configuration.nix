{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
    ../../disks/server.nix

    ../../modules/nixos/olympus
  ];

  # Enable flakes and nix-command
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  #home-manager = {
  #  extraSpecialArgs = {
  #    inherit inputs;
  #  };
  #  users = {
  #    zues = import ./home.nix;
  #  };
  #};

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ZFS configuration
  boot.supportedFilesystems = ["zfs"];
  boot.zfs.forceImportRoot = false;
  boot.zfs.extraPools = ["tank" "flash"];
  services.zfs.autoScrub.enable = true;
  services.zfs.autoSnapshot.enable = true;

  # Networking
  networking.hostName = "olympus";
  networking.hostId = "166459cc";
  networking.networkmanager.enable = false;
  networking.useDHCP = true;
  #networking.interfaces.eth0.useDHCP = true; # Adjust interface name as needed
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [22 445 139]; # SSH, Samba
  networking.firewall.allowedUDPPorts = [137 138]; # Samba

  # Time zone
  time.timeZone = "America/Los_Angeles";

  # Internationalization
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

  # group
  users.groups.zues = {};

  # User configuration
  users.users.zues = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker"];
    shell = pkgs.bash;
    hashedPassword = "$6$h5ZKxkpdKx8jZdvu$2DcPXF3grqFHm82CzaIsFyx0kZD697HIxFUjosHZGLIns8Z4MrFxR9qHW6rZ0AwOBezNfFFiWL6.Q4UuC3DZ91";
    group = "zues";
  };

  # Services
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  # Docker for containerized services
  virtualisation.docker.enable = true;

  # Samba for file sharing
  services.samba = {
    enable = true;
    openFirewall = true;
    shares = {
      tank = {
        path = "/tank";
        writable = "yes";
        browsable = "yes";
        "guest ok" = "no";
        "valid users" = "admin";
      };
      flash = {
        path = "/flash";
        writable = "yes";
        browsable = "yes";
        "guest ok" = "no";
        "valid users" = "admin";
      };
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System state version
  system.stateVersion = "25.05";
}
