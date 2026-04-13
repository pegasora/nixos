{
  programs.kitty = {
    enable = true;
    font = {
      # name managed by stylix.fonts — see modules/nixos/stylix.nix
      # name = "Comic Code Ligatures";
      size = 12;
    };
    # theme managed by stylix — see modules/nixos/stylix.nix
    # theme = "Kanagawa";
    shellIntegration.enableFishIntegration = true;
    settings = {
      # extra kitty font settings
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      # magic settings
      cursor_trail = 13;
      cursor_trail_start_threshold = 0;
      cusror_trail_decay = "0.01 0.05";
      cursor_shape = "block";
    };
  };
}
