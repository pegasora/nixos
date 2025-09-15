# Changes Log

Started transition from Arch to NixOS on Niri.

- Added swaybg, ydotool, polkit_gnome to system packages
- Enabled gnome-keyring service
- Modularized niri config into modules/home-manager/niri.nix
- Imported niri.nix in home.nix
- Created fuzzel.nix module with Catppuccin colors
- Created kitty.nix module with JetBrainsMono Nerd Font
- Created fish.nix module with aliases, functions, and Catppuccin theme (plugins via fisher)
- Fixed hardware.pulseaudio to services.pulseaudio
 - Created starship.nix module with Catppuccin Mocha config
 - Added starship to system packages
 - Commented out plugin-dependent commands in fish init
- Created waybar.nix module with niri config and Catppuccin Mocha theme (removed tray, cleaned json)
- Enabled xdg.portal with GTK portal

---

2025-09-13 — Hyprland migration (in progress)

- Added a new Home Manager module to manage Hyprland at `nixos/modules/home-manager/hypr/hyprland.nix`.
- Converted and copied Hyprland configuration files from `~/old_home_dir/dotfiles/.config/hypr/` into the flake under `nixos/modules/home-manager/hypr/files/`.
- Updated `hosts/default/home.nix` to import the `hypr/hyprland.nix` home module.
- Disabled `programs.niri` in `hosts/default/configuration.nix` and enabled `programs.hyprland`.
- Added home activation to copy wallpapers and installed scripts for wallpaper changing and monitor toggling from the old config.

Notes:
- I copied all hypr config files and scripts into the flake module files directory at `nixos/modules/home-manager/hypr/files/` and updated the `hyprland.nix` module to source these files directly so the flake is self-contained.
- The module also installs hypr helper scripts and ensures the wallpapers directory is created during activation.
- Next steps: run `nixos-rebuild build --flake /home/pegasora/nixos#nixos` to validate changes (I will not run `switch` until you approve).

---

2025-09-13 — Waybar troubleshooting

- Issue: Waybar not running. I investigated the configuration and user/systemd services.

- What I checked:
  - `waybar` binary exists at `/run/current-system/sw/bin/waybar` (Nix-provided).
  - `~/.config/waybar/` files are present and symlinked to the Home Manager store path; `~/.config/waybar/config` is valid JSON.
  - No `waybar` process was running.
  - A systemd user unit exists at `/etc/systemd/user/waybar.service` (enabled) but is `inactive (dead)`.
  - Starting the unit failed with a dependency error: `Dependency failed for Highly customizable Wayland bar for Sway and Wlroots based compositors`.
  - `graphical-session.target` has a failing dependency: `xdg-desktop-portal.service` (marked failed/timeout).
  - `xdg-desktop-portal-gtk.service` repeatedly fails in its journal with `cannot open display:` and `Failed to create settings proxy: Error calling StartServiceByName for org.freedesktop.impl.portal.desktop.gtk: Timeout was reached`.

- Root-cause hypothesis:
  - `xdg-desktop-portal-gtk` is failing to start because it does not have the display/session environment (e.g. `WAYLAND_DISPLAY` / `DISPLAY` / `XDG_RUNTIME_DIR` / `DBUS_SESSION_BUS_ADDRESS`) available to it when systemd attempts to start it. Because `xdg-desktop-portal` is a required dependency of the graphical session target, its failure prevents `graphical-session.target` from becoming active, which in turn prevents `waybar.service` from starting.

- Quick manual test & temporary fix (run *inside your active graphical session terminal*):
  1. Verify session env vars:
     - `printenv XDG_RUNTIME_DIR WAYLAND_DISPLAY DISPLAY DBUS_SESSION_BUS_ADDRESS`
  2. Import these variables into the systemd user environment (so systemd user services can see the display):
     - `systemctl --user import-environment XDG_RUNTIME_DIR WAYLAND_DISPLAY DISPLAY DBUS_SESSION_BUS_ADDRESS`
  3. Restart portal and waybar services and watch logs:
     - `systemctl --user restart xdg-desktop-portal.service xdg-desktop-portal-gtk.service`
     - `journalctl --user -u xdg-desktop-portal.service -f` (or `-u xdg-desktop-portal-gtk.service -f`) to follow runtime logs.
     - Once portal services are active, start/restart waybar: `systemctl --user restart waybar.service` or test-run directly: `waybar &`

  - Expected outcome: importing the display-related env vars into systemd user should allow `xdg-desktop-portal-gtk` to open the display and register on DBus, which will allow `graphical-session.target` to activate and `waybar.service` to start.

- Safer permanent fix (recommended):
  - Ensure the systemd user environment gets the relevant session variables automatically when your compositor starts. Two options:
    1. Add an early session spawn command in your niri session config (which runs inside the compositor session) to import the environment into the systemd user manager:

       - Add to `~/nixos/modules/home-manager/niri.nix` (inside the `spawn-at-startup` list):

          `spawn-at-startup "sh" "-c" "systemctl --user import-environment XDG_RUNTIME_DIR WAYLAND_DISPLAY DISPLAY DBUS_SESSION_BUS_ADDRESS"`

       - This will run when your session starts (niri / sway) and ensure the systemd user sees the display variables.

    2. Or create a small `~/.config/systemd/user/import-display.env.service` unit (managed by Home Manager) that runs at graphical-session start and calls `systemctl --user import-environment ...`.

  - I prefer option 1 because your niri config already runs session startup commands; it’s minimal and reliable.

- Alternative workarounds:
  - Run `waybar` from your compositor autostart (it already appears in the niri spawn list) rather than relying on the systemd user unit. If you prefer the systemd-managed approach, fix the environment export first.
  - If you don’t need XDG portals, you could disable `xdg.portal.enable` in Nix; this removes the portal dependency but loses portal functionality for Flatpak/native apps.

- Next steps I can take (tell me which):
  1. Walk you through the manual test commands above (I’ll wait for your outputs).
  2. If you want the persistent fix, I can add the `systemctl --user import-environment` spawn line to `niri.nix` and record that change in `nixos/changes.md` (I won’t apply the rebuild/switch without your go-ahead).
  3. If you prefer, I can craft a Home Manager-managed systemd user unit to import the environment and add it to the flake; again I will not apply changes until you approve.


---

2025-09-13 — Hyprland migration (continued)

- Converted `hyprland.conf`, `binds.conf`, `animations.conf`, `hypridle.conf`, `hyprlock.conf`, and `hyprpaper.conf` into Nix options within `nixos/modules/home-manager/hypr/hyprland.nix`.
  - Most settings are now declarative Nix options under `wayland.windowManager.hyprland.settings`.
  - Program paths in `exec-once` and `bind` commands now use Nix package paths (e.g., `${pkgs.kitty}/bin/kitty`).
  - Added `systemctl --user import-environment XDG_RUNTIME_DIR WAYLAND_DISPLAY DISPLAY DBUS_SESSION_BUS_ADDRESS` to `exec-once` in `hyprland.nix` to address the XDG portal issue.
  - Scripts (`wallpaper_changer.sh`, `toggle-monitors.sh`, `focus-toggle.sh`, `aio-fuzzel.sh`, `dashlane-fuzzel.sh`) are managed as `home.file` entries sourced from `nixos/modules/home-manager/hypr/files/`.
  - Wallpapers are managed via `home.file` copying the `wallpapers` directory from `nixos/modules/home-manager/hypr/files/`.
  - `home.packages` in `hyprland.nix` now includes `hyprpaper`, `hyprctl`, `jq`, `wl-clipboard`, `cliphist`, `hyprshot`, `wlogout`, `swaynotificationcenter`, `fuzzel`, `brightnessctl`, and `pulseaudio`.
  - `themes/theme.conf` content is now embedded as a `home.file` entry with `text = ''...''`.
- Updated `hosts/default/configuration.nix` to include `polkit_gnome` in `environment.systemPackages`.

Next steps:
- Update `nixos/modules/home-manager/waybar.nix` to remove Niri-specific modules and use Hyprland-compatible ones.
- Review `hosts/default/configuration.nix` for any remaining Niri-specific packages or configurations that can be removed.

---

## 2025-09-13 - Waybar and SDDM Configuration

- **Waybar Configuration:**
    - Updated `nixos/modules/home-manager/waybar.nix` to match `dotfiles/.config/waybar/config` and `dotfiles/.config/waybar/style.css`.
    - Embedded the content of `dotfiles/.config/waybar/mocha.css` directly into `programs.waybar.style` in `nixos/modules/home-manager/waybar.nix` to resolve undefined color variables.

- **SDDM Login Screen:**
    - Enabled SDDM in `nixos/hosts/default/configuration.nix` by setting `services.displayManager.sddm.enable = true;` and `services.displayManager.sddm.wayland.enable = true;`.
    - Configured SDDM to use the `catppuccin-mocha` theme.
    - Added `catppuccin-sddm` as an input in `nixos/flake.nix`.
    - Corrected the `environment.systemPackages` error by merging the `catppuccin-sddm` package into the existing list in `nixos/hosts/default/configuration.nix`.
    - Corrected the `attribute 'override' missing` error by changing `inputs.catppuccin-sddm.override` to `pkgs.callPackage inputs.catppuccin-sddm`.
    - Corrected the `error: opening file ... default.nix': No such file or directory` error by removing the catppuccin-sddm flake input (since the package is available in nixpkgs) and using `pkgs.catppuccin-sddm.override { flavor = "mocha"; }` instead of `pkgs.callPackage inputs.catppuccin-sddm`.
   - Updated SDDM theme name to "catppuccin-mocha-mauve" to match the default accent in the nixpkgs package.
   - Fixed deprecated `hardware.pulseaudio` option by changing it to `services.pulseaudio`.
   - Disabled SDDM Wayland to potentially fix theme display issues (the Catppuccin theme may not render correctly on Wayland).
   - Enabled services.xserver.enable to satisfy SDDM requirements when running on X11.

---

2025-09-13 — Kanshi Screen Management

- Added kanshi to home.packages for Wayland output management.
- Enabled services.kanshi in home-manager for declarative screen configuration.
- Configured kanshi via home.file for the config file and added to Hyprland exec-once for automatic startup (since services.kanshi does not exist in NixOS).

---

2025-09-13 — Fastfetch Configuration

- Added fastfetch to home.packages for system information display with random animal logos.
- Copied config.jsonc and animal images from dotfiles to flake files/fastfetch/.
- Configured home.file to symlink the config and animal directory for random animal display on each terminal launch.

---

2025-09-13 — Nerd Fonts for Symbols

- Enabled fonts.fontDir.enable and fonts.fontconfig.enable in system config for better font support.
- Updated waybar font-family to "Comic Code", "JetBrainsMonoNerdFont" for fallback to Nerd Font symbols.

---

2025-09-13 — Hyprland Cursor Fix

- Added cursor settings to disable hardware cursors and set inactive timeout to 0 for normal cursor appearance.

---

2025-09-14 — Polkit Authentication Agent Fix

- Fixed GParted authentication issue by correcting the Polkit authentication agent path in Hyprland configuration
- Changed from incorrect KDE agent path "/usr/lib/polkit-kde-authentication-agent-1" to proper GNOME agent path "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
- Added polkit_gnome to home.packages in hyprland.nix to ensure the package is available
- This resolves the "Error executing command as another user: No authentication agent found" error when running GParted