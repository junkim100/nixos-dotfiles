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
      dotfiles = ''
        if [ -d "$HOME/dotfiles" ]; then
            cd $HOME/dotfiles
        else
            echo "Can't find dotfiles directory"
        fi'';
    };
  };
}
