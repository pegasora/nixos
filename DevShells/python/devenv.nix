{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  cachix.enable = false;

  env.GREET = "devenv";

  packages = with pkgs; [
    jq
  ];

  enterShell = ''
    echo "Entering dev shell"
    fastfetch
    starship init fish | source
  '';

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';
}
