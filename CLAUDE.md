# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Common Commands

```bash
just switch        # Build and switch to current config (uses nh, auto-detects hostname)
just update        # Update flake.lock (nix flake update)
just clean         # Clean old NixOS generations (nh clean all)

# Legacy fallbacks if nh is unavailable:
just switch-old <host>   # sudo nixos-rebuild switch --flake "./#<host>"
```

To check a config without switching: `nix flake check` or `nixos-rebuild dry-activate --flake "./#nixos"`.

## Architecture Overview

This is a modular NixOS flake configuration for two machines (`nixos` and `olympus`), with `hosts/olympus/` not yet created.

### Flake Inputs (key ones)
- **nixpkgs** (unstable) — base packages
- **home-manager** — user dotfile/app management, integrated as a NixOS module
- **stylix** — unified theming (kanagawa dark)
- **niri** — Wayland compositor (primary WM)
- **spicetify-nix** — Spotify customization
- **nvf-flake** — custom Neovim config
- **disko** — automated disk partitioning
- **claude-code** / **claude-desktop** — Anthropic tools

### Module Layout

```
hosts/default/          # Per-machine config
  configuration.nix     # System: bootloader, services, imports
  home.nix              # Home Manager entry point
  hardware-configuration.nix

modules/nixos/          # System-level modules (imported via default.nix)
  packages.nix          # System package list
  services.nix          # Services (pipewire, tailscale, flatpak, kanata, etc.)
  cross-compilation.nix # ARM binfmt emulation support
  stylix.nix            # Theming master — fonts, colors, base16 scheme

modules/home-manager/   # User-level modules (imported via default.nix)
  terminal/             # shells/, cli/, multiplexers/, emulators/
  wm/                   # niri/ (active), hyprland/, dwm/ (disabled)
  utils/                # fuzzel, swaync, hyprlock, noctalia, etc.

overlays/               # Package overrides (currently: winboat fixes)
disks/                  # Disko partition configs
DevShells/python/       # devenv.sh Python dev shell
```

### Key Patterns
- **`specialArgs = {inherit inputs;}`** — flake inputs are available in all modules
- **`default.nix` aggregators** — each subdirectory has a `default.nix` that imports its siblings
- Modules use standard `enable = true/false` toggles
- Overlays are passed via `nixpkgs.overlays` in the flake outputs

### Stylix (Theming)
`modules/nixos/stylix.nix` is the single source of truth for fonts and colors. It:
- Sets the base16 scheme (`kanagawa.yaml`) and polarity
- Builds the `comiccode-font` derivation from `inputs.comic-code` and sets it as the font for all stylix slots (monospace, sansSerif, serif)
- Automatically configures supported programs (kitty, ghostty, hyprlock, starship, yazi, spicetify, Qt/Kvantum, GTK, etc.)

**When adding a new program:** check if stylix has a module for it. If it does, comment out any `theme`, `font`, or color settings in that program's nix file with a `# managed by stylix` note — otherwise the build will fail with a "conflicting definition values" error.

**Qt apps** (e.g. Dolphin) pick up the stylix Kvantum theme via `QT_QPA_PLATFORMTHEME = "qt5ct"` set in `environment.sessionVariables`.

**MIME defaults** are managed declaratively via `xdg.mimeApps` in `hosts/default/home.nix`. To make a new file-type association permanent, add it there rather than relying on per-app dialogs.

### Active Overlays
`overlays/winboat-e3c7fb8.nix` patches the winboat package (Windows VM frontend):
- Pins electron to v40 (v41 broke node-abi compatibility)
- Pins nodejs (nodejs_24 was removed from nixpkgs)
- Fixes Go cross-compilation for mingwW64

### Secrets
SOPS + age is used for encrypted configs. After first build:
1. Copy `keys.txt` to `/etc/sops/age/keys.txt` with `chmod 600`
2. Test: `sops -d ./secrets/proton_wg.conf.age`

### Fresh Install (Disko path)
See README.md for the full disko-based install flow. `nixos-anywhere` is exposed as a flake app (`nix run .#nixos-anywhere`).
