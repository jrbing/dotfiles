VIM
===

## Usage Notes ##

    \:ls - list buffers
    zR - unfold all levels

### Navigation ###

    ctrl+f - page forward
    ctrl+b - page back
    G - go to end of file
    ctrl+shift+up/down - move to previous/next tab
    M - go to the middle line of the page
    H - go to the top line of the page
    L - go to the bottom line of the page
    $ - end of line
    0 - beginning of line
    C - delete text to end of line and go into insert mode
    % - jump between matching parenthesis
    \* - search for next word under cursor
    \# - search for previous word under cursor
    Ctrl+] - jump from a link

## Normal Mode ##

    J - join two lines together

### Custom Mappings ###

    , - leader key
    w!! - write file as sudo

#### Function Keys ####

    F1 - escape
    F2 -
    F3 - toggle gundo
    F4 - toggle yankring
    F5 - clear trailing whitespace
    F6 -
    F7 - toggle tagbar
    F8 -

### Spelling ###

    :set spell - turn spelling on
    :set nospell - turn spellcheck off
    ]s — move to the next mispelled word
    [s — move to the previous mispelled word
    zg — add a word to the dictionary
    zug — undo the addition of a word to the dictionary
    z= — view spelling suggestions for a mispelled word

### Vim Diff ###

    :diffthis       Run diff against current window split (repeat on split you want to compare)
    do              Get changes from other window and apply to current window
    dp              Put changes from current window to other window

### Formatting ###

    gqip - format paragraph using external utility

### Line Breaks ###

[Working with line breaks](http://vim.wikia.com/wiki/Word_wrap_without_line_breaks)

### Working in Column Mode ###

To use it, press:

* Ctrl + V to go into column mode (this doesn't work under windows because I have the script to enable ctrl+v to paste)
* Select the columns and rows where you want to enter your text
* Shift + i to go into insert mode in column mode
* Type in the text you want to enter. Dont be discouraged by the fact that only the first row is changed.
* Esc to apply your change (or alternately Ctrl+c)

You will now see your changed applied.

### Record and Play inside Vim ###

* Start recording by pressing q, followed by a lower case character to name the macro
* Perform any typical editing, actions inside Vim editor, which will be recorded
* Stop recording by pressing q
* Play the recorded macro by pressing @ followed by the macro name
* To repeat macros multiple times, press : NN @ macro name. NN is a number

### Paste from system clipboard ###

    "*p    Paste text from the system clipboard

(Note, this doesn't always work when pasting from a browser window)

### Text Wrapping ###

    :set wrap
    :set linebreak
    :set nolist

----------------------------------------------------


Plugins
-------
Notes on installed vim plugins.

### Search / File Navigation

#### ack

    Cmd+shift+f - :Ack

#### commandp

Quickly search a directory recursively for files.

    Command+T - Show CommandP search panel

### Movement

#### easymotion.vim

Quickly move around the current file


### Utilities

#### align

Plugin for aligning text objects.  Best practice is to use the menu included when using the graphical client.

    :AlignCtrl wp0p1 - setup alignment options
    :Align - align text given a range
    ,a,   : useful for breaking up comma-separated
            declarations prior to ,adec			|alignmap-a,|
    ,a(   : aligns ( and , (useful for prototypes)        *alignmap-a(*
    ,a?   : aligns (...)? ...:... expressions on ? and :	|alignmap-a?|
    ,a<   : aligns << and >> for c++			|alignmap-a<|
    ,a=   : aligns := assignments   			|alignmap-a=|
    ,abox : draw a C-style comment box around text lines
    ,acom : useful for aligning comments
    ,adcom: useful for aligning comments in declarations  |alignmap-adcom|
    ,anum : useful for aligning numbers
            NOTE: For the visual-mode use of ,anum, <vis.vim> is needed!
        See http://mysite.verizon.net/astronaut/vim/index.html#VIS
    ,aenum: align a European-style number
    ,aunum: align a USA-style number
    ,adec : useful for aligning declarations
    ,adef : useful for aligning definitions
    ,afnc : useful for aligning ansi-c style functions'
            argument lists				|alignmap-afnc|
    ,adcom: a variant of ,acom, restricted to comment
            containing lines only, but also only for
        those which don't begin with a comment.
        Good for certain declaration styles.
    ,aocom: a variant of ,acom, restricted to comment
            containing lines only
    ,tab  : align a table based on tabs			*alignmap-tab*
            (converts to spaces)
    ,tml  : useful for aligning the trailing backslashes
            used to continue lines (shell programming, etc)
    ,tsp  : use Align to make a table separated by blanks
            (left justified)
    ,ts,  : like ,t, but swaps whitespace on the right of *alignmap-ts,*
            the commas to their left
    ,ts:  : like ,t: but swaps whitespace on the right of *alignmap-ts:*
            the colons to their left
    ,ts<  : like ,t< but swaps whitespace on the right of *alignmap-ts<*
            the less-than signs to their left
    ,ts=  : like ,t= but swaps whitespace on the right of *alignmap-ts=*
            the equals signs to their left
    ,Tsp  : use Align to make a table separated by blanks
            (right justified)
    ,tsq  : use Align to make a table separated by blanks
            (left justified) -- "strings" are not split up
    ,tt   : useful for aligning LaTeX tabular tables
    ,Htd  : tabularizes html tables:
            <TR><TD> ...field... </TD><TD> ...field... </TD></TR>
    ,tx   : make a left-justified  alignment on
            character "x" where "x" is: ,:<=@|#
    ,Tx   : make a right-justified alignment on
            character "x" where "x" is: ,:<=@#
    ,m=   : like ,t= but aligns with %... style comments


#### fugitive

Plugin for working with git.

    ,gd :Gdiff<cr>
    ,gs :Gstatus<cr>
    ,gw :Gwrite<cr>
    ,ga :Gadd<cr>
    ,gb :Gblame<cr>
    ,gco :Gcheckout<cr>
    ,gci :Gcommit<cr>
    ,gm :Gmove<cr>
    ,gr :Gremove<cr>
    ,gl :Shell git gl -18<cr>:wincmd \|<cr>

#### gundo

Provides a graphical representation of the vim undo tree.

    F3 - custom mapping for toggling the undo tree

#### indent\_object

Provides an additional text object based on indentation levels.

    vai - select all text at current indentation level and line immediately above it
    vaI - same as above, but include line directly below as well
    vii - select all text at current indentation level (no line above)
    viI - select all text at current indentation level (no line below)

#### markdown.vim

Syntax highlighting for markdown.

#### nerdcommenter.vim

Insert comments into files.

    n  ,ca           <Plug>NERDCommenterAltDelims
    v  ,cA           <Plug>NERDCommenterAppend
    n  ,cA           <Plug>NERDCommenterAppend
    v  ,c$           <Plug>NERDCommenterToEOL
    n  ,c$           <Plug>NERDCommenterToEOL
    v  ,cu           <Plug>NERDCommenterUncomment
    n  ,cu           <Plug>NERDCommenterUncomment
    v  ,cn           <Plug>NERDCommenterNest
    n  ,cn           <Plug>NERDCommenterNest
    v  ,cb           <Plug>NERDCommenterAlignBoth
    n  ,cb           <Plug>NERDCommenterAlignBoth
    v  ,cl           <Plug>NERDCommenterAlignLeft
    n  ,cl           <Plug>NERDCommenterAlignLeft
    v  ,cy           <Plug>NERDCommenterYank
    n  ,cy           <Plug>NERDCommenterYank
    v  ,ci           <Plug>NERDCommenterInvert
    n  ,ci           <Plug>NERDCommenterInvert
    v  ,cs           <Plug>NERDCommenterSexy
    n  ,cs           <Plug>NERDCommenterSexy
    v  ,cm           <Plug>NERDCommenterMinimal
    n  ,cm           <Plug>NERDCommenterMinimal
    v  ,c<Space>     <Plug>NERDCommenterToggle
    n  ,c<Space>     <Plug>NERDCommenterToggle
    v  ,cc           <Plug>NERDCommenterComment
    n  ,cc           <Plug>NERDCommenterComment


#### nerdtree.vim

Alternate file browser plugin.

    ,n - toggle NERDTree file browser

#### nerdtree-tabs.vim

Additional behavior changes for the NERDTree plugin.

#### pathogen.vim

Plugin manager

#### plsql.vim

Syntax file for plsql files

#### quickbuf.vim

Pop-up a list of currently open buffers.

    ,b - show buffer list

#### rails.vim

Plugin for working with Rails.

#### scratch

#### solarized.vim

The last word in colorschemes.

    :ToggleBG - toggles between light and dark backgrounds

#### supertab.vim

Tab completion plugin.

#### surround.vim

Allows you to "surround" text with matching characters (e.g. parenthesis, brackets, etc.)

    ds"   delete surrounding quotes
    cs])  change bracket to parenthesis
    ysW(  surround parenthesis with a padding space
    s'    surround highlighted text with '
    yssb  surround line with ()
    S"    surrounds visually selected text with "

#### syntastic.vim

Syntax checking plugin for vim.

#### tagbar.vim

Source code browser that utilizes the exuberant ctags utility

#### taskpaper.vim

Syntax file and functions for taskpaper formatted files.

    ,td     Mark task as done
    ,tx     Mark task as cancelled
    ,tt     Mark task as today
    ,tD     Archive @done items
    ,tX     Show tasks marked as cancelled
    ,tT     Show tasks marked as today
    ,t/     Search for items including keyword
    ,ts     Search for items including tag
    ,tp     Fold all projects
    ,t.     Fold all notes
    ,tP     Focus on the current project
    ,tj     Go to next project
    ,tk     Go to previous project
    ,tg     Go to specified project
    ,tm     Move task to specified project

#### unimpaired.vim

Plugin that provides several pairs of bracket maps.

    [a* - previous
    ]a* - next
    [A* - first
    ]A* - last
    [b* - bprevious
    ]b* - bnext
    [B* - bfirst
    ]B* - blast
    [l* - lprevious
    ]l* - lnext
    [L* - lfirst
    ]L* - llast
    [q* - cprevious
    ]q* - cnext
    [Q* - cfirst
    ]Q* - clast


#### voom.vim

Outliner for vim.

#### webapi.vim

#### xptemplates.vim

Code snippets engine for vim.

    ctrl+r, ctrl+r, tab       show available snippets
    tab                       execute snippet

#### yankring

Clipboard history.

#### zoomwin

Zoom the current window.

### Database Utilities

#### sqlutilities.vim

Various utilities for working with SQL.

#### dbext

,se   Execute sql under cursor

### Syntax Highlighting

* vim-javascript
* vim-minitest
* vim-ruby
* coffeescript.vim
* less
* mustache
