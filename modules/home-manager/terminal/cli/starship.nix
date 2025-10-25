{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    #enableNushellIntegration = true;
    settings = {
      palette = "catppuccin_mocha";
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
    };
  };
}
