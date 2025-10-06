{config, ...}: let
  a = config.lib.niri.actions;
in {
  programs.niri = {
    enable = true;
    settings = {
      input = {
        touchpad = {
          tap = true;
          natural-scroll = true;
          scroll-method = "two-finger";
        };
        mouse = {
          natural-scroll = true;
        };
        trackpoint.enable = false;
        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "0%";
        };
        warp-mouse-to-focus.enable = true;
      };
      outputs = {
        "DP-10" = {
          enable = true;
          position.x = 0;
          position.y = 0;
        };
        "DP-11" = {
          enable = true;
          position.x = 2560;
          position.y = 0;
          transform.rotation = 90;
        };
        "DP-4" = {
          enable = true;
          position.x = 0;
          position.y = 0;
        };
        "DP-2" = {
          enable = true;
          position.x = 2560;
          position.y = 0;
          transform.rotation = 270;
        };
        "DP-12" = {
          enable = true;
          position.x = 0;
          position.y = 0;
        };
        "DP-13" = {
          enable = true;
          position.x = 2560;
          position.y = 0;
          transform.rotation = 90;
        };
      };
      layout = {
        gaps = 3;
        #always-center-single-column = true;
        center-focused-column = "never";
        preset-column-widths = [
          {proportion = 1. / 4.;} # 0.25
          {proportion = 1. / 3.;} # 0.33333
          {proportion = 1. / 2.;} # 0.5
          {proportion = 2. / 3.;} # 0.66667
          {proportion = 3. / 4.;} # 0.75
          {proportion = 9. / 10.;} # 1.0
        ];
        #default-column-width = {proportion = 0.5;};
        focus-ring = {
          width = 2;
          active.color = "#7fc8ff";
          inactive.color = "#505050";
        };
        #border = {
        #  enable = true;
        #  width = 4;
        #  active.color = "#ffc87f";
        #  inactive.color = "#505050";
        #  urgent.color = "#9b0000";
        #};
      };
      spawn-at-startup = [
        {argv = ["waybar"];}
        {argv = ["swaync"];}
        {argv = ["ydotoold"];}
        {argv = ["swaybg" "--image" "/home/pegasora/nixos/wallpapers/curves.jpg"];}
        #{sh = ["sawybg -i \"$(find ~/.config/niri/wallpapers/ -type f | shuf -n 1)\" &"];}
      ];

      window-rules = [
        {
          default-column-width.proportion = 1.;
          matches = [{app-id = "ghostty";}];
        }
      ];
      binds = {
        # programs n such
        "super+Space".action.spawn = "fuzzel";
        "super+t".action.spawn = "ghostty";
        #"super+shift+l".action.spawn = "hyprlock";
        "super+e".action.spawn = "dolphin";
        "super+p".action.spawn = "wlogout";
        "super+o".action.spawn = "obsidian";
        #"super+f".action.spawn = "firefox";
        "super+f".action.spawn = "brave";
        #"super+n".action.spawn = "sh" "-c" "swaync-client -t -sw";
        #"super+v".action.spawn = "sh" "-c" "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy";

        # close apps
        "super+q".action = a.close-window;

        # nav
        "super+h".action = a.focus-column-left;
        "super+j".action = a.focus-window-down;
        "super+k".action = a.focus-window-up;
        "super+l".action = a.focus-column-right;
        "super+ctrl+h".action = a.move-column-left;
        "super+ctrl+j".action = a.move-window-down;
        "super+ctrl+k".action = a.move-window-up;
        "super+ctrl+l".action = a.move-column-right;

        # special buttons
        "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+"];
        "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-"];
        "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
        "XF86AudioMicMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];
        "XF86MonBrightnessUp".action.spawn = ["brightnessctl" "s" "10%+"];
        "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "s" "10%-"];

        "super+shift+h".action = a.focus-monitor-left;
        "super+shift+j".action = a.focus-monitor-down;
        "super+shift+k".action = a.focus-monitor-up;
        "super+shift+l".action = a.focus-monitor-right;

        "super+d".action = a.focus-workspace-down;
        "super+u".action = a.focus-workspace-up;

        # workspaces
        "super+1".action = a.focus-workspace 1;
        "super+2".action = a.focus-workspace 2;
        "super+3".action = a.focus-workspace 3;
        "super+4".action = a.focus-workspace 4;
        "super+5".action = a.focus-workspace 5;
        "super+6".action = a.focus-workspace 6;
        "super+7".action = a.focus-workspace 7;
        "super+8".action = a.focus-workspace 8;
        "super+9".action = a.focus-workspace 9;
        #"super+shift+1".action = a.move-column-to-workspace 1;
        #"super+shift+2".action = a.move-column-to-workspace 2;
        #"super+shift+3".action = a.move-column-to-workspace 3;
        #"super+shift+4".action = a.move-column-to-workspace 4;
        #"super+shift+5".action = a.move-column-to-workspace 5;
        #"super+shift+6".action = a.move-column-to-workspace 6;
        #"super+shift+7".action = a.move-column-to-workspace 7;
        #"super+shift+8".action = a.move-column-to-workspace 8;
        #"super+shift+9".action = a.move-column-to-workspace 9;

        "super+bracketleft".action = a.consume-or-expel-window-left;
        "super+bracketright".action = a.consume-or-expel-window-right;

        "super+ctrl+f".action = a.expand-column-to-available-width;

        "super+minus".action = a.set-column-width "-10%";
        "super+equal".action = a.set-column-width "+10%";

        "super+shift+w".action = a.toggle-window-floating;

        "super+s".action = a.screenshot-window;
        "super+shift+s".action = a.screenshot;
      };
    };
  };
}
