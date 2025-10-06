{
  config,
  pkgs,
  lib,
  ...
}: let
  twosHash = "sha256-xOE6CJljX4wphyIiqeTYa15eBqVKosyNaCwycBXdv2E="; # Corrected hash

  twosAppImage = pkgs.fetchurl {
    url = "https://twos.s3.us-west-2.amazonaws.com/mac/Twos-7.5.0.AppImage";
    sha256 = twosHash;
  };
in {
  home.packages = [
    pkgs.appimage-run
    pkgs.desktop-file-utils # For update-desktop-database
  ];

  home.file.".local/bin/twos.AppImage".source = twosAppImage;

  # Wrapper script with explicit executable flag
  home.file.".local/bin/twos-launcher".text = ''
    #!/bin/sh
    exec appimage-run "$HOME/.local/bin/twos.AppImage" "$@"
  '';
  home.file.".local/bin/twos-launcher".executable = true;

  home.file.".local/share/applications/twos.desktop".text = ''
    [Desktop Entry]
    Version=1.0
    Type=Application
    Name=Twos
    Comment=Twos App for Productivity
    Exec=$HOME/.local/bin/twos-launcher %U
    Icon=twos
    Categories=Office;Productivity;
    StartupNotify=true
    Terminal=false
  '';
}
