require "nvchad.options"

-- Open nvim-tree on startup
local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

--------------
--  Legacy  --
--------------

--" Highlight the current line
--set cursorline

--" Set the tab label to equal the file name
--set guitablabel=%t

--if has('multi_byte')
  --if &termencoding ==# ''
    --let &termencoding = &encoding
  --endif
  --set encoding=utf-8
  --scriptencoding utf-8
  --setglobal fileencoding=utf-8
  --"setglobal bomb
  --set fileencodings=ucs-bom,utf-8,latin1
--endif
--set autoindent
--set breakindent
--set showbreak=↳
--set showmode
--set showcmd
--set hidden
--set visualbell
--set ttyfast
--set ruler
--set backspace=indent,eol,start
--set number
--set laststatus=2
--set history=1000
--set cpoptions+=J
--if !g:WINDOWS()
  --set shell=/bin/bash
--endif
--"set lazyredraw
--set matchtime=3
--set splitbelow
--set splitright
--set fillchars=diff:⣿
--set ttimeout
--set notimeout
--set nottimeout
--set autowrite
--set shiftround
--set autoread
--set title
--set mouse=a
--set mousehide

--set synmaxcol=200                               " Don't try to highlight lines longer than 200 characters.
--set shortmess+=filmnrxoOtT                      " Abbrev. of messages (avoids 'hit enter')
--set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility

--set iskeyword-=.                    " '.' is an end of word designator
--set iskeyword-=#                    " '#' is an end of word designator
--set iskeyword-=-                    " '-' is an end of word designator

--" Backup settings
--set backupdir=$HOME/.vim/tmp/backup// " backup directory location
--set directory=$HOME/.vim/tmp/swap//   " swap file location
--set backup                            " enable backups
--set noswapfile                        " disable swapfiles

--" Wildmenu completion
--set wildmenu
--set wildmode=list:longest

--set wildignore+=.hg,.git,.svn                    " version control
--set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
--set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
--set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
--set wildignore+=*.spl                            " compiled spelling word lists
--set wildignore+=*.sw?                            " Vim swap files
--set wildignore+=*.DS_Store                       " OSX temp files

--" Use modeline overrides
--set modeline
--set modelines=5

--" Set par as the paragraph formatting program to use
--if executable('par')
  --set formatprg=par
--endif

--" Set folding method, but disable by default
--set foldmethod=syntax
--set nofoldenable

--set nowrap
--set expandtab
--set tabstop=2
--set shiftwidth=2
--set softtabstop=2
--set textwidth=80
--set formatoptions=qrn1j

--if v:version >= 800
  --" True color support
  --set termguicolors
--endif

--if v:version >= 730
  --set norelativenumber
  --set undofile
  --set undoreload=10000
  --set undodir=$HOME/.vim/tmp/undo//     " undo files
  --set colorcolumn=+1
--endif

--set ignorecase
--set smartcase
--set incsearch
--set showmatch
--set hlsearch
--set gdefault

--set scrolloff=3
--set sidescroll=1
--set sidescrolloff=10

--set virtualedit+=block

-- GoToTab
--for i = 1, 9, 1 do
  --vim.keymap.set("n", string.format("<A-%s>", i), function()
    --vim.api.nvim_set_current_buf(vim.t.bufs[i])
  --end)
--end
