-- Lua ports of the utility functions from home/dot_vimrc
local M = {}

function M.pulse_cursorline()
  local win = vim.fn.winnr()
  vim.cmd("windo set nocursorline")
  vim.cmd(win .. "wincmd w")
  vim.opt_local.cursorline = true
  for _, bg in ipairs({ "#2a2a2a", "#333333", "#3a3a3a", "#444444", "#3a3a3a", "#333333", "#2a2a2a" }) do
    vim.api.nvim_set_hl(0, "CursorLine", { bg = bg })
    vim.cmd("redraw")
    vim.wait(20)
  end
  vim.api.nvim_set_hl(0, "CursorLine", {})
  vim.cmd("windo set cursorline")
  vim.cmd(win .. "wincmd w")
end

function M.strip_trailing_whitespace()
  local search = vim.fn.getreg("/")
  local view = vim.fn.winsaveview()
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.winrestview(view)
  vim.fn.setreg("/", search)
end

function M.toggle_verbose()
  if vim.o.verbose == 0 then
    vim.o.verbose = 8
    vim.o.verbosefile = vim.fn.stdpath("log") .. "/nvim-verbose.log"
    vim.notify("Verbose logging: " .. vim.o.verbosefile)
  else
    vim.o.verbose = 0
    vim.o.verbosefile = ""
    vim.notify("Verbose logging disabled")
  end
end

return M
