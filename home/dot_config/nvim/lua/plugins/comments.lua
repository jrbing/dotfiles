-- Ported from home/dot_vimrc: NERDCommenter section (lines 805-812).
--
-- Only g:NERDCustomDelimiters carries over. Commenting itself is native `gc`
-- (Neovim >= 0.10) plus ts-comments.nvim, both already shipped by LazyVim, so
-- no NERDCommenter keymaps are recreated: gcc / gc{motion} replace <leader>cc
-- and <leader>c<space>, and <leader>c is LazyVim's Code group.
--
-- g:NERDSpaceDelims is native: the commentstring below includes the space.
-- The vimrc's NERDCommenter_before/after yaml.ansible workaround is obsolete;
-- it existed to toggle NERDSpaceDelims around a NERDCommenter bug.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "openscad", "flux" },
  callback = function()
    vim.bo.commentstring = "// %s"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "helm", "brewfile", "sparql" },
  callback = function()
    vim.bo.commentstring = "# %s"
  end,
})

return {}
