{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # hyprland
    hyprland.url = "github:hyprwm/Hyprland";

    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };
    # hyprland-plugins repo
    #hyprland-plugins = {
    #  url = "github:hyprwm/hyprland-plugins";
    #  inputs.nixpkgs.follows = "hyprland";
    #};
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # fonts
    monolisa = {
      url = "github:pegasora/Monolisa";
      flake = false;
    };
    comic-code = {
      url = "github:pegasora/Comic-Code";
      flake = false;
    };

    #nix-snapd.url = "github:nix-community/nix-snapd";
    #disko = {
    #  url = "github:nix-community/disko";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    nvf-flake = {
      url = "github:pegasora/nvf-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    split-monitor-workspaces,
    ...
  } @ inputs: {
    # use "nixos", or your hostname as the name of the configuration
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs split-monitor-workspaces;};
        modules = [
          #disko.nixosModules.disko
          ./hosts/default/configuration.nix
          inputs.home-manager.nixosModules.home-manager

          #nix-snapd.nixosModules.default
          #{
          #  services.snap.enable = true;
          #}
          # Add these for Disko:
          #disko.nixosModules.disko
          #./disko.nix
          #{
          #  # Pass your disk to Disko
          #  disko.devices.disk.nvme0n1.device = "/dev/nvme0n1";  # Replace with your disk
          #  # Enable Disko (runs on boot to ensure mounts)
          #  disko.enableConfig = true;
          #  # Bootloader (adjust for your setup)
          #  boot.loader = {
          #    systemd-boot.enable = true;
          #    efi.canTouchEfiVariables = true;
          #  };
          #}
        ];
      };
    };
  };
}
