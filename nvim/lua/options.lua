require "nvchad.options"

local opt = vim.opt

-- Core editing behavior mirrored from vim/vimrc
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.fileencodings = { "ucs-bom", "utf-8", "latin1" }
opt.autoindent = true
opt.breakindent = true
opt.showbreak = "↳"
opt.showmode = true
opt.showcmd = true
opt.hidden = true
opt.visualbell = true
opt.ruler = true
opt.backspace = "indent,eol,start"
opt.number = true
opt.laststatus = 2
opt.history = 1000
opt.cpoptions:append "J"
opt.matchtime = 3
opt.splitbelow = true
opt.splitright = true
opt.fillchars:append { diff = "⣿" }
opt.ttimeout = true
opt.timeout = false
opt.autowrite = true
opt.shiftround = true
opt.autoread = true
opt.title = true
opt.mouse = "a"

opt.synmaxcol = 200
opt.shortmess:append "filmnrxoOtT"
opt.viewoptions = { "folds", "options", "cursor", "unix", "slash" }
opt.iskeyword:remove "."
opt.iskeyword:remove "#"
opt.iskeyword:remove "-"

opt.backupdir = vim.fn.expand "~/.vim/tmp/backup//"
opt.directory = vim.fn.expand "~/.vim/tmp/swap//"
opt.backup = true
opt.swapfile = false

opt.wildmenu = true
opt.wildmode = { "list", "longest" }
opt.wildignore:append {
  ".hg",
  ".git",
  ".svn",
  "*.aux",
  "*.out",
  "*.toc",
  "*.jpg",
  "*.bmp",
  "*.gif",
  "*.png",
  "*.jpeg",
  "*.o",
  "*.obj",
  "*.exe",
  "*.dll",
  "*.manifest",
  "*.spl",
  "*.sw?",
  "*.DS_Store",
}

opt.modeline = true
opt.modelines = 5

opt.foldmethod = "syntax"
opt.foldenable = false

opt.wrap = false
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.textwidth = 80
opt.formatoptions = "qrn1j"

opt.termguicolors = true
opt.relativenumber = false
opt.undofile = true
opt.undoreload = 10000
opt.undodir = vim.fn.expand "~/.vim/tmp/undo//"
opt.colorcolumn = { "+1" }

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.showmatch = true
opt.hlsearch = true
vim.o.gdefault = true

opt.scrolloff = 3
opt.sidescroll = 1
opt.sidescrolloff = 10
opt.virtualedit:append "block"

opt.cursorline = true

if vim.fn.has "unix" == 1 and vim.fn.has "win32" == 0 then
  opt.shell = "/bin/bash"
end

if vim.g.neovide then
  vim.o.guifont = "Inconsolata-dz for Powerline:h12"
  -- vim.g.neovide_scale_factor = 1.0
  -- vim.g.neovide_text_gamma = 0.0
  -- vim.g.neovide_text_contrast = 0.5
  -- vim.g.neovide_padding_top = 0
  -- vim.g.neovide_padding_bottom = 0
  -- vim.g.neovide_padding_right = 0
  -- vim.g.neovide_padding_left = 0
end

-- Open nvim-tree on startup to mimic NERDTree tabs workflow
local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
