{ config, lib, pkgs, ... }:

{

  programs.waybar = {
	enable = true;
	style = ''
@define-color base #1e1e2e;
@define-color mantle #181825;
@define-color crust #11111b;

@define-color text #cdd6f4;
@define-color subtext0 #a6adc8;
@define-color subtext1 #bac2de;

@define-color surface0 #313244;
@define-color surface1 #45475a;
@define-color surface2 #585b70;

@define-color overlay0 #6c7086;
@define-color overlay1 #7f849c;
@define-color overlay2 #9399b2;

@define-color blue #89b4fa;
@define-color lavender #b4befe;
@define-color sapphire #74c7ec;
@define-color sky #89dceb;
@define-color teal #94e2d5;
@define-color green #a6e3a1;
@define-color yellow #f9e2af;
@define-color peach #fab387;
@define-color maroon #eba0ac;
@define-color red #f38ba8;
@define-color mauve #cba6f7;
@define-color pink #f5c2e7;
@define-color flamingo #f2cdcd;
@define-color rosewater #f5e0dc;

* {
  font-family: "Comic Code", "JetBrainsMonoNerdFont";
  font-size: 17px;
  min-height: 0;
}

#waybar {
  background: @base;
  color: @text;
  margin: 5px 5px;
}

#workspaces {
  border-radius: 1rem;
  margin: 5px;
  background-color: @surface0;
  margin-left: 1rem;
}


#window {
  border-radius: 1rem;
  margin: 5px;
  background-color: @surface0;
  margin-left: 1rem;
}

#workspaces button {
  color: @lavender;
  border-radius: 1rem;
  padding: 0.4rem;
}

#workspaces button.active {
  color: @sky;
  border-radius: 1rem;
}

#workspaces button:hover {
  color: @sapphire;
  border-radius: 1rem;
}

#custom-music,
#tray,
#backlight,
#clock,
#battery,
#pulseaudio,
#network,
#custom-lock,
#custom-power {
  background-color: @surface0;
  padding: 0.5rem 1rem;
  margin: 5px 0;
}

#clock {
  color: @blue;
  border-radius: 0px 1rem 1rem 0px;
  margin-right: 1rem;
}

#battery {
  color: @green;
}

#battery.charging {
  color: @green;
}

#battery.warning:not(.charging) {
  color: @red;
}

#network {
  color: @pink;
}

#backlight {
  color: @yellow;
}

#backlight,
#battery {
  border-radius: 0;
}

#pulseaudio {
  color: @maroon;
  border-radius: 1rem 0px 0px 1rem;
  margin-left: 1rem;
}

#custom-music {
  color: @mauve;
  border-radius: 1rem;
}

#custom-lock {
  border-radius: 1rem 0px 0px 1rem;
  color: @lavender;
}

#custom-power {
  margin-right: 1rem;
  border-radius: 0px 1rem 1rem 0px;
  color: @red;
}

#tray {
  margin-right: 1rem;
  border-radius: 1rem;
}
	'';
	settings = {
	mainbar = {
          layer = "top";
          position = "top";
          height = 30;
          modules-left = ["custom/logo" "hyprland/workspaces"];
          modules-right = ["pulseaudio" "network" "backlight" "battery" "clock" "tray" "custom/lock" "custom/power"];

          "hyprland/workspaces" = {
            disable-scroll = true;
            sort-by-name = true;
            format = " {icon} ";
            "format-icons" = {
              "default" = "";
            };
          };

          tray = {
            "icon-size" = 21;
            spacing = 10;
          };

          network = {
            interval = 5;
            "format-wifi" = "   {essid} ";
            "format-ethernet" = "  {ifname} ";
            "format-disconnected" = "No connection";
            tooltip = false;
          };

          "hyprland/window" = {
            format = "  {}  ";
            "max-length" = 30;
            tooltip = false;
          };

          clock = {
            format = "  | {:%I:%M}";
            "format-alt" = "{:%A, %B %d, %Y (%R) }";
            "tooltip-format" = "<tt><small>{calendar}</small></tt>";
            calendar = {
              mode = "year";
              "mode-mon-col" = 3;
              "weeks-pos" = "right";
              "on-scroll" = 1;
              format = {
                months = "<span color=\'#ffead3\'><b>{}</b></span>";
                days = "<span color=\'#ecc6d9\'><b>{}</b></span>";
                weeks = "<span color=\'#99ffdd\'><b>W{}</b></span>";
                weekdays = "<span color=\'#ffcc66\'><b>{}</b></span>";
                today = "<span color=\'#ff6699\'><b><u>{}</u></b></span>";
              };
            };
            actions = {
              "on-click-right" = "mode";
            };
          };

          backlight = {
            device = "intel_backlight";
            format = "{icon}";
            "format-icons" = ["" "" "" "" "" "" "" "" ""];
          };

          battery = {
            interval = 10;
            states = {
              warning = 30;
              critical = 15;
            };
            "format-time" = "{H}:{M:02}";
            format = "{icon}  {capacity}% ({time})";
            "format-charging" = " {capacity}% ({time})";
            "format-charging-full" = " {capacity}%";
            "format-full" = "{icon} {capacity}%";
            "format-alt" = "{icon} {power}W";
            "format-icons" = [
              ""
              ""
              ""
              ""
              ""
            ];
            tooltip = false;
          };

          pulseaudio = {
            format = "{icon} {volume}%";
            "format-muted" = "";
            "format-icons" = {
              "default" = ["" "" " "];
            };
            "scroll-step" = 1;
            "on-click" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
            "on-click-right" = "pavucontrol";
            tooltip = false;
          };

          "custom/lock" = {
            tooltip = false;
            "on-click" = "sh -c \'(sleep 0.5s; swaylock --grace 0)\' & disown";
            format = "";
          };

          "custom/power" = {
            tooltip = false;
            "on-click" = "wlogout &";
            format = "󰐥";
          };

          "custom/logo" = {
            format = "  󱄅";
          };
        };
      };
    };
}
