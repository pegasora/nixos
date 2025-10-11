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
    inputs.vpn-confinement.nixosModules.default # Add VPN-Confinement module
  ];

  # Enable flakes and nix-command
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

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
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [22 445 139 8080]; # Add qBittorrent web UI
  networking.firewall.allowedUDPPorts = [137 138]; # Samba

  # VPN namespace
  vpnNamespaces.airvpn = {
    enable = true;
    wireguardConfigFile = "/home/zues/nixos/private/airvpn_wg.conf"; # Your manual config
    accessibleFrom = ["10.10.1.0/24" "127.0.0.1"]; # Your LAN subnet
    portMappings = [
      {
        from = 8080;
        to = 8080;
      }
    ];
  };

  # qBittorrent
  services.qbittorrent = {
    enable = true;
    user = "qbittorrent";
    group = "qbittorrent";
    openFirewall = true; # Opens port 8080
    systemd.services.qbittorrent-nox.vpnConfinement = {
      enable = true;
      vpnNamespace = "airvpn";
    };
    settings = {
      WebUI.Address = "0.0.0.0";
      WebUI.Port = 8080;
      WebUI.Username = "zues";
      WebUI.Password = "chageme"; # CHANGE THIS!
      Connection.ListenPort = 47935; # Your AirVPN forwarded port
      General.ShowSplashScreen = false;
      Speed.DefaultGlobalDownloadLimit = 0;
      Downloads.SavePath = "/tank/qbittorrent/downloads";
    };
  };

  users.groups.zues = {};
  users.groups.qbittorrent = {};
  # Users
  users.users.zues = {
    isNormalUser = true;
    extraGroups = ["wheel" "docker" "qbittorrent"]; # Add zues to qbittorrent group
    shell = pkgs.bash;
    hashedPassword = "$6$h5ZKxkpdKx8jZdvu$2DcPXF3grqFHm82CzaIsFyx0kZD697HIxFUjosHZGLIns8Z4MrFxR9qHW6rZ0AwOBezNfFFiWL6.Q4UuC3DZ91";
    group = "zues";
  };

  users.users.qbittorrent = {
    isSystemUser = true;
    group = "qbittorrent";
    home = "/tank/qbittorrent"; # Store config/data here
  };

  # Ensure zues can access qBittorrent downloads
  systemd.tmpfiles.rules = [
    "d /tank/qbittorrent 0770 qbittorrent qbittorrent - -" # qBittorrent owns dir
    "d /tank/qbittorrent/downloads 0770 qbittorrent qbittorrent - -" # Downloads subdir
  ];

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

  # Services
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };
  services.tailscale.enable = true;

  # Docker
  virtualisation.docker.enable = true;

  # Samba
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      # Fix shares -> settings
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
    wireguard-tools # For VPN debugging
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System state version
  system.stateVersion = "25.05";
}
