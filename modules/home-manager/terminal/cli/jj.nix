{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "pegasora";
        email = "dawsonhburgess@gmail.com";
      };
      ui = {
        default-command = "log";
        paginate = "never";
        editor = "nvim";
      };
    };
  };
}
