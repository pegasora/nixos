{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # system
    curl
    wget
    cmake
    go
    gcc
    nodejs
    unzip
    python3
    home-manager
    exfat
    tailscale
    nmap

    # git
    git
    gh
    lazygit

    # shell
    fzf
    eza
    bat
    fastfetch
    zoxide
    zellij
    uv
    opencode
    starship
    nixfmt-rfc-style
    nixd
    yazi

    # neovim
    inputs.nvf-flake.packages.${pkgs.system}.default
    neovim
    ripgrep
    gnumake
    ruff
    lua-language-server
  ];

  environment.localBinInPath = true;
}
