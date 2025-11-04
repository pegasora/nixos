# This is a justfile for managing the NixOS configuration.

# list all options
list:
    @just --list

# Clean all the NixOS configurations
clean:
    nh clean all

# switch using nh, will auto-detect hostname
switch:
    nh os switch .

# update flakes
update:
    nix flake update

################################################################################
# LEGACY, in case nh is not working 
################################################################################

# Rebuild the NixOS configuration. Packages, services, etc. will be rebuilt.
switch-old host:
    sudo nixos-rebuild switch --flake "./#{{host}}"

# Update flakes and rebuild the NixOS configuration
update-full-old host:
    nix flake update
    sudo nixos-rebuild switch --flake "./#{{host}}"
