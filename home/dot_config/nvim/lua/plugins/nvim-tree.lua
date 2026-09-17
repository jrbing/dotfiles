-- Ported from home/dot_vimrc: NERDTree section (lines 787-795) + <F9> (lines 431-432)
--
-- Startup auto-open (g:nerdtree_tabs_open_on_console_startup)
return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", { command = "NvimTreeOpen" })
    end,
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

        local function opts(desc)
          return { buffer = bufnr, desc = desc, noremap = true, silent = true, nowait = true }
        end

        -- NERDTree muscle memory, restricted to keys whose nvim-tree default is
        -- either absent or safe to shadow. See the skip list below.
        vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
        vim.keymap.set("n", "s", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "i", api.node.open.horizontal, opts("Open: Horizontal Split"))
        vim.keymap.set("n", "u", api.tree.change_root_to_parent, opts("Up"))
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
        -- Already aligned with NERDTree by default: R (refresh), P (parent), q (close).
        --
        -- Deliberately NOT ported, because nvim-tree binds them to operations
        -- that are destructive or that nothing else provides:
        --   x -> Cut          (NERDTree: close parent dir)
        --   D -> Trash        (NERDTree: delete bookmark)
        --   I -> Git-ignored  (NERDTree: toggle hidden; nvim-tree uses H)
        --   p -> Paste        (NERDTree: jump to parent) - shadowing strands x/c
        --   r -> Rename       (NERDTree: refresh) - R already refreshes
        --   T -> no nvim-tree API for "open in tab silently"
        --   F/B/A -> live-filter clear / no-buffer filter / no equivalent

        vim.keymap.set("n", "<F9>", function()
          vim.api.nvim_win_set_width(0, 30)
          vim.opt_local.winfixwidth = true
        end, opts("Reset tree width to 30"))
      end,
    },
  },
}
