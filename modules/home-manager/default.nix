{
  imports = [
    ./cli
    ./wm
    ./utils
  ];

  programs.librewolf.settings = {
    "webgl.disabled" = false;
    "privacy.resistFingerprinting" = false;
  };
}
