-- Utility helpers ported from my Vim config

local M = {}

function M.strip_trailing_whitespace()
  local view = vim.fn.winsaveview()
  local search = vim.fn.getreg "/"
  vim.cmd [[keeppatterns %s/\s\+$//e]]
  vim.fn.setreg("/", search)
  vim.fn.winrestview(view)
end

function M.pulse_cursorline()
  local win = vim.api.nvim_get_current_win()
  local original = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false })
  local shades = { "#2a2a2a", "#333333", "#3a3a3a", "#444444", "#3a3a3a", "#333333", "#2a2a2a" }
  local timer = vim.loop.new_timer()
  local i = 1

  timer:start(0, 20, vim.schedule_wrap(function()
    if i > #shades then
      timer:stop()
      timer:close()
      if original and next(original) then
        vim.api.nvim_set_hl(0, "CursorLine", original)
      end
      vim.api.nvim_win_set_option(win, "cursorline", true)
      return
    end

    vim.api.nvim_win_set_option(win, "cursorline", true)
    vim.api.nvim_set_hl(0, "CursorLine", { bg = shades[i] })
    i = i + 1
  end))
end

function M.setup_wrapping()
  local optl = vim.opt_local
  optl.wrap = true
  optl.wrapmargin = 2
  optl.textwidth = 80
  optl.linebreak = true
  optl.list = false

  local buffer = vim.api.nvim_get_current_buf()
  local function map(modes, lhs, rhs)
    vim.keymap.set(modes, lhs, rhs, { buffer = buffer })
  end

  map({ "n", "v" }, "j", "gj")
  map({ "n", "v" }, "k", "gk")
  map({ "n", "v" }, "<Down>", "gj")
  map({ "n", "v" }, "<Up>", "gk")
  map("i", "<Down>", "<C-o>gj")
  map("i", "<Up>", "<C-o>gk")
end

function M.setup_markup()
  M.setup_wrapping()
  local optl = vim.opt_local
  optl.expandtab = true
  optl.tabstop = 4
  optl.shiftwidth = 4
  optl.softtabstop = 4
  optl.textwidth = 0
  optl.wrapmargin = 0
  optl.formatoptions:append { "1", "n" }
  optl.spelllang = "en"
  vim.bo.filetype = "markdown.pandoc"
  optl.spell = false
end

function M.golang_indent()
  local optl = vim.opt_local
  optl.tabstop = 4
  optl.shiftwidth = 4
  optl.softtabstop = 4
  optl.expandtab = true
  optl.autoindent = true
  optl.list = false
  optl.smarttab = true
end

function M.c_style_indent()
  local optl = vim.opt_local
  optl.expandtab = true
  optl.tabstop = 4
  optl.shiftwidth = 4
  optl.softtabstop = 4
end

function M.toggle_verbose()
  if vim.o.verbose == 0 then
    vim.o.verbosefile = vim.fn.expand "~/.log/vim/verbose.log"
    vim.o.verbose = 8
  else
    vim.o.verbose = 0
    vim.o.verbosefile = ""
  end
end

return M
