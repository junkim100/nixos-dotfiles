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
    ./rofi
    ./firefox
    ./thunderbird
    ./Code
    ./zathura

    # CLI
    ./git
    ./bat
    ./zsh
    ./starship
  ];
}
