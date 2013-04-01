" Personal sql snippets file
XPTemplate priority=personal

" containers
let s:f = g:XPTfuncs()

XPTinclude
      \ _common/common

" Issue the following query to show information about the protection mode,
" the protection level, the role of the database, and switchover status:

" Change a user's password and re-encrypt it.
" Modified from: http://www.peoplesoftwiki.com/update-user-password

XPT change_peoplesoft_password " Prints the MIT License
update PSOPRDEFN
   set OPERPSWD  = `password^
     , ENCRYPTED = 0
 where OPRID     = '`oprid^';

encrypt_password YOUR_USER_OPRID;


" Save this file as ~/.vim/ftplugin/c/hello.xpt.vim(or
" ~/vimfiles/ftplugin/c/hello.xpt.vim).
" Then you can use it in C language file:
"     vim xpt.c
" And type:
"     helloxpt<C-\>
"
XPTemplate priority=personal+

XPT helloxpt " tips about what this snippet do
Say hello to `xpt^.
`xpt^ says hello.
