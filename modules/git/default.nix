{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "junkim100";
    userEmail = "junkim100@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };
}
