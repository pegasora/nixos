{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    niri.url = "github:sodiboo/niri-flake";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    comic-code = {
      url = "github:pegasora/Comic-Code";
      flake = false;
    };
    nvf-flake = {
      url = "github:pegasora/nvf-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-anywhere = {
      url = "github:nix-community/nixos-anywhere";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fw-fanctrl = {
      url = "github:TamtamHero/fw-fanctrl/packaging/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    claude-code = {
      url = "github:sadjow/claude-code-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    claude-desktop = {
      url = "github:aaddrick/claude-desktop-debian";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell"; # Use same quickshell version
    };
    stylix = {
      url = "github:nix-community/stylix";
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
    fw-fanctrl,
    claude-code,
    claude-desktop,
    stylix,
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
    # Expose nixos-anywhere as a runnable app
    apps.x86_64-linux.nixos-anywhere = {
      type = "app";
      program = "${nixos-anywhere.packages.x86_64-linux.default}/bin/nixos-anywhere";
    };
  };
}
