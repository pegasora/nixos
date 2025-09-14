#!/usr/bin/env bash

# Get current active monitor
CURRENT_MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')

# Get all connected monitors
MONITORS=$(hyprctl monitors -j | jq -r '.[].name')

# Find the next monitor to focus
NEXT_MONITOR=""
FOUND_CURRENT=false
for M in $MONITORS; do
  if [ "$FOUND_CURRENT" = true ]; then
    NEXT_MONITOR="$M"
    break
  fi
  if [ "$M" = "$CURRENT_MONITOR" ]; then
    FOUND_CURRENT=true
  fi
done

# If no next monitor found (e.g., at the end of the list), loop back to the first
if [ -z "$NEXT_MONITOR" ]; then
  NEXT_MONITOR=$(echo "$MONITORS" | head -n 1)
fi

# Dispatch focus to the next monitor
if [ -n "$NEXT_MONITOR" ]; then
  hyprctl dispatch focusmonitor "$NEXT_MONITOR"
fi
