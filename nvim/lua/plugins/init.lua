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
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  ----------------------
  --  Custom Plugins  --
  ----------------------
  --" Utilities
  --Plug 'artnez/vim-wipeout'
  --Plug 'chrisbra/matchit'
  --Plug 'ctrlpvim/ctrlp.vim'
  --Plug 'dbeniamine/cheat.sh-vim'
  --Plug 'diepm/vim-rest-console', { 'for': ['rest'] }
  --Plug 'direnv/direnv.vim'
  --Plug 'editorconfig/editorconfig-vim'
  --Plug 'ervandew/supertab'
  --Plug 'godlygeek/tabular'
  --Plug 'mattmartini/vim-nerdtree-tabs'
  --Plug 'jphustman/SQLUtilities', { 'for': ['sql', 'plsql'] }
  --Plug 'junegunn/fzf'
  --Plug 'justinmk/vim-sneak'
  --Plug 'kristijanhusak/vim-carbon-now-sh'
  --Plug 'lambdalisue/vim-gista'
  --Plug 'majutsushi/tagbar'
  --Plug 'mg979/vim-visual-multi', {'branch': 'master'}
  --Plug 'mtth/scratch.vim'
  --Plug 'preservim/nerdcommenter'
  --Plug 'preservim/nerdtree'
  --Plug 'psliwka/vim-smoothie'
  --Plug 'tpope/vim-abolish'
  --Plug 'tpope/vim-dadbod', { 'for': ['sql', 'plsql'] }
  --Plug 'tpope/vim-dispatch'
  --Plug 'tpope/vim-eunuch'
  --Plug 'tpope/vim-fugitive'
  --Plug 'tpope/vim-git'
  --Plug 'tpope/vim-jdaddy', { 'for': ['json'] }
  --Plug 'tpope/vim-projectionist'
  --Plug 'tpope/vim-ragtag'
  --Plug 'tpope/vim-rbenv', { 'for': ['ruby'] }
  --Plug 'tpope/vim-repeat'
  --Plug 'tpope/vim-rhubarb'
  --Plug 'tpope/vim-surround'
  --Plug 'tpope/vim-tbone'
  --Plug 'tpope/vim-unimpaired'
  --Plug 'vim-airline/vim-airline'
  --Plug 'vim-airline/vim-airline-themes'
  --Plug 'vim-pandoc/vim-pandoc', { 'for': ['pandoc', 'markdown'] }
  --Plug 'vim-scripts/Align'
  --Plug 'wincent/ferret'
  --Plug 'vim-autoformat/vim-autoformat'
  --Plug 'EvanDotPro/nerdtree-chmod'
  --Plug 'Raimondi/delimitMate'
  --Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
  --Plug 'mattn/webapi-vim'
  --Plug 'rizzatti/dash.vim'
  --Plug 'dense-analysis/ale'
  --Plug 'vim-voom/VOoM'
  --Plug 'metakirby5/codi.vim'
  --if !g:VIMR()
    --Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --all' }
  --endif
  --if g:VIMR()
    --Plug 'github/copilot.vim'
  --endif

  -- Examples:
  -- {
  --   "neovim/nvim-lspconfig",
  --   config = function()
  --     require("nvchad.configs.lspconfig").defaults()
  --     require "configs.lspconfig"
  --   end,
  -- },
  --
  -- {
  --  "williamboman/mason.nvim",
  --  opts = {
  --    ensure_installed = {
  --      "lua-language-server", "stylua",
  --      "html-lsp", "css-lsp" , "prettier"
  --    },
  --  },
  -- },
  --
  -- {
  --  "nvim-treesitter/nvim-treesitter",
  --  opts = {
  --    ensure_installed = {
  --      "vim", "lua", "vimdoc",
  --      "html", "css"
  --    },
  --  },
  -- },
}