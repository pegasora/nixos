{
  config,
  pkgs,
  lib,
  ...
}: let
  outlookHash = "sha256-Nk+8pCkVKWa/+JKOz3w6z0XfRIGZ8ckMQmyqUeHfY40=";

  outlookAppImage = pkgs.fetchurl {
    url = "https://github.com/mahmoudbahaa/outlook-for-linux/releases/download/v1.3.14-outlook/outlook-for-linux-1.3.14.AppImage";
    sha256 = outlookHash;
  };
in {
  home.packages = [
    pkgs.appimage-run
    pkgs.desktop-file-utils # For update-desktop-database
  ];

  home.file.".local/bin/outlook-for-linux.AppImage".source = outlookAppImage;

  # Wrapper script with explicit executable flag
  home.file.".local/bin/outlook-launcher".text = ''
    #!/bin/sh
    exec appimage-run "$HOME/.local/bin/outlook-for-linux.AppImage" "$@"
  '';
  home.file.".local/bin/outlook-launcher".executable = true;

  home.file.".local/share/applications/outlook-for-linux.desktop".text = ''
    [Desktop Entry]
    Version=1.0
    Type=Application
    Name=Outlook for Linux
    Comment=Microsoft Outlook for Linux
    Exec=$HOME/.local/bin/outlook-launcher %U
    Icon=mail
    Categories=Network;Email;
    StartupNotify=true
    Terminal=false
  '';
}
