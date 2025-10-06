{
  config,
  pkgs,
  ...
}: {
  programs.fish = {
    enable = true;
    plugins = [];
    shellAliases = {
      vi = "nvim";
      vim = "nvim";
      zz = "zellij";
      #t = "tmux";
      fishrc = "vim ~/.config/fish/config.fish";
      open = "xdg-open";
      pull_all = "ls ; ls | xargs -I{} git -C {} pull";
      status_all = "ls ; ls | xargs -I{} git -C {} status";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      "......" = "cd ../../../../..";
      c = "clear";
      fzfbat = "fzf --preview=\"bat --color=always {}\"";
      visearch = "nvim (fzf -m --preview=\"bat --color=always {}\")";
      ll = "eza -lha --icons=auto --sort=name --group-directories-first";
      lt = "eza -a --icons=auto --tree -I \".git\"";
      l = "eza -1a --icons=auto --sort=name --group-directories-first";
      zat = "zathura";
      mkdir = "mkdir -p";
      cp = "cp -i";
      mv = "mv -i";
    };
    functions = {
      y = ''
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        set cwd (cat -- "$tmp")
        if test -n "$cwd" -a "$cwd" != "$PWD"
            cd -- "$cwd"
        end
        rm -f -- "$tmp"
      '';
    };
    interactiveShellInit = ''
      fastfetch
      starship init fish | source
      # enable_transience  # commented out as not available in this fish version
      zoxide init --cmd cd fish | source
      uv generate-shell-completion fish | source
      set -gx TERM xterm-256color
      fish_add_path ~/.spicetify
      # fish_config theme choose "Catppuccin Mocha"  # requires catppuccin/fish plugin
      # fzf_configure_bindings --directory=\cf  # requires fzf.fish plugin
    '';
    shellInit = ''
      set -g fish_history_size 5000
      set -g fish_history_ignore_space
    '';
  };

  home.sessionVariables = {
    FZF_DEFAULT_OPTS = "--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 --color=selected-bg:#45475A --color=border:#313244,label:#CDD6F4";
  };
}
