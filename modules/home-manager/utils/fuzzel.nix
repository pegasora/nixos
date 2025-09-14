{ config, pkgs, ... }:

{
  home.file.".config/fuzzel/fuzzel.ini".text = ''
[main]
font = Comic Code Ligatures:size=12
prompt = "> "
icons = show
terminal = kitty
launch-prefix = sh -c

[colors]
background = 1E1E2EFF
text = CDD6F4FF
match = F38BA8FF
selection = 45475AFF
selection-text = CDD6F4FF
border = 313244FF
'';
}
