{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      # Python
      ms-python.python
      ms-python.vscode-pylance
      ms-toolsai.jupyter
      ms-toolsai.jupyter-keymap
      ms-toolsai.jupyter-renderers
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.vscode-jupyter-slideshow

      # Formatting and linting
      ms-python.black-formatter
      ms-python.flake8
      ms-python.isort

      # GitHub Copilot
      github.copilot
      github.copilot-chat

      # General productivity
      vscodevim.vim
      eamodio.gitlens
      ms-vsliveshare.vsliveshare
      ms-vscode-remote.remote-ssh

      # Themes and icons
      pkief.material-icon-theme
      zhuangtongfa.material-theme

      # Misc
      ms-azuretools.vscode-docker
      redhat.vscode-yaml
      bbenoist.nix
    ];
    userSettings = {
      "editor.formatOnSave" = true;
      "python.formatting.provider" = "black";
      "python.linting.flake8Enabled" = true;
      "python.linting.pylintEnabled" = false;
      "jupyter.alwaysTrustNotebooks" = true;
    };
  };
}

