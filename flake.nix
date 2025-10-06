{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    niri.url = "github:sodiboo/niri-flake";
    #hyprland.url = "github:hyprwm/Hyprland";
    #split-monitor-workspaces = {
    #  url = "github:Duckonaut/split-monitor-workspaces";
    #  inputs.hyprland.follows = "hyprland";
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
    nvf-flake = {
      url = "github:pegasora/nvf-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-anywhere = {
      url = "github:nix-community/nixos-anywhere";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # For Raspberry Pi hardware support (optional but recommended for Pis)
    #nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    niri,
    disko,
    nixos-anywhere,
    ...
  } @ inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/default/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          disko.nixosModules.disko
        ];
      };
      olympus = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/olympus/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          disko.nixosModules.disko
        ];
      };
    };
    # Expose nixos-anywhere as a runnable app from the flake
    # This lets you run `nix run .#nixos-anywhere` without external dependencies
    apps = rec {
      default = nixos-anywhere;
      nixos-anywhere = {
        type = "app";
        program = "${nixos-anywhere.packages.${nixpkgs.system}.default}/bin/nixos-anywhere";
      };
    };
  };
}
