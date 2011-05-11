

" Generate rtf and open in default viewer
function! CreateRTF()
  execute 'silent ! pandoc  -f markdown -t rtf -s -o \%TEMP\%\/%:t:r:s,$,.rtf, "%"'
  execute 'silent ! \%TEMP\%\/%:t:r:s,$,.rtf,'
endfunction

command! CreateRTF :call CreateRTF()

" Map Alt-Shift-P to run markdown to pdf against the current document and
" open the resulting document
function! CreatePDF()
  execute 'silent ! markdown2pdf "%" -o \%TEMP\%\/%:t:r:s,$,.pdf,'
  execute 'silent ! \%TEMP\%\/%:t:r:s,$,.pdf,'
endfunction

command! CreatePDF :call CreatePDF()
" nmap <silent> <A-P> :call Pandoc()<CR>
