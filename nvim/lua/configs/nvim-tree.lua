
-- File explorer tree
--https://github.com/nvim-tree/nvim-tree.lua

-- Open on startup
local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end

--local function nvim_tree_custom_mappings(bufnr)
  --local api = require "nvim-tree.api"

  --local function opts(desc)
    --return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  --end

  ---- default mappings
  --api.config.mappings.default_on_attach(bufnr)

  ---- custom mappings
  --vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
  --vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
--end

--{
  --"nvim-tree/nvim-tree.lua",
  --opts = {
    --sort = {
      --sorter = "case_sensitive",
    --},
    --view = {
      --width = 30,
    --},
    --renderer = {
      --group_empty = true,
    --},
    --filters = {
      --dotfiles = true,
    --},
    --on_attach = my_on_attach,
  --},
--},

--------------
--  Legacy  --
--------------

--" NERDTree {{{2
  --map <Leader>n <plug>NERDTreeTabsToggle<CR>
  --let g:NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
  --let g:NERDChristmasTree=1           " Makes NERDTree use colors
  --let g:NERDTreeChDirMode=1           " Changes the current working directory to the one set as the root in NERDTree
  --let g:NERDTreeShowBookmarks=1       " Display the bookmarks on startup
  --let g:NERDTreeMinimalUI=1           " Minimal UI elements
  --let g:NERDTreeDirArrows=1           " Use arrows for directory folding
--"}}}

--" NERDTree Tabs {{{2
  --let g:nerdtree_tabs_smart_startup_focus = 1
  --let g:nerdtree_tabs_open_on_gui_startup = 1
  --let g:nerdtree_tabs_open_on_console_startup = 1
  --let g:nerdtree_tabs_meaningful_tab_names = 1
  --let g:nerdtree_tabs_synchronize_view = 0
--"}}}

