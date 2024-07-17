--https://nvchad.com/docs/config/mappings/

require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

----------------
--  Examples  --
----------------

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- multiple modes 
--map({ "i", "n" }, "<C-k>", "<Up>", { desc = "Move up" })

-- mapping with a lua function
--map("n", "<A-i>", function()
   -- do something
--end, { desc = "Terminal toggle floating" })

-- Disable mappings
--local nomap = vim.keymap.del

--nomap("i", "<C-k>")
--nomap("n", "<C-k>")

-----------------------
--  Legacy Mappings  --
-----------------------

--" Bubble single lines
--nmap <C-Up> [e
--nmap <C-Down> ]e

--" Bubble multiple lines
--vmap <C-Up> [egv
--vmap <C-Down> ]egv

--" Remap ; to :
--nnoremap ; :
--vnoremap ; :

--" Visual shifting (does not exit Visual mode)
--vnoremap < <gv
--vnoremap > >gv

--" Map Ctrl+h,j,k,l to easily move around splits
--nnoremap <C-J> <C-W>j<C-W>_
--nnoremap <C-K> <C-W>k<C-W>_
--nnoremap <C-L> <C-W>l<C-W>_
--nnoremap <C-H> <C-W>h<C-W>_

--" Opens an edit command with the path of the currently edited file filled in
--" normal mode: <Leader>e
--nnoremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

--" Opens a tab edit command with the path of the currently edited file filled in
--" Normal mode: <Leader>t
--"map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

--" Command mode: Ctrl+P
--"cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

--" Remap ,v to re-select text that was just pasted
--nnoremap <leader>v V`]

--" Bring up the CtrlP buffer window
--nnoremap <leader>b :CtrlPBuffer<CR>

--" Adjust viewports to the same size
--noremap <Leader>= <C-w>=
--inoremap <Leader>= <Esc> <C-w>=

--" Map Ctrl+Tab and Ctrl+Shift+Tab to switch tabs
--nnoremap <silent> <C-Tab> :call<sid>CycleTabpages(1)<cr>
--nnoremap <silent> <C-S-Tab> :call<sid>CycleTabpages(0)<cr>

--" Align text
--nnoremap <leader>Al :left<cr>
--nnoremap <leader>Ac :center<cr>
--nnoremap <leader>Ar :right<cr>
--vnoremap <leader>Al :left<cr>
--vnoremap <leader>Ac :center<cr>
--vnoremap <leader>Ar :right<cr>

--" Use ,gf to go to file in a vertical split
--nnoremap ,gf :vertical botright wincmd f<CR>

--" Sudo to write
--cmap w!! w !sudo tee % >/dev/null

--" Yank from the cursor to the end of the line, to be consistent with C and D
--nnoremap Y y$

--" Easier horizontal scrolling
--map zl zL
--map zh zH

--" Close all buffers not open in a tab
--nnoremap <leader>wo :Wipeout<CR>

--" Forward clipboard contents to clipper
--if g:OSX()
   --nnoremap <leader>y :call system('nc localhost 8377', @0)<CR>
--endif

--nnoremap <leader><space> :noh<cr>:call clearmatches()<cr>

--" Keep search matches in the middle of the window and pulse the line when moving
--" to them.
--nnoremap n nzzzv:call PulseCursorLine()<cr>
--nnoremap N Nzzzv:call PulseCursorLine()<cr>

--" Function Keys {{{2

--" Remap help to escape
--inoremap <F1> <ESC>
--nnoremap <F1> <ESC>
--vnoremap <F1> <ESC>

--" Toggle paste mode
--set pastetoggle=<F3>

--" Autoformat the current buffer
--nnoremap <F4> :Autoformat<CR><CR>

--" Trim trailing whitespace
--nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

--" Toggle the tagbar
--nnoremap <silent> <F8> :TagbarToggle<CR>

--" Reset NERDTree window size
--nnoremap <silent> <F9> :vertical resize 30 :set winfixwidth<CR>

--" Fullscreen takes up entire screen
--"set fuoptions=maxhorz,maxvert

--" Set correct path for tagbar plugin
--let g:tagbar_ctags_bin = '/usr/local/bin/ctags'

--" Command-T for CtrlP
--noremap <D-T> :CtrlP<CR>
--inoremap <D-T> <Esc>:CtrlP<CR>

--" Command-Shift-F for quick file search
--noremap <D-F> :Ack<space>

--" Map Command-# to switch tabs
--noremap  <D-0> 0gt
--inoremap <D-0> <Esc>0gt
--noremap  <D-1> 1gt
--inoremap <D-1> <Esc>1gt
--noremap  <D-2> 2gt
--inoremap <D-2> <Esc>2gt
--noremap  <D-3> 3gt
--inoremap <D-3> <Esc>3gt
--noremap  <D-4> 4gt
--inoremap <D-4> <Esc>4gt
--noremap  <D-5> 5gt
--inoremap <D-5> <Esc>5gt
--noremap  <D-6> 6gt
--inoremap <D-6> <Esc>6gt
--noremap  <D-7> 7gt
--inoremap <D-7> <Esc>7gt
--noremap  <D-8> 8gt
--inoremap <D-8> <Esc>8gt
--noremap  <D-9> 9gt
--inoremap <D-9> <Esc>9gt

--" Map Command+Shift+P to preview the document in Marked
--nnoremap <D-P> :silent !open -a 'Marked 2.app' '%:p'<cr>

--" Open the document in TableFlip
--function! TableFlip()
   --execute 'silent ! open -a TableFlip.app %:p'
--endfunction

--command! TableFlip :call TableFlip()

--" Create a pdf using pandoc and open it
--function! CreatePDF()
   --"execute 'silent ! pandoc -o /tmp/%:t:r.pdf --latex-engine=xelatex --template=$HOME/.pandoc/custom/document.latex "%"'
   --"execute '! pandoc -o /tmp/%:t:r.pdf --pdf-engine=xelatex --template=$HOME/.pandoc/custom/document.latex "%"'
   --execute '! pandoc "%" --output /tmp/%:t:r.pdf --pdf-engine xelatex --template eisvogel --from markdown --listings --variable fontsize=9pt'
   --execute 'silent ! open /tmp/%:t:r.pdf'
--endfunction

--command! CreatePDF :call CreatePDF()

--if !g:VIMR()
   --" Set the font
   --"set guifont=Meslo\ LG\ M\ DZ:h12.00
   --"set guifont=Inconsolata:h14.00
   --"set guifont=Inconsolata-dz:h12.00
   --"set guifont=Sauce\ Code\ Powerline\ Light:h13
   --"set guifont=Inconsolata\ XL:h12,Inconsolata:h12,Monaco:h12
   --"set guifont=InconsolataForPowerline\ Nerd\ Font:h16
   --"set guifont=Inconsolata\ Nerd\ Font:h14
   --"set guifont=InconsolataLGC\ Nerd\ Font:h12
   --"set guifont=Inconsolata\ for\ Powerline:h14
   --"set guifont=InconsolataGo\ Nerd\ Font\ Mono:h14
   --set guifont=Inconsolata-dz\ for\ Powerline:h12
--endif

--" Insert date and time header at the top of the file
--noremap <D-D> gg}o## <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR> ##<CR>
--inoremap <D-D> <Esc>gg}o## <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR> ##<CR>

--set list
--set listchars=trail:·,precedes:«,extends:»,tab:▸\
--"set listchars=tab:▸\ ,extends:❯,precedes:❮,trail:·

--" Map Command right/left to move tabs
--nnoremap <silent> <D-Right> :tabnext<cr>
--nnoremap <silent> <D-Left> :tabprevious<cr>

--" Command-][ to increase/decrease indentation
--vmap <D-]> >gv
--vmap <D-[> <gv

--" Command-T for CtrlP
--macmenu &File.New\ Tab key=<nop>
--map <D-t> :CtrlP<CR>
--imap <D-t> <Esc>:CtrlP<CR>
--macmenu &File.New\ Tab key=<D-T>

--" Command-Return for fullscreen
--macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>
