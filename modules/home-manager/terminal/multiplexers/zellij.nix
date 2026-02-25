{
  lib,
  pkgs,
  ...
}: {
  programs.zellij = {
    enable = true;
    #enableFishIntegration = true;

    settings = {
      # Basic settings
      default_shell = lib.getExe pkgs.fish;
      theme = "kanagawa";

      # UI settings
      pane_frames = false;
      mouse_mode = true;
      copy_on_select = false;
      scrollback_editor = lib.getExe pkgs.neovim;

      # Behavior
      on_force_close = "detach";
      simplified_ui = true;
      default_mode = "normal";

      # Copy settings
      copy_command = "wl-copy";
      copy_clipboard = "primary";
    };
  };
}
