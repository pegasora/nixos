{
  description = "Nixos config flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland";
    };
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
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    split-monitor-workspaces,
    ...
  } @ inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs split-monitor-workspaces;};
        modules = [
          ./hosts/default/configuration.nix
          inputs.home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
