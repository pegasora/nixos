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
      z = "zellij";
      #t = "tmux";
      #fishrc = "vim ~/.config/fish/config.fish";
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
      tv = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
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
      # starship init fish | source
      # enable_transience # commented out as not available in this fish version
      zoxide init --cmd cd fish | source
      #uv generate-shell-completion fish | source
      set -gx TERM xterm-256color
      fish_add_path ~/.spicetify
      # fish_config theme choose "Kanagawa Wave"  # if you install catppuccin/fish or similar
      # fzf_configure_bindings --directory=\cf   # requires fzf.fish plugin
    '';
    shellInit = ''
      set -g fish_history_size 5000
      set -g fish_history_ignore_space

      # ────────────────────────────────────────────────
      # Kanagawa Wave Fish shell theme
      # ────────────────────────────────────────────────
      set -l foreground DCD7BA normal
      set -l selection    2D4F67 brcyan
      set -l comment      727169 brblack
      set -l red          C34043 red
      set -l orange       FF9E64 brred
      set -l yellow       E6C384 yellow
      set -l green        76946A green
      set -l purple       957FB8 magenta
      set -l cyan         7AA89F cyan
      set -l pink         D27E99 brmagenta

      # Syntax Highlighting Colors
      set -g fish_color_normal          $foreground
      set -g fish_color_command         $cyan
      set -g fish_color_keyword         $pink
      set -g fish_color_quote           $yellow
      set -g fish_color_redirection     $foreground
      set -g fish_color_end             $orange
      set -g fish_color_error           $red
      set -g fish_color_param           $purple
      set -g fish_color_comment         $comment
      set -g fish_color_selection       --background=$selection
      set -g fish_color_search_match    --background=$selection
      set -g fish_color_operator        $green
      set -g fish_color_escape          $pink
      set -g fish_color_autosuggestion  $comment

      # Completion Pager Colors
      set -g fish_pager_color_progress      $comment
      set -g fish_pager_color_prefix        $cyan
      set -g fish_pager_color_completion    $foreground
      set -g fish_pager_color_description   $comment
    '';
  };

  home.sessionVariables = {
    FZF_DEFAULT_OPTS =
      "--color=bg+:#2a2a37,bg:#16161d,spinner:#e6c384,hl:#e46876 "
      + "--color=fg:#dcd7ba,header:#e46876,info:#957fb8,pointer:#ffa066 "
      + "--color=marker:#ffa066,fg+:#dcd7ba,prompt:#957fb8,hl+:#e46876 "
      + "--color=selected-bg:#54546d --color=border:#2a2a37,label:#dcd7ba";
  };
}
#{
#  config,
#  pkgs,
#  ...
#}: {
#  programs.fish = {
#    enable = true;
#    plugins = [];
#    shellAliases = {
#      vi = "nvim";
#      vim = "nvim";
#      z = "zellij";
#      #t = "tmux";
#      #fishrc = "vim ~/.config/fish/config.fish";
#      open = "xdg-open";
#      pull_all = "ls ; ls | xargs -I{} git -C {} pull";
#      status_all = "ls ; ls | xargs -I{} git -C {} status";
#      ".." = "cd ..";
#      "..." = "cd ../..";
#      "...." = "cd ../../..";
#      "....." = "cd ../../../..";
#      "......" = "cd ../../../../..";
#      c = "clear";
#      fzfbat = "fzf --preview=\"bat --color=always {}\"";
#      visearch = "nvim (fzf -m --preview=\"bat --color=always {}\")";
#      ll = "eza -lha --icons=auto --sort=name --group-directories-first";
#      lt = "eza -a --icons=auto --tree -I \".git\"";
#      l = "eza -1a --icons=auto --sort=name --group-directories-first";
#      zat = "zathura";
#      mkdir = "mkdir -p";
#      cp = "cp -i";
#      mv = "mv -i";
#      tv = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
#    };
#    functions = {
#      y = ''
#        set tmp (mktemp -t "yazi-cwd.XXXXXX")
#        yazi $argv --cwd-file="$tmp"
#        set cwd (cat -- "$tmp")
#        if test -n "$cwd" -a "$cwd" != "$PWD"
#            cd -- "$cwd"
#        end
#        rm -f -- "$tmp"
#      '';
#    };
#    interactiveShellInit = ''
#      fastfetch
#      # starship init fish | source
#      # enable_transience  # commented out as not available in this fish version
#      zoxide init --cmd cd fish | source
#      #uv generate-shell-completion fish | source
#      set -gx TERM xterm-256color
#      fish_add_path ~/.spicetify
#      # fish_config theme choose "Catppuccin Mocha"  # requires catppuccin/fish plugin
#      # fzf_configure_bindings --directory=\cf  # requires fzf.fish plugin
#    '';
#    shellInit = ''
#      set -g fish_history_size 5000
#      set -g fish_history_ignore_space
#    '';
#  };
#
#  home.sessionVariables = {
#    FZF_DEFAULT_OPTS = "--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 --color=selected-bg:#45475A --color=border:#313244,label:#CDD6F4";
#  };
#}

