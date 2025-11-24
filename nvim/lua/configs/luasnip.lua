-- Snippets
-- https://github.com/L3MON4D3/LuaSnip

local luasnip = require "luasnip"

-- Load community snippets and our legacy UltiSnips collection (snipmate format)
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load {
  paths = { vim.fn.expand "~/.dotfiles/vim/custom/snippets" },
}

luasnip.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
}
