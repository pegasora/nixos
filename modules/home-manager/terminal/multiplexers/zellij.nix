{
  lib,
  pkgs,
  ...
}:
{
  programs.zellij = {
    enable = true;
    #enableFishIntegration = true;
    settings = {
      default_shell = lib.getExe pkgs.nushell;
      theme = "catppuccin-mocha";
      show_startup_tips = false;
    };
  };
}
