# nixos

Personal NixOS flake configuration for `nixos` (primary machine). A second host `olympus` is planned but not yet created.

## Daily Commands

```bash
just switch        # Build and switch to current config (uses nh, auto-detects hostname)
just update        # Update flake.lock (nix flake update)
just clean         # Clean old generations (nh clean all)
```

Dry-run / check without switching:
```bash
nix flake check
nixos-rebuild dry-activate --flake "./#nixos"
```

## Stack

| Layer | Tool |
|---|---|
| Base | NixOS (nixpkgs-unstable) |
| WM | niri (Wayland compositor) |
| Bar / Shell | Noctalia |
| Theming | Stylix (kanagawa dark, Comic Code Ligatures) |
| Terminal | Ghostty / Kitty |
| Shell | Fish |
| Editor | Neovim (via nvf-flake) |
| Dotfiles | Home Manager |
| Secrets | SOPS + age |

## Fresh Install (nixos-anywhere / disko)

### 1. Boot the target machine from a NixOS ISO

### 2. On your dev machine, run nixos-anywhere

```bash
nix run .#nixos-anywhere -- --flake .#nixos root@<target-ip>
```

This will partition, format, and install in one shot using the disko config.

### 3. Generate hardware config (if setting up a new host)

```bash
nixos-generate-config --root /mnt --no-filesystems
# copy the result into hosts/<hostname>/hardware-configuration.nix
```

### 4. Post-install: SOPS keys

Copy your age key to the new machine:
```bash
scp keys.txt root@<target>:/etc/sops/age/keys.txt
ssh root@<target> chmod 600 /etc/sops/age/keys.txt
```

Test decryption:
```bash
sops -d ./secrets/proton_wg.conf.age
```

## Adding a New Host

1. Create `hosts/<hostname>/` with `configuration.nix`, `home.nix`, `hardware-configuration.nix`
2. Add the host to `flake.nix` under `nixosConfigurations`
3. Add a disko config under `disks/` if needed

## Module Layout

```
hosts/default/          # Per-machine config
  configuration.nix     # System: bootloader, services, imports
  home.nix              # Home Manager entry point
  hardware-configuration.nix

modules/nixos/          # System-level modules
  packages.nix          # System package list
  services.nix          # Services (pipewire, tailscale, flatpak, kanata, etc.)
  cross-compilation.nix # ARM binfmt emulation
  stylix.nix            # Theming — fonts, colors, base16 scheme

modules/home-manager/   # User-level modules
  terminal/             # shells/, cli/, multiplexers/, emulators/
  wm/                   # niri/ (active), hyprland/ (disabled)
  utils/                # fuzzel, swaync, hyprlock, noctalia, etc.

overlays/               # Package overrides (winboat fixes)
disks/                  # Disko partition configs
DevShells/python/       # devenv.sh Python dev shell
```

## Theming

All fonts and colors flow from `modules/nixos/stylix.nix`. When adding a new program, check if stylix has a module for it — if so, comment out any conflicting `theme`/`font`/color settings with a `# managed by stylix` note to avoid build errors.
