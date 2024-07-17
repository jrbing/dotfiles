--Formatter for nvim
--https://github.com/stevearc/conform.nvim

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

require("conform").setup(options)

--------------
--  Legacy  --
--------------
--let g:formatterpath = [ '/usr/local/bin', '/usr/local/sbin', '/usr/bin', '/bin', '/usr/sbin', '/sbin', '/opt/go/bin', '/opt/oracle/sqlcl/bin' ]
--let g:formatters_python = ['black']
--let g:formatters_yaml = ['prettier']
--let g:formatdef_custom_java='astyle --mode=java --style=google --pad-oper --convert-tabs --pad-header'
--let g:formatters_java = ['custom_java']
--let g:formatdef_sqlformat = '"sqlformat --reindent --indent_width 2 --keywords lower --identifiers lower --comma_first True -"'
