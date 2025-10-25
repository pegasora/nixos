{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "dawsonb";
        email = "pegasora@proton.me";
      };
      ui = {
        default-command = "log";
        paginate = "never";
        editor = "nvim";
      };
    };
  };
}
