-- Skip the LazyVim startup menu (snacks dashboard) and release two key claims.
--
-- LazyVim.safe_keymap_set silently refuses to set any lhs already claimed by a
-- plugin's lazy `keys` spec. snacks_picker claims <leader>n (Notification
-- History) and snacks_explorer claims <leader>e (Explorer), which shadowed the
-- vimrc-derived maps in config/keymaps.lua. Setting them to `false` releases
-- the claim so safe_keymap_set can bind them.
return {
  {
    "snacks.nvim",
    keys = {
      { "<leader>n", false },
      { "<leader>e", false },
    },
    opts = {
      dashboard = { enabled = false },
    },
  },
}
