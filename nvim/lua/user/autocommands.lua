vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]])
	end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.cmd("autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
	callback = function()
		vim.cmd("quit")
	end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.java" },
	callback = function()
		vim.lsp.codelens.refresh()
	end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function()
		vim.cmd("hi link illuminatedWord LspReferenceText")
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
	local line_count = vim.api.nvim_buf_line_count(0)
		if line_count >= 5000 then
			vim.cmd("IlluminatePauseBuf")
		end
	end,
})

--" Autocommands {{{1

  --" Make {{{2
    --augroup ft_make
      --autocmd!
      --autocmd FileType make    setlocal noexpandtab
    --augroup END
  --"}}}

  --" Python {{{2
    --augroup ft_python
      --autocmd!
      --autocmd FileType python setlocal define=^\s*\\(def\\\\|class\\)
      --autocmd FileType python setlocal
            --\ tabstop=8
            --\ softtabstop=4
            --\ shiftwidth=4
            --\ smarttab
            --\ expandtab
            --\ autoindent
            --\ fileformat=unix

      --autocmd BufWritePre *.py normal m`:%s/\s\+$//e``
      --autocmd BufRead *.py setlocal
            --\ smartindent
            --\ cinwords=if,elif,else,for,while,try,except,finally,def,class

      --autocmd FileType python let b:dispatch = 'python %'
      --autocmd FileType python let b:autoformat_autoindent = 0
    --augroup END
  --"}}}

  --" Ruby {{{2
    --augroup ft_ruby
      --autocmd!
      --autocmd BufRead,BufNewFile {Gemfile,Vagrantfile,Rakefile,Thorfile,Procfile,config.ru,*.rake,*.cap} setlocal ft=ruby
    --augroup END
  --"}}}

  --" Markdown {{{2
    --augroup ft_markdown
      --autocmd!
      --autocmd BufRead,BufNewFile,BufFilePre *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()
    --augroup END
  --"}}}

  --" Textfiles {{{2
    --augroup ft_txt
      --autocmd!
      --autocmd BufRead,BufNewFile *.{txt} call s:setupWrapping()
    --augroup END
  --"}}}

  --" Datamover {{{2
    --augroup ft_datamover
      --autocmd!
      --autocmd BufRead,BufNewFile *.{dms} setlocal ft=sql
    --augroup END
  --"}}}
  --"
  --" Java {{{2
    --augroup ft_java
      --autocmd!
      --autocmd FileType java  setlocal tabstop=2 softtabstop=2 shiftwidth=2 smarttab expandtab autoindent
    --augroup END
  --"}}}

  --" Gradle {{{2
    --augroup ft_gradle
      --autocmd!
      --autocmd BufRead,BufNewFile *.{gradle} setlocal ft=groovy tabstop=4 softtabstop=4 shiftwidth=4 smarttab expandtab autoindent
    --augroup END
  --"}}}

  --" TaskPaper {{{2
    --augroup ft_taskpaper
      --autocmd!
      --autocmd BufRead,BufNewFile *.{taskpaper} setlocal autoread nolist textwidth=0 wrapmargin=0
    --augroup END
  --"}}}

  --" C/C++ {{{2
    --augroup ft_cstyle
      --autocmd!
      --autocmd BufRead,BufNewFile *.{c,h,cpp} call CStyleIndent()
    --augroup END
  --"}}}

  --" Go {{{2
    --augroup ft_golang
      --autocmd!
      --autocmd BufRead,BufNewFile *.go call s:golangIndent()
      --"autocmd FileType go nmap <leader>s <Plug>(go-implements)
      --"autocmd FileType go nmap <leader>i <Plug>(go-info)
      --"autocmd FileType go nmap <leader>gd <Plug>(go-doc)
      --"autocmd FileType go nmap <leader>gv <Plug>(go-doc-vertical)
      --"autocmd FileType go nmap <leader>gb <Plug>(go-doc-browser)
      --"autocmd FileType go nmap <leader>r <Plug>(go-run)
      --"autocmd FileType go nmap <leader>b <Plug>(go-build)
      --"autocmd FileType go nmap <leader>t <Plug>(go-test)
      --"autocmd FileType go nmap <leader>c <Plug>(go-coverage)
      --"autocmd FileType go nmap <leader>ds <Plug>(go-def-split)
      --"autocmd FileType go nmap <leader>dv <Plug>(go-def-vertical)
      --"autocmd FileType go nmap <leader>dt <Plug>(go-def-tab)
      --"autocmd FileType go nmap <leader>e <Plug>(go-rename)
    --augroup END
  --"}}}

  --" Ansible {{{2
    --augroup ft_yaml.ansible
      --autocmd!
      --autocmd FileType yaml.ansible setlocal textwidth=0 wrapmargin=0
    --augroup END
  --"}}}

  --" Powershell {{{2
    --augroup ft_powershell
      --autocmd!
      --autocmd FileType ps1  setlocal tabstop=4 softtabstop=4 shiftwidth=4 smarttab expandtab autoindent
      --autocmd FileType ps1  let delimitMate_quotes = "\" '"
    --augroup END
  --"}}}

  --" VIMRC {{{2
    --" Automatically reload the vimrc file when changed
    --augroup myvimrc
      --autocmd!
      --autocmd BufWritePost ~/.dotfiles/vim/vimrc source $MYVIMRC
    --augroup END
  --"}}}

  --" nginx {{{2
    --augroup nginx
      --autocmd Filetype nginx  setlocal tabstop=4 softtabstop=4 shiftwidth=4 smarttab expandtab autoindent
    --augroup END
  --"}}}

  --" gitconfig {{{2
    --augroup gitconfig
      --autocmd Filetype gitconfig  setlocal tabstop=2 softtabstop=2 shiftwidth=2 smarttab noexpandtab autoindent nolist
    --augroup END
  --"}}}

  --" html {{{2
    --augroup html
      --" Fixes an issue with cursorline highlighting causing a scroll lag
      --autocmd Filetype html  setlocal nocursorline
    --augroup END
  --"}}}

  --" helm {{{2
    --augroup helm
      --autocmd BufRead,BufNewFile */templates/*.{yaml,yml} set ft=helm
    --augroup END
  --"}}}

  --" flux {{{2
    --augroup flux
      --autocmd BufRead,BufNewFile *.flux		set filetype=flux
    --augroup END
  --"}}}

  --" Miscellaneous {{{2
    --augroup miscellaneous
      --autocmd!
      --" Save when focus is lost
      --autocmd FocusLost * :silent! wall
      --" Resize splits when the window is resized
      --autocmd VimResized * :wincmd =
      --autocmd InsertEnter * hi StatusLine ctermfg=196 guifg=#FF3145
      --autocmd InsertLeave * hi StatusLine ctermfg=130 guifg=#CD5907
      --" Remember the last location in a file
      --autocmd BufReadPost *
        --\ if line("'\"") > 0 && line("'\"") <= line("$") |
        --\     execute 'normal! g`"zvzz' |
        --\ endif
    --augroup END
  --"}}}

--" }}}
