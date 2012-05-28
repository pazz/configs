filetype plugin indent on

if has('syntax') && (&t_Co > 2)
   syntax on
   set foldmethod=syntax
endif
" ??
"
"set t_Co=256
colorscheme solarized
set background=dark
highlight   ShowMarksHLl ctermfg=white ctermbg=black cterm=bold
highlight   ShowMarksHLu ctermfg=white ctermbg=black cterm=bold
highlight   ShowMarksHLo ctermfg=white ctermbg=black cterm=bold
highlight   ShowMarksHLm ctermfg=white ctermbg=black cterm=bold
"#hi Conceal       ctermbg=None "conceal..

set guioptions=''
set incsearch

let Tlist_Auto_Update = 1     " Always call ctags when opening files/changing directories?
let Tlist_Close_On_Select = 1 " Close the taglist window when a file or tag is selected.
let Tlist_Compart_Format = 1 " Remove extra information and blank lines from the taglist window.
let Tlist_Enable_Fold_Column = 1 " Don't Show the fold indicator column in the taglist window.
let Tlist_GainFocus_On_ToggleOpen = 1 " Jump to taglist window on open.
let Tlist_Process_File_Always = 1   " call ctags even if taglist is closed?
let Tlist_Auto_Highlight_Tag = 1    " Highlight when entering a buffer?
let Tlist_WinWidth = 40


"menu for tabcompletion in file open
set wildmenu " turn on command line completion wild style
set wildignore=*.o,*.pyc,*.jpg,*.gif,*.png
set wildmode=list:longest " turn on wild mode huge list

set hidden " you can change buffers without saving
set backspace=indent,eol,start " make backspace a more flexible

"handle tabs
set expandtab
set tabstop=8  
set shiftwidth=4
set softtabstop=2

"indents
set autoindent
set smartindent

set enc=utf-8  "internal encoding
set fenc=utf-8 "file enc
set tenc=utf-8 "term enc


" Fast window resizing with +/- keys (horizontal); / and * keys (vertical)
if bufwinnr(1)
 map <kPlus> <c-W>+
 map <kMinus> <c-W>-
 map <kDivide> <c-w><
 map <kMultiply> <c-w>>
endif

set pastetoggle=<c-P>
nmap ,l :set list!<CR>

"set ruler
:map <F4> :setlocal spell! spelllang=de<cr>
:map <F10> :setlocal spell! spelllang=en_gb<cr>
:map <c-F10> :r !/usr/bin/tranlate-de-en <cword> <cr>
:map <c-F12> :cw<cr>
:map <s-c-F12> :ccl<cr>
:map <F2> :bp<cr>
:map <F3> :bn<cr>
noremap <F9> :TlistToggle<cr>

"folding
nnoremap <c-@> za
nnoremap <c-up> zc
nnoremap <c-down> zo
vnoremap <c-space> zf

"remap supertab
"#let g:SuperTabMappingForward = '<c-@>'
"#let g:SuperTabMappingBackward = '<s-c-@>'

" remap j and k to scroll by visual lines
nnoremap j gj
nnoremap k gk

set updatetime=4000
set undofile
set undodir=~/.vim/undodir


set textwidth=100

" for latex-suite:
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

" make easytags work with atp
let g:easytags_updatetime_autodisable=1
