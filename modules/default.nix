{
  inputs,
  pkgs,
  config,
  ...
}: {
  home.stateVersion = "23.11";
  imports = [
    # GUI
    ./kitty
    #./firefox
    ./Code
    ./zathura

    # CLI
    ./git
    ./bat
    ./zsh
    ./starship
  ];
}
