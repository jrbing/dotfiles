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
  { import = "nvchad.blink.lazyspec" },

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
  {
    "NickvanDyke/opencode.nvim",
    lazy = false,
    dependencies = {
      -- Recommended for `ask()` and `select()`.
      -- Required for `snacks` provider.
      ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition".
      }

      -- Required for `opts.events.reload`.
      vim.o.autoread = true

      -- Recommended/example keymaps.
      -- vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
      -- vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
      -- vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })

      -- vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { expr = true, desc = "Add range to opencode" })
      -- vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { expr = true, desc = "Add line to opencode" })

      -- vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "opencode half page up" })
      -- vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "opencode half page down" })

      -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
      -- vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
      -- vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
    end,
  },
  { "numToStr/Comment.nvim", opts = {} },
  { "artnez/vim-wipeout", cmd = "Wipeout" },
  { "andrewstuart/vim-kubernetes", ft = { "yaml" } },
  { "kylechui/nvim-surround", event = "VeryLazy", config = true },
  -- { "github/copilot.vim", event = "InsertEnter" },
  -- { "kristijanhusak/vim-carbon-now-sh", cmd = "CarbonNowSh" },
}
