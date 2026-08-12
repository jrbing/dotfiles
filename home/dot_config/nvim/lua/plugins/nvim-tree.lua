-- Ported from home/dot_vimrc: NERDTree section (lines 796-804) + <F9> (lines 440-441)
-- Open nvim-tree automatically at startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("NvimTreeOpen")
  end,
})

return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
    opts = {
      -- g:NERDTreeIgnore -> filters.custom (vim regexes, escaped for Lua)
      filters = {
        custom = {
          "\\.py[cd]$",
          "\\~$",
          "\\.swo$",
          "\\.swp$",
          "^\\.git$",
          "^\\.hg$",
          "^\\.svn$",
          "\\.bzr$",
        },
      },
      -- g:NERDTreeChDirMode=1 -> sync tree root with cwd (legacy name: update_cwd)
      sync_root_with_cwd = true,
      -- g:NERDTreeShowBookmarks=1 -> enable bookmarks and persist them
      bookmarks = {
        persist = true,
      },
      -- g:NERDTreeMinimalUI=1 -> minimal chrome: hide the root folder label
      renderer = {
        root_folder_label = false,
      },
      -- <F9> "Reset NERDTree window size" -> default width + buffer keymap
      view = {
        width = 30,
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        api.map.on_attach.default(bufnr)
        vim.keymap.set("n", "<F9>", function()
          vim.api.nvim_win_set_width(0, 30)
          vim.opt_local.winfixwidth = true
        end, {
          buffer = bufnr,
          desc = "Reset tree width to 30",
          noremap = true,
          silent = true,
          nowait = true,
        })
      end,
    },
  },
}
