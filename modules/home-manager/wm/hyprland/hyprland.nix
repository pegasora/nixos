{ config, pkgs, lib, split-monitor-workspaces, ... }:

{
  # Manage Hyprland via the wayland.windowManager module
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
    ];

    # General settings
    settings = {
      general = { 
        gaps_in = 0;
        gaps_out = 0;
        border_size = 1;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };

      # Decoration settings
      decoration = {
        rounding = 1;
        # blur = {
        #   enabled = true;
        #   size = 5;
        #   passes = 1;
        #   vibrancy = 0.1696;
        # };
      };

      # Dwindle layout settings
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2;
      };

      # Master layout settings
      master = {
        new_status = "master";
      };

      # Misc settings
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        font_family = "Comic Code Ligatures";
        animate_mouse_windowdragging = true;
        focus_on_activate = true;
      };

       # Input settings
       input = {
         kb_layout = "us";
         kb_variant = "";
         kb_model = "";
         kb_options = "";
         kb_rules = "";
         follow_mouse = 1;
         sensitivity = 0;
         natural_scroll = true;
         touchpad = {
           natural_scroll = true;
           clickfinger_behavior = true;
           "tap-to-click" = true;
         };
       };

        # Cursor settings
        cursor = {
          # Allow hardware cursors so the desktop cursor theme is used
          no_hardware_cursors = false;
          inactive_timeout = 0;
        };

      # Gestures
      gestures = {
        workspace_swipe_invert = true;
      };

      # Plugins (example for split-monitor-workspaces)
      plugin = {
        "split-monitor-workspaces" = {
          count = 10;
          keep_focused = 0;
          enable_notifications = 1;
          enable_persistent_workspaces = 0;
        };
      };

      # Window rules
      windowrulev2 = [
        "suppressevent maximize, class:.*"
        # "layerrule = blur,vicinae"
        # "layerrule = ignorealpha 0, vicinae"
      ];

      # Environment variables
      env = [
        "XCURSOR_SIZE,24"
        "XCURSOR_THEME,Adwaita"
        "HYPRCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,Adwaita"
      ];

      # Autostart commands (converted from exec-once)
      exec-once = [
        #"vicinae server"
        "kanshi"
        #"hyprpm reload -n"
        "kanata -c ~/.config/kanata/config.kbd"
        "swaync"
        "${pkgs.kitty}/bin/kitty & ${pkgs.waybar}/bin/waybar & ${pkgs.hyprpaper}/bin/hyprpaper"
        "hypridle"
        "nm-applet"
        "blueman-applet"
         "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "wl-paste --type text --watch cliphist store"
        # Import Wayland environment variables for systemd user services
        "systemctl --user import-environment XDG_RUNTIME_DIR WAYLAND_DISPLAY DISPLAY DBUS_SESSION_BUS_ADDRESS"
      ];

      # Keybindings (converted from binds.conf)
      bind = [
        "SUPER, T, exec, ${pkgs.kitty}/bin/kitty"
        "SUPER, Q, killactive,"
        "SUPER SHIFT, L, exec, ${pkgs.hyprlock}/bin/hyprlock"
        "SUPER, E, exec, ${pkgs.kdePackages.dolphin}/bin/dolphin"
        "SUPER, SPACE, exec, ${pkgs.fuzzel}/bin/fuzzel"
        "SUPER, P, exec, ${pkgs.wlogout}/bin/wlogout"
        "SUPER, F, exec, ${pkgs.firefox}/bin/firefox"

        "SUPER, B, exec, ~/.config/hypr/scripts/dashlane-fuzzel.sh"
        "SUPER, N, exec, ${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw"
        "SUPER, M, exec, ~/.config/hypr/scripts/focus-toggle.sh"
        "SUPER, W, exec, pkill waybar && ${pkgs.waybar}/bin/waybar &"
        "SUPER, C, exec, ~/.config/hypr/scripts/wallpaper_changer.sh"
        "SUPER, V, exec, ${pkgs.cliphist}/bin/cliphist list | ${pkgs.fuzzel}/bin/fuzzel --dmenu | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy"
        "SUPER, S, exec, ${pkgs.hyprshot}/bin/hyprshot -m window -o ~/Pictures/Screenshots/"
        "SUPER SHIFT, S, exec, ${pkgs.hyprshot}/bin/hyprshot -m region -o ~/Pictures/Screenshots/"

        # Window Navigation
        "SUPER, H, movefocus, l"
        "SUPER, L, movefocus, r"
        "SUPER, K, movefocus, u"
        "SUPER, J, movefocus, d"

        # Switching workspaces
        "SUPER, 1, split-workspace, 1"
        "SUPER, 2, split-workspace, 2"
        "SUPER, 3, split-workspace, 3"
        "SUPER, 4, split-workspace, 4"
        "SUPER, 5, split-workspace, 5"
        "SUPER, 6, split-workspace, 6"
        "SUPER, 7, split-workspace, 7"
        "SUPER, 8, split-workspace, 8"
        "SUPER, 9, split-workspace, 9"
        "SUPER, 0, split-workspace, 10"

        # Move window to workspace
        "SUPER SHIFT, 1, split-movetoworkspace, 1"
        "SUPER SHIFT, 2, split-movetoworkspace, 2"
        "SUPER SHIFT, 3, split-movetoworkspace, 3"
        "SUPER SHIFT, 4, split-movetoworkspace, 4"
        "SUPER SHIFT, 5, split-movetoworkspace, 5"
        "SUPER SHIFT, 6, split-movetoworkspace, 6"
        "SUPER SHIFT, 7, split-movetoworkspace, 7"
        "SUPER SHIFT, 8, split-movetoworkspace, 8"
        "SUPER SHIFT, 9, split-movetoworkspace, 9"
        "SUPER SHIFT, 0, split-movetoworkspace, 10"

        # Scroll through existing workspaces with mainMod + scroll
        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"

        # Move/resize windows with mainMod + LMB/RMB and dragging
        "SUPER, mouse:272, movewindow"

        # Laptop multimedia keys for volume and LCD brightness
        ",XF86AudioRaiseVolume, exec, ${pkgs.pulseaudio}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, ${pkgs.pulseaudio}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, ${pkgs.pulseaudio}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, ${pkgs.pulseaudio}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl s 10%-"
      ];
    };
  };

  # Home-managed hypr files (raw files as requested)
  home.file = {
    ".config/hypr/scripts/wallpaper_changer.sh" = {
      executable = true;
      source = ./files/scripts/wallpaper_changer.sh;
    };
    ".config/hypr/scripts/toggle-monitors.sh" = {
      executable = true;
      source = ./files/scripts/toggle-monitors.sh;
    };
    ".config/hypr/scripts/focus-toggle.sh" = {
      executable = true;
      source = ./files/scripts/focus-toggle.sh;
    };
    ".config/hypr/scripts/aio-fuzzel.sh" = {
      executable = true;
      source = ./files/scripts/aio-fuzzel.sh;
    };
    ".config/hypr/scripts/dashlane-fuzzel.sh" = {
      executable = true;
      source = ./files/scripts/dashlane-fuzzel.sh;
    };

    # Wallpapers directory (copy whole directory from flake files)
    ".config/hypr/wallpapers".source = ./files/wallpapers;

    # Theme settings (since gsettings are not direct Hyprland options)
    ".config/hypr/themes/theme.conf".text = ''
      exec = gsettings set org.gnome.desktop.interface icon-theme 'Gruvbox-Plus-Dark'
      exec = gsettings set org.gnome.desktop.interface gtk-theme 'Gruvbox-Dark'
      exec = gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    '';

    ".config/fastfetch/config.jsonc".source = ./files/fastfetch/config.jsonc;
    ".config/fastfetch/animal".source = ./files/fastfetch/animal;
  };

  # Ensure user environment has the necessary hypr tooling available
  home.packages = with pkgs; [
    hyprpaper # For wallpaper management
    #hyprctl # For scripts to interact with Hyprland
    jq # For scripts to parse hyprctl JSON output
    wl-clipboard # For clipboard functionality
    cliphist # For clipboard history
    hyprshot # For screenshots
    wlogout # For logout menu
    swaynotificationcenter # For notifications
    fuzzel # For application launcher
    brightnessctl # For brightness control
    pulseaudio # For volume control (wpctl is part of it)
    polkit_gnome # For authentication dialogs
  ];
}
