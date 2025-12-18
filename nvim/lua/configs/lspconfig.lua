require("nvchad.configs.lspconfig").defaults()

local servers = {
  "bashls",
  "clangd",
  "cssls",
  "gopls",
  "helm_ls",
  "html",
  "jsonls",
  "lua_ls",
  "marksman",
  "powershell_es",
  "pyright",
  "rust_analyzer",
  "terraformls",
  "tsserver",
  "yamlls",
}

vim.lsp.enable(servers)
