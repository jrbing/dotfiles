return {
  --------------------------------
  --  NVChad Delivered Plugins  --
  --------------------------------
  -- Plugin manager: https://github.com/folke/lazy.nvim
  -- Syntax highlighting and auto-indexing: https://github.com/nvim-treesitter/nvim-treesitter
  -- Colorizer: https://github.com/norcalli/nvim-colorizer.lua
  -- Fuzzy file finder: https://github.com/nvim-telescope/telescope.nvim
  -- Auto pairing: https://github.com/windwp/nvim-autopairs
  -- Snippets: https://github.com/L3MON4D3/LuaSnip
  -- LSP package manager: https://github.com/williamboman/mason.nvim
  -- Git integration: https://github.com/lewis6991/gitsigns.nvim
  -- Displays keybindings of the command you start typing: https://github.com/folke/which-key.nvim
  -- Indention guides: https://github.com/lukas-reineke/indent-blankline.nvim
  -- Completion plugin: https://github.com/hrsh7th/nvim-cmp
  -- Language completion plugin: https://github.com/neovim/nvim-lspconfig
  -- File formatter: https://github.com/stevearc/conform.nvim
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre',
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "clangd",
        "css-lsp",
        "dockerfile-language-server",
        "gopls",
        "helm-ls",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "marksman",
        "powershell-editor-services",
        "prettier",
        "prettierd",
        "pyright",
        "rust-analyzer",
        "stylua",
        "terraform-ls",
        "typescript-language-server",
        "yaml-language-server",
      },
    },
  },
  {import = "nvchad.blink.lazyspec"},

  -- {
  --  "nvim-treesitter/nvim-treesitter",
  --  opts = {
  --    ensure_installed = {
  --      "vim", "lua", "vimdoc",
  --      "html", "css"
  --    },
  --  },
  -- },

  --------------------------
  --  Additional Plugins  --
  --------------------------
  { "NickvanDyke/opencode.nvim", lazy = false },
  { "numToStr/Comment.nvim", opts = {} },
  { "artnez/vim-wipeout", cmd = "Wipeout" },
  { "andrewstuart/vim-kubernetes", ft = { "yaml" } },
  { "kylechui/nvim-surround", event = "VeryLazy", config = true },
  -- { "github/copilot.vim", event = "InsertEnter" },
  -- { "kristijanhusak/vim-carbon-now-sh", cmd = "CarbonNowSh" },
}
