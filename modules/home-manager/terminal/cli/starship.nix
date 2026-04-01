{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    #enableNushellIntegration = true;
    settings = {
      # palette managed by stylix (set to "base16") — see modules/nixos/stylix.nix
      # palette = "kanagawa_wave";
      right_format = lib.concatStrings [
        "$cmd_duration"
        "$time"
        "$shell"
        "$os"
      ];
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$localip"
        "$shlvl"
        "$singularity"
        "$kubernetes"
        "$directory"
        "$vcsh"
        "$fossil_branch"
        "$fossil_metrics"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_metrics"
        "$git_status"
        "$hg_branch"
        "$pijul_channel"
        "$docker_context"
        "$package"
        "$c"
        "$cmake"
        "$elixir"
        "$elm"
        "$erlang"
        "$golang"
        "$guix_shell"
        "$helm"
        "$java"
        "$julia"
        "$lua"
        "$ocaml"
        "$perl"
        "$php"
        "$python"
        "$nix_shell"
        "$rust"
        "$swift"
        "$terraform"
        "$zig"
        "$conda"
        "$meson"
        "$aws"
        "$gcloud"
        "$azure"
        "$direnv"
        "$env_var"
        "$custom"
        "$sudo"
        "$line_break"
        "$jobs"
        "$status"
        "$container"
        "$character"
      ];
      add_newline = true;
      username = {
        show_always = true;
        disabled = false;
      };
      os = {
        disabled = false; # Disabled by default
      };

      directory.substitutions = {
        Documents = "󰈙 ";
        Downloads = " ";
        Music = " ";
        Pictures = " ";
      };
      character = {
        success_symbol = "[➜](bold green)"; # The 'success_symbol' segment is being set to '➜' with the color 'bold green'
        error_symbol = "[✗](bold red)";
      };

      package.disabled = false;

      time = {
        disabled = false;
        time_format = "%R"; # Hour:Minute Format
      };
      cmd_duration = {
        min_time = 500;
      };

      os.symbols = {
        Arch = " ";
        Debian = " ";
        Fedora = " ";
        Kali = " ";
        Linux = " ";
        Macos = " ";
        Pop = " ";
        Raspbian = " ";
        Ubuntu = " ";
        Unknown = " ";
      };

      palettes.catppuccin_mocha = {
        rosewater = "#f5e0dc";
        flamingo = "#f2cdcd";
        pink = "#f5c2e7";
        mauve = "#cba6f7";
        red = "#f38ba8";
        maroon = "#eba0ac";
        peach = "#fab387";
        yellow = "#f9e2af";
        green = "#a6e3a1";
        teal = "#94e2d5";
        sky = "#89dceb";
        sapphire = "#74c7ec";
        blue = "#89b4fa";
        lavender = "#b4befe";
        text = "#cdd6f4";
        subtext1 = "#bac2de";
        subtext0 = "#a6adc8";
        overlay2 = "#9399b2";
        overlay1 = "#7f849c";
        overlay0 = "#6c7086";
        surface2 = "#585b70";
        surface1 = "#45475a";
        surface0 = "#313244";
        base = "#1e1e2e";
        mantle = "#181825";
        crust = "#11111b";
      };
      palettes.kanagawa_wave = {
        rosewater = "#938AA9";
        flamingo = "#957FB8";
        pink = "#938056";
        mauve = "#957FB8";
        red = "#C34043";
        maroon = "#E46876";
        peach = "#FFA066";
        yellow = "#DCA561";
        green = "#76946A";
        teal = "#6A9589";
        sky = "#7FB4CA";
        sapphire = "#7E9CD8";
        blue = "#7AA89F";
        lavender = "#938AA9";
        text = "#DCD7BA";
        subtext1 = "#C8C093";
        subtext0 = "#A6A69C";
        overlay2 = "#8A9A7B";
        overlay1 = "#727169";
        overlay0 = "#626462";
        surface2 = "#54546D";
        surface1 = "#363646";
        surface0 = "#2A2A37";

        base = "#1F1F28";
        mantle = "#16161D";
        crust = "#0D0C0C";
      };
      palettes.kanagawa_dragon = {
        rosewater = "#c5c9c5";
        flamingo = "#a292a3";
        pink = "#a292a3";
        mauve = "#8992a7";
        red = "#c4746e";
        maroon = "#c4746e";
        peach = "#b6927b";
        yellow = "#c4b28a";
        green = "#8a9a7b";
        teal = "#8ea4a2";
        sky = "#8ba4b0";
        sapphire = "#658594";
        blue = "#658594";
        lavender = "#938aa9";
        text = "#c5c9c5";
        subtext1 = "#b4b8b4";
        subtext0 = "#9ca0a0";
        overlay2 = "#8a8f8f";
        overlay1 = "#727169";
        overlay0 = "#626462";
        surface2 = "#545464";
        surface1 = "#3c3c4f";
        surface0 = "#2d2d44";
        base = "#181820";
        mantle = "#0f0f17";
        crust = "#0d0c0c";
      };
    };
  };
}
