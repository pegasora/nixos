{
  pkgs,
  inputs,
  ...
}: let
  comicCodeFont = pkgs.stdenv.mkDerivation {
    pname = "comiccode-font";
    version = "2025-09-13";
    src = inputs.comic-code;
    dontBuild = true;
    installPhase = ''
      mkdir -p "$out/share/fonts/truetype/Comic-Code"
      for f in "$src"/*.ttf; do
        [ -e "$f" ] || continue
        cp -v "$f" "$out/share/fonts/truetype/Comic-Code/"
      done
    '';
  };
in {
  imports = [inputs.stylix.nixosModules.stylix];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    polarity = "dark";
    fonts = {
      monospace = {
        package = comicCodeFont;
        name = "Comic Code Ligatures";
      };
      sansSerif = {
        package = comicCodeFont;
        name = "Comic Code Ligatures";
      };
      serif = {
        package = comicCodeFont;
        name = "Comic Code Ligatures";
      };
    };
  };
}
