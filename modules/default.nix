{ inputs, pkgs, config, ... }:

{
    home.stateVersion = "23.11";
    imports = [
        # gui
        #./firefox
        ./vscode

        # cli
	./git
        #./nvim
        #./zsh
    ];
}
