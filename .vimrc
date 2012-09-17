"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Addon Manager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" list of plugns to activate
let s:pluglist = [
\'Solarized',
\'tlib',
\'github:tomtom/viki_vim',
\'github:ervandew/supertab',
\'Python-mode-klen',
\'snipmate', 'snipmate-snippets',
\'fugitive',
\'matchit.zip',
\'git:git://atp-vim.git.sourceforge.net/gitroot/atp-vim/atp-vim',
\'github:Lokaltog/vim-powerline',
\]
"
let notused = [
\'LaTeX_Box',
\'github:LaTeX-Box-Team/LaTeX-Box',
\'AutomaticLaTeXPlugin',
\'LaTeX-Suite_aka_Vim-LaTeX',
\'pyflakes%2441',
\]

" setup VAM
" this bit is taken from the VAM docs
fun! EnsureVamIsOnDisk(vam_install_path)
  if !filereadable(a:vam_install_path.'/vim-addon-manager/.git/config')
     \&& 1 == confirm("Clone VAM into ".a:vam_install_path."?","&Y\n&N")
    call mkdir(a:vam_install_path, 'p')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '.shellescape(a:vam_install_path, 1).'/vim-addon-manager'
    exec 'helptags '.fnameescape(a:vam_install_path.'/vim-addon-manager/doc')
  endif
endf

fun! SetupVAM()
  " Set advanced options like this:
  " let g:vim_addon_manager = {}
  " let g:vim_addon_manager['key'] = value

  " Example: drop git sources unless git is in PATH. Same plugins can
  " be installed from www.vim.org. Lookup MergeSources to get more control
  " let g:vim_addon_manager['drop_git_sources'] = !executable('git')

  " VAM install location:
  let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
  call EnsureVamIsOnDisk(vam_install_path)
  exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'
  " Tell VAM which plugins to fetch & load:
  silent call vam#ActivateAddons(s:pluglist, {'auto_install' : 0, 'shell_commands_run_method': 'system'})
  " sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})

  " Addons are put into vam_install_path/plugin-name directory
  " unless those directories exist. Then they are activated.
  " Activating means adding addon dirs to rtp and do some additional
  " magic

  " How to find addon names?
  " - look up source from pool
  " - (<c-x><c-p> complete plugin names):
  " You can use name rewritings to point to sources:
  "    ..ActivateAddons(["github:foo", .. => github://foo/vim-addon-foo
  "    ..ActivateAddons(["github:user/repo", .. => github://user/repo
  " Also see section "2.2. names of addons and addon sources" in VAM's documentation
endfun
call SetupVAM()
" experimental [E1]: load plugins lazily depending on filetype, See
" NOTES
" experimental [E2]: run after gui has been started (gvim) [3]
" option1:  au VimEnter * call SetupVAM()
" option2:  au GUIEnter * call SetupVAM()
" See BUGS sections below [*]
" Vim 7.0 users see BUGS section [3]


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" general settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme solarized
set background=light

filetype plugin indent on
syntax on

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

set undofile
set undodir=~/.vim/undodir

set textwidth=100


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set pastetoggle=<c-P>
:map <F4> :setlocal spell! spelllang=de<cr>
:map <F3> :setlocal spell! spelllang=en_gb<cr>

" remap j and k to scroll by visual lines
nnoremap j gj
nnoremap k gk


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Supertab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
"let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabContextDefaultCompletionType = "<c-o>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ATP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set iskeyword+=:
"
let g:Tex_Leader = '#'
let g:Tex_DefaultTargetFormat = 'pdf'
let b:atp_Viewer = 'zathura'
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode --enable-write18 $*'
let b:atp_TexCompiler = "pdflatex"
let b:atp_TexFlavor = "latex"
let b:atp_ProjectScript = 0

let g:Tex_AutoFolding = 0
let g:Tex_Folding = 0

set winaltkeys=no


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 let g:pymode_lint_write = 0
 autocmd FileType python map <F5> :PyLint<cr>
 autocmd FileType python map <F6> :PyLintAuto<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIKI 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vikiHomePage = "/home/pazz/repo/wiki/index.viki"
"let g:vikiFamily = "anyword"
let g:vikiOpenFileWith_ANY   = "silent !gnome-open %{FILE}"
"let g:vikiMapLeader = "<LocalLeader>w"
let g:vikiMapLeader = "?"
let g:deplatePrg = "deplate -x -X -d html/"
au FileType viki compiler deplate
let g:vikiFancyHeadings = 1
"nmap <space> :VikiFindNext<cr>
"nmap <S-space> :VikiFindPrevious<cr>

au FileType viki compiler deplate
autocmd! BufRead,BufNewFile *.viki set filetype=viki
au FileType tex let b:vikiFamily="LaTeX"
let g:vikiNameSuffix=".viki"

let g:viki_intervikis = {}
"call viki#Define('BIB', $HOME."/repo/bib/notes", ".viki")
"autocmd BufWritePost /home/pazz/repo/bib/notes/*.viki execute '!git add % && git commit -m %'
let g:viki_intervikis['V']  = [$HOME."/repo/wiki", ".viki"]

autocmd BufNewFile /home/pazz/repo/wiki/*\d\d\d\d.viki exe "normal OBIBSKEL\<tab>"
autocmd BufWritePre /home/pazz/repo/wiki/*.viki silent! cd %:h
autocmd BufWritePost /home/pazz/repo/wiki/*.viki execute '!git add % && git commit -m %'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Powerline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs
let g:Powerline_symbols = 'unicode'
"let g:Powerline_symbols = 'fancy'
"let g:Powerline_dividers_override = ['▙', '▚', '▟', '▞']
let g:Powerline_dividers_override = ['▙', '╲', '▟', 'y╱']
"⛕ ❯⟪􏿽
