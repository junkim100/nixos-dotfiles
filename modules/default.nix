{ inputs, pkgs, config, ... }:

{
    home.stateVersion = "23.11";
    imports = [
        ./kitty

        # gui
        #./firefox
        ./Code

        # cli
	./git
        #./nvim
        ./zsh
    ];
}
