# This is a justfile for managing the NixOS configuration.

list:
    @just --list

# Rebuild the NixOS configuration. Packages, services, etc. will be rebuilt.
switch host:
    sudo nixos-rebuild switch --flake "./#{{host}}"

# Update flakes 
update host:
    nix flake update

# Update flakes and rebuild the NixOS configuration
update-full host:
    nix flake update
    sudo nixos-rebuild switch --flake "./#{{host}}"
