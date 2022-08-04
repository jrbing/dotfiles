vim.opt.backup = false                          -- creates a backup file
vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1                           -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 0                         -- always show tabs
vim.opt.smartcase = true                        -- smart case
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.shiftwidth = 2                          -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2                             -- insert 2 spaces for a tab
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.number = true                           -- set numbered lines
vim.opt.laststatus = 3
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.numberwidth = 4                         -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false                            -- display lines as one long line
vim.opt.scrolloff = 8                           -- is one of my fav
vim.opt.sidescrolloff = 8
vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
vim.opt.fillchars.eob=" "
vim.opt.shortmess:append "c"
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")

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
--set list
--set listchars=trail:·,precedes:«,extends:»,tab:▸\
