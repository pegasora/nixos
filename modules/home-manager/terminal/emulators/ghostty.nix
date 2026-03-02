{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;

    themes = {
      kanagawa-wave = {
        background = "16161d"; # sumiInk0
        foreground = "dcd7ba"; # fujiWhite
        cursor-color = "c8c093"; # oldWhite / soft cursor
        selection-background = "2d4f67"; # subtle selection bg (common in kanagawa ports)
        selection-foreground = "c8c093";

        palette = [
          "0=#16161d" # sumiInk0 / very dark bg
          "1=#c34043" # autumnRed / bright red
          "2=#76946a" # autumnGreen
          "3=#c4b28a" # -> adjusted to carpYellow-ish #e6c384 but standard is often softer
          "4=#7e9cd8" # crystalBlue
          "5=#957fb8" # oniViolet
          "6=#7aa89f" # waveAqua2
          "7=#c8c093" # oldWhite
          "8=#54546d" # sumiInk4 / dark gray
          "9=#e46876" # waveRed
          "10=#98bb6c" # springGreen
          "11=#e6c384" # carpYellow
          "12=#7fb4ca" # lighter blue (springBlue / common accent)
          "13=#938aa9" # violet-gray
          "14=#6a9589" # waveAqua1
          "15=#c5c9c5" # light fg variant
        ];
      };
    };

    settings = {
      theme = "kanagawa-wave";
      font-family = "Comic Code Ligatures";
      window-decoration = false;
      mouse-hide-while-typing = true;
      confirm-close-surface = false;
      font-size = 12;
      cursor-style = "block";
      cursor-style-blink = true;
    };
  };
}
# Old Catppuccin Mocha theme (commented out)
# themes = {
#   catppuccin-mocha = {
#     background = "1e1e2e";
#     cursor-color = "f5e0dc";
#     foreground = "cdd6f4";
#     palette = [
#       "0=#45475a"
#       "1=#f38ba8"
#       "2=#a6e3a1"
#       "3=#f9e2af"
#       "4=#89b4fa"
#       "5=#f5c2e7"
#       "6=#94e2d5"
#       "7=#bac2de"
#       "8=#585b70"
#       "9=#f38ba8"
#       "10=#a6e3a1"
#       "11=#f9e2af"
#       "12=#89b4fa"
#       "13=#f5c2e7"
#       "14=#94e2d5"
#       "15=#a6adc8"
#     ];
#     selection-background = "353749";
#     selection-foreground = "cdd6f4";
#   };
# };
# settings = {
#   theme = "catppuccin-mocha";
#   # ... rest unchanged
# };

