-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>')

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Lsp
keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)

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

--" }}}
