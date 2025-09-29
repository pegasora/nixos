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
    };
  };
}
