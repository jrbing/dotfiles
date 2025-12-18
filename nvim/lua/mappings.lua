require "nvchad.mappings"

local map = vim.keymap.set

local utils = require "utils"
local telescope = require "telescope.builtin"

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Bubble lines up/down
map("n", "<C-Up>", "[e", { desc = "Bubble line up" })
map("n", "<C-Down>", "]e", { desc = "Bubble line down" })
map("v", "<C-Up>", "[egv", { desc = "Bubble selection up" })
map("v", "<C-Down>", "]egv", { desc = "Bubble selection down" })

-- Split navigation
map("n", "<C-J>", "<C-W>j<C-W>_", { desc = "Split down" })
map("n", "<C-K>", "<C-W>k<C-W>_", { desc = "Split up" })
map("n", "<C-L>", "<C-W>l<C-W>_", { desc = "Split right" })
map("n", "<C-H>", "<C-W>h<C-W>_", { desc = "Split left" })

-- File/path helpers
map("n", "<leader>e", ':e <C-R>=expand("%:p:h") . "/" <CR>', { desc = "Edit in current dir" })
map("n", "<leader>v", "V`]", { desc = "Re-select last paste" })

-- Telescope in place of CtrlP
map("n", "<leader>b", telescope.buffers, { desc = "Buffers (CtrlPBuffer)" })
map("n", "<A-t>", telescope.find_files, { desc = "Find files" })

-- Window sizing
-- map("n", "<leader>=", "<C-w>=", { desc = "Equalize splits" })
-- map("i", "<leader>=", "<Esc><C-w>=", { desc = "Equalize splits" })

-- Alignment helpers
--map("n", "<leader>Al", ":left<cr>", { desc = "Align left" })
--map("n", "<leader>Ac", ":center<cr>", { desc = "Align center" })
--map("n", "<leader>Ar", ":right<cr>", { desc = "Align right" })
--map("v", "<leader>Al", ":left<cr>", { desc = "Align left" })
--map("v", "<leader>Ac", ":center<cr>", { desc = "Align center" })
--map("v", "<leader>Ar", ":right<cr>", { desc = "Align right" })

map("n", ",gf", ":vertical botright wincmd f<CR>", { desc = "Open file in vsplit" })

-- Yank to EOL for consistency with C/D
map("n", "Y", "y$", { desc = "Yank to end of line" })

-- Horizontal scroll shortcuts
map({ "n", "v" }, "zl", "zL", { desc = "Scroll right" })
map({ "n", "v" }, "zh", "zH", { desc = "Scroll left" })

-- Clear search highlights
map("n", "<leader><space>", "<cmd>noh<cr>", { desc = "Clear search" })

-- Keep search matches centered and pulse cursorline
map("n", "n", function()
  vim.cmd "normal! nzzzv"
  utils.pulse_cursorline()
end, { desc = "Next search + pulse" })
map("n", "N", function()
  vim.cmd "normal! Nzzzv"
  utils.pulse_cursorline()
end, { desc = "Prev search + pulse" })

-- Function keys
map({ "i", "n", "v" }, "<F1>", "<Esc>", { desc = "Escape on F1" })
map("n", "<F4>", function()
  require("conform").format { async = false, lsp_fallback = true }
end, { desc = "Format buffer" })
map("n", "<F5>", utils.strip_trailing_whitespace, { desc = "Trim trailing whitespace" })
-- map("n", "<F8>", "<cmd>TagbarToggle<cr>", { desc = "Toggle Tagbar" })
-- map("n", "<F9>", "<cmd>vertical resize 30 | set winfixwidth<cr>", { desc = "Resize side window" })

-- Wipeout unused buffers
map("n", "<leader>wo", "<cmd>Wipeout<CR>", { desc = "Close non-tab buffers" })

-- Toggle verbose logging
map("n", "<leader>tv", utils.toggle_verbose, { desc = "Toggle verbose logging" })

-- nvim-tree
map("n", "<leader>n", ":NvimTreeToggle<cr>", { desc = "Toggle NvimTree" })
