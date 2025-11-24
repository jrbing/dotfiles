local utils = require "utils"

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Makefiles keep tabs
augroup("ft_make", { clear = true })
autocmd("FileType", {
  group = "ft_make",
  pattern = "make",
  callback = function()
    vim.opt_local.expandtab = false
  end,
})

-- Python
augroup("ft_python", { clear = true })
autocmd("FileType", {
  group = "ft_python",
  pattern = "python",
  callback = function()
    vim.opt_local.define = [[^\s*\(def\|class\)]]
    vim.opt_local.tabstop = 8
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.smarttab = true
    vim.opt_local.expandtab = true
    vim.opt_local.autoindent = true
    vim.opt_local.fileformat = "unix"
    vim.opt_local.smartindent = true
    vim.opt_local.cinwords = { "if", "elif", "else", "for", "while", "try", "except", "finally", "def", "class" }
    vim.b.dispatch = "python %"
    vim.b.autoformat_autoindent = 0
  end,
})
autocmd("BufWritePre", {
  group = "ft_python",
  pattern = "*.py",
  callback = utils.strip_trailing_whitespace,
})

-- Ruby
augroup("ft_ruby", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
  group = "ft_ruby",
  pattern = { "Gemfile", "Vagrantfile", "Rakefile", "Thorfile", "Procfile", "config.ru", "*.rake", "*.cap" },
  callback = function()
    vim.bo.filetype = "ruby"
  end,
})

-- Markdown
augroup("ft_markdown", { clear = true })
autocmd({ "BufRead", "BufNewFile", "BufFilePost" }, {
  group = "ft_markdown",
  pattern = { "*.md", "*.markdown", "*.mdown", "*.mkd", "*.mkdn" },
  callback = utils.setup_markup,
})

-- Text
augroup("ft_text", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
  group = "ft_text",
  pattern = "*.txt",
  callback = utils.setup_wrapping,
})

-- Datamover
augroup("ft_datamover", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
  group = "ft_datamover",
  pattern = "*.dms",
  callback = function()
    vim.bo.filetype = "sql"
  end,
})

-- Java
augroup("ft_java", { clear = true })
autocmd("FileType", {
  group = "ft_java",
  pattern = "java",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.smarttab = true
    vim.opt_local.expandtab = true
    vim.opt_local.autoindent = true
  end,
})

-- Gradle
augroup("ft_gradle", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
  group = "ft_gradle",
  pattern = "*.gradle",
  callback = function()
    vim.bo.filetype = "groovy"
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.smarttab = true
    vim.opt_local.expandtab = true
    vim.opt_local.autoindent = true
  end,
})

-- TaskPaper
augroup("ft_taskpaper", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
  group = "ft_taskpaper",
  pattern = "*.taskpaper",
  callback = function()
    vim.opt_local.autoread = true
    vim.opt_local.list = false
    vim.opt_local.textwidth = 0
    vim.opt_local.wrapmargin = 0
  end,
})

-- C/C++
augroup("ft_cstyle", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
  group = "ft_cstyle",
  pattern = { "*.c", "*.h", "*.cpp" },
  callback = utils.c_style_indent,
})

-- Go
augroup("ft_golang", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
  group = "ft_golang",
  pattern = "*.go",
  callback = utils.golang_indent,
})

-- Ansible
augroup("ft_yaml_ansible", { clear = true })
autocmd("FileType", {
  group = "ft_yaml_ansible",
  pattern = "yaml.ansible",
  callback = function()
    vim.opt_local.textwidth = 0
    vim.opt_local.wrapmargin = 0
  end,
})

-- Powershell
augroup("ft_powershell", { clear = true })
autocmd("FileType", {
  group = "ft_powershell",
  pattern = "ps1",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.smarttab = true
    vim.opt_local.expandtab = true
    vim.opt_local.autoindent = true
    vim.b.delimitMate_quotes = [["' "]]
  end,
})

-- nginx
augroup("ft_nginx", { clear = true })
autocmd("FileType", {
  group = "ft_nginx",
  pattern = "nginx",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.smarttab = true
    vim.opt_local.expandtab = true
    vim.opt_local.autoindent = true
  end,
})

-- gitconfig
augroup("ft_gitconfig", { clear = true })
autocmd("FileType", {
  group = "ft_gitconfig",
  pattern = "gitconfig",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.smarttab = false
    vim.opt_local.expandtab = false
    vim.opt_local.autoindent = true
    vim.opt_local.list = false
  end,
})

-- html tweak
augroup("ft_html", { clear = true })
autocmd("FileType", {
  group = "ft_html",
  pattern = "html",
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

-- Helm templates
augroup("ft_helm", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
  group = "ft_helm",
  pattern = "*/templates/*.yaml,*/templates/*.yml",
  callback = function()
    vim.bo.filetype = "helm"
  end,
})

-- flux
augroup("ft_flux", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
  group = "ft_flux",
  pattern = "*.flux",
  callback = function()
    vim.bo.filetype = "flux"
  end,
})

-- hcl format align
augroup("ft_hcl_fmt", { clear = true })
autocmd("BufWritePre", {
  group = "ft_hcl_fmt",
  pattern = "*.hcl",
  callback = function()
    vim.cmd [[silent! call hcl#align()]]
  end,
})

-- Last location restore, resize, autosave on focus lost
augroup("miscellaneous", { clear = true })
autocmd("FocusLost", {
  group = "miscellaneous",
  pattern = "*",
  command = "silent! wall",
})
autocmd("VimResized", {
  group = "miscellaneous",
  pattern = "*",
  command = "wincmd =",
})
autocmd("BufReadPost", {
  group = "miscellaneous",
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if line > 0 and line <= vim.fn.line "$" then
      vim.cmd [[normal! g`"zvzz]]
    end
  end,
})
