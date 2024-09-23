{...}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    oh-my-zsh.enable = false;
    shellAliases = {
      ll = "ls -al";
      nixos = ''
      if [ -d "/etc/nixos/" ]; then
            cd /etc/nixos/
      else
            echo "Can't find /etc/nixos/"
      fi'';
      dotfiles = ''
        if [ -d "$HOME/nixos-dotfiles/" ]; then
            cd $HOME/nixos-dotfiles/
        else
            echo "Can't find dotfiles directory"
        fi'';
    };
  };
}
