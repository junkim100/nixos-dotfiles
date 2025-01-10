{
  config,
  pkgs,
  ...
}: {
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

      # General productivity
      ms-vscode-remote.remote-ssh

      # Themes and icons
      arcticicestudio.nord-visual-studio-code
      pkief.material-icon-theme

      # Misc
      esbenp.prettier-vscode
      redhat.vscode-yaml
      bbenoist.nix
    ];
    userSettings = {
      "editor.formatOnSave" = true;
      "python.formatting.provider" = "black";
      "python.linting.flake8Enabled" = true;
      "python.linting.pylintEnabled" = false;
      "jupyter.alwaysTrustNotebooks" = true;
      "workbench.colorTheme" = "Nord";
      "jupyter.askForKernelRestart" = false;
      "notebook.lineNumbers" = "on";
      "terminal.integrated.enableMultiLinePasteWarning" = false;
      "editor.minimap.showSlider" = "always";
      "editor.defaultFormatter" = "ms-python.black-formatter";
      "[json]" = {
        "editor.defaultFormatter" = "vscode.json-language-features";
      };
    };
  };
}
