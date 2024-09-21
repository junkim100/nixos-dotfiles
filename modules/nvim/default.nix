{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set number
      set relativenumber
      set expandtab
      set tabstop=2
      set softtabstop=2
      set shiftwidth=2
      set smartindent
      set wrap
      set linebreak
      set ignorecase
      set smartcase
      set clipboard+=unnamedplus
    '';
    plugins = with pkgs.vimPlugins; [
      vim-nix
      vim-surround
      vim-commentary
      # Add more plugins as needed
    ];
  };
}

