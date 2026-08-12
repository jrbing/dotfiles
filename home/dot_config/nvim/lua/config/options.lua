-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Ported from home/dot_vimrc (only what LazyVim doesn't already set)
vim.opt.relativenumber = false -- vimrc: norelativenumber (LazyVim enables relativenumber)
vim.opt.swapfile = false -- vimrc: noswapfile
vim.opt.wildmode = "list:longest" -- vimrc: wildmode
vim.opt.colorcolumn = "+1" -- vimrc: colorcolumn
vim.opt.showbreak = "↳" -- vimrc: showbreak (paired with LazyVim's breakindent)
vim.opt.gdefault = true -- vimrc: gdefault (s/// substitutes all matches)
vim.opt.scrolloff = 3 -- vimrc: scrolloff (LazyVim default 8)
vim.opt.sidescrolloff = 10 -- vimrc: sidescrolloff (LazyVim default 8)
vim.opt.iskeyword:remove({ ".", "#", "-" }) -- vimrc: iskeyword-= . # -
