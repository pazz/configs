if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

"--------------
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red
" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set textwidth=79 " Wrap text after a certain number of characters
set fileformat=unix
" For full syntax highlighting:
let python_highlight_all=1
syntax on

"indentation
filetype indent on
set autoindent

" Folding 
"set foldmethod=indent
set foldmethod=indent
set foldlevel=5
set foldnestmax=5
set fillchars=stl:_,stlnc:-,vert:\|,fold:\ ,diff:- 
"----------------------------------
"setlocal cinkeys-=0#
"setlocal indentkeys-=0#
"setlocal include=^\\s*\\(from\\\|import\\)
"setlocal includeexpr=substitute(v:fname,'\\.','/','g')
"setlocal suffixesadd=.py
"setlocal comments-=:%
setlocal commentstring=//%s

setlocal omnifunc=javacomplete#Complete
setlocal shellpipe=2>
set makeprg=javac\ %
"set errorformat=%A:%f:%l:\ %m,%-Z%p^,%-C%.%#
setlocal errorformat=%f:%l:%m


