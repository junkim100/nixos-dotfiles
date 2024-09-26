{
  inputs,
  pkgs,
  config,
  ...
}: {
  home.stateVersion = "23.11";
  imports = [
    ./kitty

    # gui
    #./firefox
    ./Code
    ./zathura

    # cli
    ./git
    ./bat
    ./zsh
    ./starship
  ];
}
