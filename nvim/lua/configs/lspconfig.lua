local defaults = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"

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

local opts = {
  on_attach = defaults.on_attach,
  on_init = defaults.on_init,
  capabilities = defaults.capabilities,
}

for _, server in ipairs(servers) do
  if lspconfig[server] then
    lspconfig[server].setup(opts)
  end
end
