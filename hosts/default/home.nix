{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    #cli
    ../../modules/home-manager/default.nix
    inputs.niri.homeModules.niri
  ];

  programs.niri.package = inputs.niri.packages.${pkgs.system}.niri-unstable.overrideAttrs (old: {
    doCheck = false;
  });
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "pegasora";
  home.homeDirectory = "/home/pegasora";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.kanshi
    pkgs.fastfetch
    pkgs.hyprcursor
    pkgs.adwaita-icon-theme
    (pkgs.nerd-fonts.jetbrains-mono)
    (pkgs.nerd-fonts.symbols-only)
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/pegasora/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  services.network-manager-applet.enable = true;
  services.udiskie = {
    enable = true;
    settings = {
      # workaround for
      # https://github.com/nix-community/home-manager/issues/632
      program_options = {
        # replace with your favorite file manager
        file_manager = "${pkgs.kdePackages.dolphin}/bin/dolphin";
      };
    };
  };

  fonts.fontconfig.enable = true;

  home.file.".config/kanshi/config".text = ''
    profile laptop-only {
    	output "eDP-1" enable mode 2256x1504@60.00 position 0,0 scale 1
    }

    profile dock {
    	# left external (EXT2) normal orientation
    	output "DVI-I-2" enable mode 2048x1150@50.00 position 0,0 scale 1

    	# right external (EXT1) rotated (transform 90)
    	output "DVI-I-1" enable transform 90 mode 2048x1150@50.00 position 2048,0 scale 1
    }

    profile school {
    	# when laptop panel remains connected, disable it and enable externals
    	output "eDP-1" disable
    	output "DVI-I-2" enable mode 2048x1080@59.46 position 0,0 scale 1
    	output "DVI-I-1" enable transform 270 mode 2048x1080@59.46 position 2048,0 scale 1
    }

    profile home-no-dock {
    #2560x1440@120.00
      output "eDP-1" disable
      output "DP-4" enable mode 2560x1440@120.00 position 0,0 scale 1
    }

    profile home-dock {
      output "eDP-1" disable
      output "DP-10" enable mode 2560x1440@120.00 position 0,0 scale 1
      output "DP-11" enable transform 90 mode 1920x1080@60.00 position 2560,0 scale 1
    }

    profile home-dock-2 {
      output "eDP-1" disable
      output "DP-12" enable mode 2560x1440@120.00 position 0,0 scale 1
      output "DP-13" enable transform 90 mode 1920x1080@60.00 position 2560,0 scale 1
    }
  '';

  ## ## ## ## ##
  ## PROGRAMS ##
  ## ## ## ## ##
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
  programs.git = {
    enable = true;
    userName = "pegasora";
    userEmail = "dawsonhburgess@gmail.com";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
