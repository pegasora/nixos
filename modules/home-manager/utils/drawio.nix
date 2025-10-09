{
  config,
  pkgs,
  lib,
  ...
}: let
  drawioHash = "sha256-ORoIdcol6zdyfw47iJd1FDsGDyHVj7fZz1FebZ5QXsU=";

  drawioAppImage = pkgs.fetchurl {
    url = "https://github.com/jgraph/drawio-desktop/releases/download/v28.2.5/drawio-x86_64-28.2.5.AppImage";
    sha256 = drawioHash;
  };
in {
  home.packages = [
    pkgs.appimage-run
    pkgs.desktop-file-utils # For update-desktop-database
  ];

  home.file.".local/bin/drawio-x86_64-28.2.5.AppImage".source = drawioAppImage;

  # Wrapper script with explicit executable flag
  home.file.".local/bin/drawio-launcher".text = ''
    #!/bin/sh
    exec appimage-run "$HOME/.local/bin/drawio-x86_64-28.2.5.AppImage" "$@"
  '';
  home.file.".local/bin/drawio-launcher".executable = true;

  home.file.".local/share/applications/drawio.desktop".text = ''
    [Desktop Entry]
    Version=1.0
    Type=Application
    Name=DrawIO
    Comment=DrawIO Desktop App
    Exec=$HOME/.local/bin/drawio-launcher %U
    Icon=Draw
    Categories=Diagrams;Design;
    StartupNotify=true
    Terminal=false
  '';
}
