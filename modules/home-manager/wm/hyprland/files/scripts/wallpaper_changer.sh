#!/usr/bin/env bash
# filepath: ~/.config/hypr/scripts/wallpaper_changer.sh
set -euo pipefail

directory="$HOME/dotfiles/.config/hypr/wallpapers"

# collect jpg files safely
shopt -s nullglob
mapfile -t files < <(
  printf '%s\n' "$directory"/*.jpg "$directory"/*.jpeg
  2>/dev/null
)
shopt -u nullglob

if [ "${#files[@]}" -eq 0 ]; then
  printf 'No wallpaper files found in %s\n' "$directory" >&2
  exit 1
fi

# pick a random file
random_background="${files[RANDOM % ${#files[@]}]}"

# get monitor names using hyprctl json output (jq required)
if ! command -v hyprctl >/dev/null 2>&1; then
  printf 'hyprctl not found in PATH\n' >&2
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  printf 'jq not found in PATH (required to parse monitors)\n' >&2
  exit 1
fi

mapfile -t monitors < <(hyprctl monitors -j | jq -r '.[].name')

if [ "${#monitors[@]}" -eq 0 ]; then
  printf 'No monitors detected via hyprctl\n' >&2
  exit 1
fi

# unload and preload
hyprctl hyprpaper unload all || true
hyprctl hyprpaper preload "$random_background" || true

# set wallpaper per-monitor (no space after comma)
for m in "${monitors[@]}"; do
  printf 'Setting wallpaper for monitor: %s -> %s\n' "$m" "$random_background"
  hyprctl hyprpaper wallpaper "${m},${random_background}" || {
    printf 'Failed to set wallpaper for monitor %s\n' "$m" >&2
  }
done

exit 0
