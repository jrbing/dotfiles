return {
  -------------------------
  --  Delivered Plugins  --
  -------------------------
  
  -- Plugin manager: https://github.com/folke/lazy.nvim
  -- Syntax highlighting and auto-indexing: https://github.com/nvim-treesitter/nvim-treesitter
  -- Colorizer: https://github.com/norcalli/nvim-colorizer.lua
  -- Fuzzy file finder: https://github.com/nvim-telescope/telescope.nvim
  -- Auto pairing: https://github.com/windwp/nvim-autopairs
  -- Snippets: https://github.com/L3MON4D3/LuaSnip
  -- Portable package manager: https://github.com/williamboman/mason.nvim
  -- Git integration: https://github.com/lewis6991/gitsigns.nvim
  -- Displays keybindings of the command you start typing: https://github.com/folke/which-key.nvim
  -- Indention guides: https://github.com/lukas-reineke/indent-blankline.nvim
  -- Completion plugin: https://github.com/hrsh7th/nvim-cmp
  -- Language completion plugin: https://github.com/neovim/nvim-lspconfig
  -- File formatter: https://github.com/stevearc/conform.nvim
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre',
    config = function()
      require "configs.conform"
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

  --------------------
  --  Vim Parity   --
  --------------------
  { "justinmk/vim-sneak", event = "VeryLazy" },
  -- { "mg979/vim-visual-multi", branch = "master", event = "VeryLazy" },
  { "psliwka/vim-smoothie", event = "VeryLazy" },
  { "kylechui/nvim-surround", event = "VeryLazy", config = true },
  { "tpope/vim-repeat", event = "VeryLazy" },
  { "tpope/vim-unimpaired", event = "VeryLazy" },
  { "tpope/vim-abolish", event = "VeryLazy" },
  { "tpope/vim-fugitive", event = "VeryLazy" },
  { "tpope/vim-rhubarb", event = "VeryLazy" },
  { "tpope/vim-eunuch", event = "VeryLazy" },
  { "tpope/vim-projectionist", event = "VeryLazy" },
  { "tpope/vim-dadbod", event = "VeryLazy" },
  -- {
    -- "majutsushi/tagbar",
    -- cmd = "TagbarToggle",
    -- init = function()
      -- local ctags = vim.fn.exepath "ctags"
      -- if ctags ~= "" then
        -- vim.g.tagbar_ctags_bin = ctags
      -- end
    -- end,
  -- },
  { "direnv/direnv.vim", event = "BufReadPost" },
  { "godlygeek/tabular", cmd = { "Tabularize" } },
  { "kristijanhusak/vim-carbon-now-sh", cmd = "CarbonNowSh" },
  { "numToStr/Comment.nvim", opts = {} },
  { "artnez/vim-wipeout", cmd = "Wipeout" },
  { "Raimondi/delimitMate", event = "InsertEnter" },
  { "andrewstuart/vim-kubernetes", ft = { "yaml" } },
  { "towolf/vim-helm", ft = { "helm" } },
  { "hashivim/vim-terraform", ft = { "terraform", "hcl" } },
  { "gianarb/vim-flux", ft = { "flux" } },
  { "omer/vim-sparql", ft = { "sparql" } },
  { "terrastruct/d2-vim", ft = { "d2" } },
}
