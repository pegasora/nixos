#!/bin/bash

DEBUG_LOG="/tmp/dashlane_debug.log"
echo "" > "$DEBUG_LOG" # Clear log file at start

# Check required tools
if ! command -v fuzzel &>/dev/null; then
  notify-send "Error" "fuzzel not found. Please install it."
  exit 1
fi

# Define modes
modes="Apps\nDashlane\nFiles\nCalculate"

# Show primary fuzzel menu for mode selection
selected_mode=$(echo -e "$modes" | fuzzel --dmenu -p "Raycast: " -i -l 4 -w 30)

case "$selected_mode" in
"Dashlane")
  # Check Dashlane CLI and jq
  if ! command -v dcli &>/dev/null; then
    notify-send "Dashlane" "Dashlane CLI (dcli) not found."
    exit 1
  fi
  if ! command -v jq &>/dev/null; then
    notify-send "Dashlane" "jq not found."
    exit 1
  fi
  if ! command -v wl-copy &>/dev/null; then
    notify-send "Dashlane" "wl-clipboard not found."
    exit 1
  fi

  # Optional: Check wtype for auto-typing
  AUTO_TYPE_AVAILABLE=false
  if command -v wtype &>/dev/null; then
    AUTO_TYPE_AVAILABLE=true
  fi

  # Fetch Dashlane vault items
  items=$(dcli password -o json | jq -r '.[] | .title // .id // .url')
  if [ -z "$items" ]; then
    notify-send "Dashlane" "No vault items found or authentication failed."
    exit 1
  fi

  # Show fuzzel menu for Dashlane login selection
  selected=$(echo "$items" | fuzzel --dmenu -p "Dashlane Login: " -i -l 10 -w 50)

  if [ -n "$selected" ]; then
    # Show action menu
    actions="Copy Password\nCopy Username\nCopy URL"
    if [ "$AUTO_TYPE_AVAILABLE" = true ]; then
      actions="$actions\nAuto-Type"
    fi
    action=$(echo -e "$actions" | fuzzel --dmenu -p "Action for $selected: " -i -l 4 -w 30)

    if [ -n "$action" ]; then
      credential=$(dcli password "title=$selected" -o json)


      if [ -z "$credential" ]; then
        notify-send "Dashlane" "Failed to retrieve details for $selected"
        exit 1
      fi

      case "$action" in
      "Copy Password")
        password=$(echo "$credential" | jq -r '.[0].password // empty')
        echo "Password extracted: $password" >> "$DEBUG_LOG"
        if [ -n "$password" ]; then
          echo -n "$password" | wl-copy
          notify-send "Dashlane" "Password copied"
        else
          echo "No password found for $selected. Raw credential: $credential" >> "$DEBUG_LOG"
          notify-send "Dashlane" "No password found"
        fi
        ;;
      "Copy Username")
        username=$(echo "$credential" | jq -r '.login // .email // empty')
        if [ -n "$username" ]; then
          echo -n "$username" | wl-copy
          notify-send "Dashlane" "Username copied"
        else
          notify-send "Dashlane" "No username found"
        fi
        ;;
      "Copy URL")
        url=$(echo "$credential" | jq -r '.[0].url // empty')
        if [ -n "$url" ]; then
          echo -n "$url" | wl-copy
          notify-send "Dashlane" "URL copied"
        else
          notify-send "Dashlane" "No URL found"
        fi
        ;;
      "Auto-Type")
        if [ "$AUTO_TYPE_AVAILABLE" = true ]; then
          username=$(echo "$credential" | jq -r '.[0].login // .email // empty')
        password=$(echo "$credential" | jq -r '.[0].password // empty')
          if [ -n "$username" ] && [ -n "$password" ]; then
            wtype "$username"
            wtype -k Tab
            wtype "$password"
            wtype -k Return
            notify-send "Dashlane" "Auto-typed credentials"
          else
            notify-send "Dashlane" "Missing username or password"
          fi
        else
          notify-send "Dashlane" "Auto-type not available (wtype missing)"
        fi
        ;;
      esac
    fi
  fi
  ;;
"Apps")
  # Launch fuzzel in app mode
  fuzzel
  ;;
"Files")
  # Use fd or find to search files
  if command -v fd &>/dev/null; then
    selected_file=$(fd . ~ --type f | fuzzel --dmenu -p "File Search: " -i -l 15 -w 50)
  else
    selected_file=$(find ~ -type f | fuzzel --dmenu -p "File Search: " -i -l 15 -w 50)
  fi
  if [ -n "$selected_file" ]; then
    xdg-open "$selected_file" &
    notify-send "Files" "Opening $selected_file"
  fi
  ;;
"Calculate")
  # Prompt for a math expression
  expression=$(echo "" | fuzzel --dmenu -p "Calculate: " -i -l 1 -w 50)
  if [ -n "$expression" ]; then
    result=$(echo "$expression" | bc -l)
    if [ -n "$result" ]; then
      echo -n "$result" | wl-copy
      notify-send "Calculate" "Result: $result (copied to clipboard)"
    else
      notify-send "Calculate" "Invalid expression"
    fi
  fi
  ;;
esac
