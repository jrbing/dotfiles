-- Ported from home/dot_vimrc: AutoFormat section (lines 691-700).
-- <F4> already calls require("conform").format (see config/keymaps.lua).
--
-- format-on-save is left at LazyVim's default (enabled). Note that this means
-- Java files are restyled to --style=google on every write.
--
-- g:formatdef_sqlformat is NOT ported: sqlformat ships with the Python
-- `sqlparse` package, which would need new install plumbing. Use sqlfluff
-- (available via mason) if SQL formatting is wanted.
return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "black" }, -- vimrc: g:formatters_python
        yaml = { "prettier" }, -- vimrc: g:formatters_yaml
        java = { "astyle" }, -- vimrc: g:formatdef_custom_java
      },
      formatters = {
        astyle = {
          command = "astyle",
          args = {
            "--mode=java",
            "--style=google",
            "--pad-oper",
            "--convert-tabs",
            "--pad-header",
          },
          stdin = true,
        },
      },
    },
  },
  -- mason.nvim declares opts_extend = { "ensure_installed" }, so this appends.
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "black", "prettier" } },
  },
}
