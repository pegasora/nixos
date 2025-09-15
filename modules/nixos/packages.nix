{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
     # system
     curl 
     wget
     blueman # services.blueman.enable = true; in home-manager
     brightnessctl
     cmake
     go
     gcc
     #gruvbox-plus-icons
     kanata
     networkmanager
     networkmanagerapplet
     nodejs
     libnotify
     unzip 
     stow
     python3
     home-manager
     xwayland-satellite
     kdePackages.dolphin

     # applications
     obsidian
     btop
     pcmanfm
     firefox
     onlyoffice-bin
     swaybg
     ydotool
     polkit_gnome
     gparted
     woeusb

     # wayland / hyprland
     cliphist
     hyprland
     hyprlock
     hyprpaper
     hyprshot 
     waybar # configure in hm 
     swaynotificationcenter    
     wlogout

     # git 
     git
     gh
     lazygit

     # shell
     fuzzel
     alacritty
     fzf
     eza
     bat
     fastfetch
     zoxide
     tmux
     uv
     opencode
     starship

     # neovim
     neovim
     ripgrep
     gnumake
     ruff
      kitty
      (pkgs.catppuccin-sddm.override { flavor = "mocha"; })
   ];

  environment.localBinInPath = true;

}
