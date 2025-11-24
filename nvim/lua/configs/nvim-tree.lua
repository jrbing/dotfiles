
-- File explorer tree
--https://github.com/nvim-tree/nvim-tree.lua

-- Open on startup
local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end
