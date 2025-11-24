--Formatter for nvim
--https://github.com/stevearc/conform.nvim

local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_format", "black" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettierd", "prettier" },
    javascriptreact = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    typescriptreact = { "prettierd", "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    go = { "goimports", "gofmt" },
    terraform = { "terraform_fmt" },
    hcl = { "terraform_fmt" },
    sh = { "shfmt" },
    sql = { "sqlformat" },
    java = { "astyle" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },

  formatters = {
    sqlformat = {
      command = "sqlformat",
      args = { "--reindent", "--indent_width", "2", "--keywords", "lower", "--identifiers", "lower", "--comma_first", "True", "-" },
      stdin = true,
    },
    astyle = {
      command = "astyle",
      args = { "--mode=java", "--style=google", "--pad-oper", "--convert-tabs", "--pad-header" },
      stdin = true,
    },
  },
}

require("conform").setup(options)
