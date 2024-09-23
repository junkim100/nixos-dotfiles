{ config, pkgs, color-palette, ... }:

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
      set termguicolors
      set background=dark
      colorscheme nord
    '';
    plugins = with pkgs.vimPlugins; [
      # Nord theme
      nord-nvim

      # Syntax highlighting
      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))

      # File explorer
      nvim-tree-lua

      # Status line
      lualine-nvim

      # Auto-completion
      nvim-cmp
      cmp-buffer
      cmp-path
      cmp-nvim-lsp

      # LSP
      nvim-lspconfig

      # Fuzzy finder
      telescope-nvim

      # Git integration
      vim-fugitive

      # Comment toggling
      comment-nvim

      # Autopairs
      nvim-autopairs
    ];
    extraPackages = with pkgs; [
      # Language servers
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      sumneko-lua-language-server
    ];
    extraLuaConfig = ''
      -- Nord color scheme setup
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      vim.g.nord_disable_background = false
      vim.g.nord_italic = false
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_bold = false

      -- Custom colors
      vim.api.nvim_set_hl(0, "Normal", { fg = "${color-palette.nord4}", bg = "${color-palette.nord0}" })
      vim.api.nvim_set_hl(0, "LineNr", { fg = "${color-palette.nord3}", bg = "${color-palette.nord0}" })
      vim.api.nvim_set_hl(0, "CursorLine", { bg = "${color-palette.nord1}" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "${color-palette.nord4}", bg = "${color-palette.nord1}" })
      vim.api.nvim_set_hl(0, "Visual", { bg = "${color-palette.nord3}" })
      vim.api.nvim_set_hl(0, "Search", { fg = "${color-palette.nord0}", bg = "${color-palette.nord12}" })
      vim.api.nvim_set_hl(0, "IncSearch", { fg = "${color-palette.nord0}", bg = "${color-palette.nord15}" })

      -- Treesitter setup
      require'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true,
        },
      }

      -- Nvim-tree setup
      require'nvim-tree'.setup{}

      -- Lualine setup
      require'lualine'.setup {
        options = {
          theme = 'nord'
        }
      }

      -- Telescope setup
      require'telescope'.setup{}

      -- LSP setup
      local lspconfig = require'lspconfig'
      lspconfig.tsserver.setup{}
      lspconfig.eslint.setup{}
      lspconfig.sumneko_lua.setup{}
      lspconfig.nil_ls.setup{}

      -- nvim-cmp setup
      local cmp = require'cmp'
      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
      })

      -- Comment.nvim setup
      require'Comment'.setup()

      -- Autopairs setup
      require'nvim-autopairs'.setup{}
    '';
  };
}


