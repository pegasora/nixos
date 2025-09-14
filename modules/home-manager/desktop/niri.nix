{ config, pkgs, ... }:

{
  home.file.".config/niri/config.kdl".text = ''
input {
    keyboard {
        xkb {
        }
        numlock
    }
    touchpad {
        tap
        natural-scroll
        scroll-method "two-finger"
    }

    mouse {
        natural-scroll
    }

    trackpoint {
        off
    }

    // Uncomment this to make the mouse warp to the center of newly focused windows.
    // warp-mouse-to-focus

    // Focus windows and outputs automatically when moving the mouse into them.
    // Setting max-scroll-amount="0%" makes it work only on windows already fully on screen.
    focus-follows-mouse max-scroll-amount="0%"
}

/-output "eDP-1" {
}

layout {
    gaps 5

    always-center-single-column
    center-focused-column "never"

    preset-column-widths {
        proportion 0.25
        proportion 0.33333
        proportion 0.5
        proportion 0.66667
        proportion 0.75
        proportion 0.85
        proportion 1.0
    }

    // You can also customize the heights that "switch-preset-window-height" (Mod+Shift+R) toggles between.
    // preset-window-heights { }

    default-column-width { proportion 0.5; }

    // You can change how the focus ring looks.
    focus-ring {
        // How many logical pixels the ring extends out from the windows.
        width 2

        // Color of the ring on the active monitor.
        active-color "#7fc8ff"

        // Color of the ring on inactive monitors.
        inactive-color "#505050"
    }

    border {
        off

        //width 4
        active-color "#ffc87f"
        inactive-color "#505050"

        // Color of the border around windows that request your attention.
        urgent-color "#9b0000"
    }

    // You can enable drop shadows for windows.
    shadow {
    }

    struts {
    }
}

// Add lines like this to spawn processes at startup.
// Note that running niri as a session supports xdg-desktop-autostart,

spawn-at-startup "waybar"
spawn-at-startup "swaync"
spawn-at-startup "ydotoold"
spawn-at-startup "kitty"
spawn-at-startup "sh" "-c" "swaybg -i \"$(find ~/.config/niri/wallpapers/ -type f | shuf -n 1)\" &"
spawn-at-startup "nm-applet"
spawn-at-startup "blueman-applet"
spawn-at-startup "polkit-gnome-authentication-agent-1"
spawn-at-startup "wl-paste" "--type" "text" "--watch" "cliphist" "store"
spawn-at-startup "xwayland-satellite"

environment {
    DISPLAY ":1"
    ELECTRON_OZONE_PLATFORM_HINT "auto"
}

screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

// You can also set this to null to disable saving screenshots to disk.
// screenshot-path null

animations {
    window-close {
        duration-ms 250
        curve "ease-out-quad"
    }

    screenshot-ui-open {
        duration-ms 500
        curve "ease-out-quad"
    }

    workspace-switch {
        spring damping-ratio=0.7 stiffness=200 epsilon=0.0001
    }

    overview-open-close {
        spring damping-ratio=0.7 stiffness=200 epsilon=0.0001
    }

    horizontal-view-movement {
        spring damping-ratio=0.7 stiffness=200 epsilon=0.0001
    }
    window-resize {
        spring damping-ratio=0.7 stiffness=200 epsilon=0.0001
    }

    window-open {
        spring damping-ratio=0.7 stiffness=200 epsilon=0.0001
    }

    window-movement {
        spring damping-ratio=0.7 stiffness=200 epsilon=0.0001
    }

}

window-rule {
    match app-id=r#"^org\.wezfurlong\.wezterm$"#
    default-column-width {}
}

window-rule {
    draw-border-with-background false
}

window-rule {
    match app-id=r#"^org\.kde\.kdeconnect\.daemon$"#
    match app-id=r#"^galculator$"#
    match app-id=r#"^org.kde.kdeconnect\.handler$"#
    open-floating true
}

window-rule {
    match app-id="polkit-gnome-authentication-agent-1"
    block-out-from "screen-capture"
}


window-rule {
    match app-id=r#"obsidian$"#
    default-column-width {proportion 0.5;}
}

window-rule {
    match app-id=r#"kitty$"#
    default-column-width {proportion 1.0;}
}

window-rule {
    geometry-corner-radius 10
    clip-to-geometry true
}

hotkey-overlay {
    skip-at-startup
}

overview {
    zoom 0.75
    backdrop-color "#313244"
}

binds {
    Mod+Q { close-window; }

    Mod+H     { focus-column-left; }
    Mod+J     { focus-window-down; }
    Mod+K     { focus-window-up; }
    Mod+L     { focus-column-right; }
    Mod+Ctrl+H     { move-column-left; }
    Mod+Ctrl+J     { move-window-down; }
    Mod+Ctrl+K     { move-window-up; }
    Mod+Ctrl+L     { move-column-right; }

    Mod+Shift+Slash { show-hotkey-overlay; }

    // Suggested binds for running programs: terminal, app launcher, screen locker.
    Mod+T hotkey-overlay-title="Open a Terminal: kitty" { spawn "kitty"; }
    Mod+Space hotkey-overlay-title="Run an Application: fuzzel" { spawn "fuzzel"; }
    Super+Shift+L hotkey-overlay-title="Lock the Screen: swaylock" { spawn "swaylock"; }
    Mod+E hotkey-overlay-title="Open File Manager: dolphin" { spawn "dolphin"; }
    Mod+P hotkey-overlay-title="Logout: wlogout" { spawn "wlogout"; } // Consider swaylock for locking
    Mod+F hotkey-overlay-title="Open Browser: zen-browser" { spawn "zen-browser"; }
    Mod+O hotkey-overlay-title="Open Notes: obsidian" { spawn "obsidian"; }
    Mod+N hotkey-overlay-title="swaync" { spawn "sh" "-c" "swaync-client -t -sw"; }
    // TODO: change to fuzzel //Mod+B hotkey-overlay-title="Open Passwords: rofi-rbw" { spawn "rofi-rbw"; }
    Mod+B { spawn "sh" "-c" "rofi-rbw --selector fuzzel --clipboarder wl-copy"; }
    Mod+V {spawn "sh" "-c" "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"; }
    Mod+W { spawn "sh" "-c" "pkill waybar && waybar &"; }
    Mod+C { spawn "~/.config/niri/scripts/wallpaper_changer.sh"; }

    // Example volume keys mappings for PipeWire & WirePlumber.
    // The allow-when-locked=true property makes them work even when the session is locked.
    XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+"; }
    XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-"; }
    XF86AudioMute        allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
    XF86AudioMicMute     allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
    XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "s" "10%+"; }
    XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "s" "10%-"; }

    Mod+Shift+H     { focus-monitor-left; }
    Mod+Shift+J     { focus-monitor-down; }
    Mod+Shift+K     { focus-monitor-up; }
    Mod+Shift+L     { focus-monitor-right; }
    Mod+Shift+Ctrl+J     { move-column-to-monitor-down; }
    Mod+Shift+Ctrl+K     { move-column-to-monitor-up; }
    Mod+Shift+Ctrl+L     { move-column-to-monitor-right; }

    Mod+U              { focus-workspace-down; }
    Mod+I              { focus-workspace-up; }
    Mod+Ctrl+U         { move-column-to-workspace-down; }
    Mod+Ctrl+I         { move-column-to-workspace-up; }

    Mod+Shift+Page_Down { move-workspace-down; }
    Mod+Shift+Page_Up   { move-workspace-up; }
    Mod+Shift+U         { move-workspace-down; }
    Mod+Shift+I         { move-workspace-up; }

    Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
    Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
    Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
    Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

    Mod+WheelScrollRight      { focus-column-right; }
    Mod+WheelScrollLeft       { focus-column-left; }
    Mod+Ctrl+WheelScrollRight { move-column-right; }
    Mod+Ctrl+WheelScrollLeft  { move-column-left; }

    Mod+Shift+WheelScrollDown      { focus-column-right; }
    Mod+Shift+WheelScrollUp        { focus-column-left; }
    Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
    Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

    // Mod+TouchpadScrollDown { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02+"; }
    // Mod+TouchpadScrollUp   { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.02-"; }

    // You can refer to workspaces by index. However, keep in mind that
    // niri is a dynamic workspace system, so these commands are kind of
    // "best effort". Trying to refer to a workspace index bigger than
    // the current workspace count will instead refer to the bottommost
    // (empty) workspace.
    //
    // For example, with 2 workspaces + 1 empty, indices 3, 4, 5 and so on
    // will all refer to the 3rd workspace.
    Mod+1 { focus-workspace 1; }
    Mod+2 { focus-workspace 2; }
    Mod+3 { focus-workspace 3; }
    Mod+4 { focus-workspace 4; }
    Mod+5 { focus-workspace 5; }
    Mod+6 { focus-workspace 6; }
    Mod+7 { focus-workspace 7; }
    Mod+8 { focus-workspace 8; }
    Mod+9 { focus-workspace 9; }
    Mod+Shift+1 { move-column-to-workspace 1; }
    Mod+Shift+2 { move-column-to-workspace 2; }
    Mod+Shift+3 { move-column-to-workspace 3; }
    Mod+Shift+4 { move-column-to-workspace 4; }
    Mod+Shift+5 { move-column-to-workspace 5; }
    Mod+Shift+6 { move-column-to-workspace 6; }
    Mod+Shift+7 { move-column-to-workspace 7; }
    Mod+Shift+8 { move-column-to-workspace 8; }
    Mod+Shift+9 { move-column-to-workspace 9; }
    Mod+Shift+0 { move-column-to-workspace 10; }

    // Alternatively, there are commands to move just a single window:
    // Mod+Ctrl+1 { move-window-to-workspace 1; }

    // Switches focus between the current and the previous workspace.
    // Mod+Tab { focus-workspace-previous; }

    // The following binds move the focused window in and out of a column.
    // If the window is alone, they will consume it into the nearby column to the side.
    // If the window is already in a column, they will expel it out.
    Mod+BracketLeft  { consume-or-expel-window-left; }
    Mod+BracketRight { consume-or-expel-window-right; }

    // Consume one window from the right to the bottom of the focused column.
    Mod+Comma  { consume-window-into-column; }
    // Expel the bottom window from the focused column to the right.
    Mod+Period { expel-window-from-column; }

    Mod+R { switch-preset-column-width; }
    Mod+Shift+R { switch-preset-window-height; }
    Mod+Ctrl+R { reset-window-height; }
    //Mod+F { maximize-column; }
    Mod+Shift+F { fullscreen-window; }

    // Expand the focused column to space not taken up by other fully visible columns.
    // Makes the column "fill the rest of the space".
    Mod+Ctrl+F { expand-column-to-available-width; }

    //Mod+C { center-column; }

    // Center all fully visible columns on screen.
    Mod+Ctrl+C { center-visible-columns; }

    // Finer width adjustments.
    // This command can also:
    // set width in pixels: "1000"
    // adjust width in pixels: "-5" or "+5"
    // set width as a percentage of screen width: "25%"
    // adjust width as a percentage of screen width: "-10%" or "+10%"
    // Pixel sizes use logical, or scaled, pixels. I.e. on an output with scale 2.0,
    // set-column-width "100" will make the column occupy 200 physical screen pixels.
    Mod+Minus { set-column-width "-10%"; }
    Mod+Equal { set-column-width "+10%"; }

    // Finer height adjustments when in column with other windows.
    Mod+Shift+Minus { set-window-height "-10%"; }
    Mod+Shift+Equal { set-window-height "+10%"; }

    // Move the focused window between the floating and the tiling layout.
    Mod+Shift+W       { toggle-window-floating; }
    //Mod+Shift+V { switch-focus-between-floating-and-tiling; }

    // Toggle tabbed column display mode.
    // Windows in this column will appear as vertical tabs,
    // rather than stacked on top of each other.
    //Mod+W { toggle-column-tabbed-display; }

    // Actions to switch layouts.
    // Note: if you uncomment these, make sure you do NOT have
    // a matching layout switch hotkey configured in xkb options above.
    // Having both at once on the same hotkey will break the switching,
    // since it will switch twice upon pressing the hotkey (Mod+Space is used for app launcher).
    // Mod+Space       { switch-layout "next"; }
    // Mod+Shift+Space { switch-layout "prev"; }

    //Print { screenshot; }
    Mod+S { screenshot-window; }
    Mod+Shift+S { screenshot; }

    // Applications such as remote-desktop clients and software KVM switches may
    // request that niri stops processing the keyboard shortcuts defined here
    // so they may, for example, forward the key presses as-is to a remote machine.
    // It's a good idea to bind an escape hatch to toggle the inhibitor,
    // so a buggy application can't hold your session hostage.
    //
    // The allow-inhibiting=false property can be applied to other binds as well,
    // which ensures niri always processes them, even when an inhibitor is active.
    Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }

    // The quit action will show a confirmation dialog to avoid accidental exits.
    //Mod+Shift+E { quit; }
    //Ctrl+Alt+Delete { quit; }

    // Powers off the monitors. To turn them back on, do any input like
    // moving the mouse or pressing any other key.
    //Mod+Shift+P { power-off-monitors; }
}
'';

  home.file.".config/niri/scripts/wallpaper_changer.sh" = {
    executable = true;
    text = ''
#!/bin/bash
# ~/.config/niri/scripts/wallpaper_changer.sh
pkill swaybg
swaybg -i "$(find ~/.config/niri/wallpapers/ -type f | shuf -n 1)" &
'';
  };

  home.activation.copyWallpapers = ''
    mkdir -p ~/.config/niri/wallpapers
    cp -r /home/pegasora/dotfiles/.config/niri/wallpapers/* ~/.config/niri/wallpapers/
  '';
}
