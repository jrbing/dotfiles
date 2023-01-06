vim.opt.backup = false                          -- creates a backup file
vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1                           -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
vim.opt.mousehide = true                        -- hide the mouse
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
vim.opt.laststatus = 3                          -- only the last window will always have a status line
vim.opt.showcmd = false                         -- hide (partial) command in the last line of the screen (for performance)
vim.opt.ruler = false                           -- hide the line and column number of the cursor position
vim.opt.numberwidth = 4                         -- minimal number of columns to use for the line number {default 4}
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false                            -- display lines as one long line
vim.opt.scrolloff = 8                           -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8                       -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`
vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
vim.opt.fillchars.eob=" "                       -- show empty lines at the end of a buffer as ` ` {default `~`}
vim.opt.shortmess:append "c"                    -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"
vim.opt.whichwrap:append("<,>,[,],h,l")         -- keys allowed to move to the previous/next line when the beginning/end of line is reached
vim.opt.iskeyword:append("-")                   -- treats words with `-` as single words
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- This is a sequence of letters which describes how automatic formatting is to be done
vim.opt.linebreak = true

vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.gdefault = true

vim.opt.scrolloff = 3
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 10

vim.opt.encoding = "utf-8"

vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.showbreak = "↳"

vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.hidden = true
vim.opt.visualbell = true
vim.opt.ttyfast = true
vim.opt.ruler = true
vim.opt.number = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ttimeout = true
vim.opt.autowrite = true
vim.opt.shiftround = true
vim.opt.autoread = true
vim.opt.title = true

--" Use modeline overrides
vim.opt.modeline = true
vim.opt.modelines = 5

vim.opt.formatprg = "par"

--" Set folding method, but disable by default
vim.opt.foldmethod = "syntax"
vim.opt.foldenable = false
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.textwidth = 80
--vim.opt.formatoptions = qrn1j

--set norelativenumber
--set undofile
--set undoreload=10000
--set undodir=$HOME/.vim/tmp/undo//     " undo files
--set colorcolumn=+1
--set virtualedit+=block
--set list
--set listchars=trail:·,precedes:«,extends:»,tab:▸\

--set laststatus=2
--set history=1000
--set cpoptions+=J
--set matchtime=3
--set fillchars=diff:⣿
--set mouse=a
--set synmaxcol=200                               " Don't try to highlight lines longer than 200 characters.
--set shortmess+=filmnrxoOtT                      " Abbrev. of messages (avoids 'hit enter')
--set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
--set iskeyword-=.                    " '.' is an end of word designator
--set iskeyword-=#                    " '#' is an end of word designator
--set iskeyword-=-                    " '-' is an end of word designator

--" Wildmenu completion
--vim.opt.wildmenu
--vim.opt.wildmode = list:longest
--vim.opt.wildignore+=.hg,.git,.svn                    " version control
--vim.opt.wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
--vim.opt.wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
--vim.opt.wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
--vim.opt.wildignore+=*.spl                            " compiled spelling word lists
--vim.opt.wildignore+=*.sw?                            " Vim swap files
--vim.opt.wildignore+=*.DS_Store                       " OSX temp files

