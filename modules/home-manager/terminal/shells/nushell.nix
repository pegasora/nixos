{
  programs.nushell = {
    enable = true;
    shellAliases = {
      lg = "lazygit";
      c = "clear";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      "......" = "cd ../../../../..";
      ll = "eza -lha --icons=auto --sort=name --group-directories-first";
      lt = "eza -a --icons=auto --tree -I \".git\"";
      l = "eza -1a --icons=auto --sort=name --group-directories-first";
      zat = "zathura";
      z = "zellij";
      xdg-open = "xdg-open";
    };
    extraConfig = ''
      # Run fastfetch on shell startup
      fastfetch

      # Set TERM environment variable
      $env.TERM = "xterm-256color"

      # Add spicetify to PATH
      $env.PATH = ($env.PATH | prepend "~/.spicetify")

      # Yazi function for directory navigation
      def y [...args] {
        let tmp = (mktemp -t "yazi-cwd.XXXXXX")
        yazi $args --cwd-file=$tmp
        let cwd = (open --raw $tmp)
        if ($cwd | is-not-empty) and ($cwd != $env.PWD) {
          cd $cwd
        }
        rm -f $tmp
      }

    '';
  };
}
