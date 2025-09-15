{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # hyprland 
    hyprland.url = "github:hyprwm/Hyprland";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # fonts 
    monolisa = { url = "github:pegasora/Monolisa"; flake = false; };
    comic-code = { url = "github:pegasora/Comic-Code"; flake = false; };
  };

  outputs = { self, nixpkgs, disko, ... }@inputs: {
    # use "nixos", or your hostname as the name of the configuration
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
	  disko.nixosModules.disko
          ./hosts/default/configuration.nix
          inputs.home-manager.nixosModules.home-manager
	
	  # Add these for Disko:
          disko.nixosModules.disko
          ./disko.nix
          {
            # Pass your disk to Disko
            disko.devices.disk.nvme0n1.device = "/dev/nvme0n1";  # Replace with your disk
            # Enable Disko (runs on boot to ensure mounts)
            disko.enableConfig = true;
            # Bootloader (adjust for your setup)
            boot.loader = {
              systemd-boot.enable = true;
              efi.canTouchEfiVariables = true;
          };
          # Remove any conflicting fileSystems from hardware-configuration.nix later
        }
        ];
      };
    };
  };
}
