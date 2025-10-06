{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
  ];

  home.username = "zues";
  home.homeDirectory = "/home/zues";
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = [
    pkgs.adwaita-icon-theme
    (pkgs.nerd-fonts.jetbrains-mono)
    (pkgs.nerd-fonts.symbols-only)
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  fonts.fontconfig.enable = true;

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
