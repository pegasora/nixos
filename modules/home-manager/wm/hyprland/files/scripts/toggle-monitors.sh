#!/usr/bin/env bash

LAPTOP="eDP-1"
EXT1="DVI-I-1"
EXT2="DVI-I-2"

# Check if dock monitors are connected
if hyprctl monitors -j | jq -r '.[].name' | grep -q "$EXT1"; then
  echo "Dock detected, switching to externals"

  # Turn off laptop panel
  hyprctl keyword monitor "$LAPTOP,disable"

  # External 1 (left monitor, normal)
  hyprctl keyword monitor "$EXT2,2048x1150@50,0x0,1"

  # External 2 (right monitor, rotated 90° clockwise for horizontal)
  hyprctl keyword monitor "$EXT1,2048x1150@50,2048x0,1,transform,3"

else
  echo "Dock not detected, switching to laptop"

  # Laptop only
  hyprctl keyword monitor "$LAPTOP,preferred,auto,1"
  hyprctl keyword monitor "$EXT1,disable"
  hyprctl keyword monitor "$EXT2,disable"
fi
