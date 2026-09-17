-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = ","

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

-- Neovide: fully static cursor (no smear, trail, or insert/cmdline animation)
if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
end
