" Settings for editing wiki files.
setlocal encoding=utf-8
setlocal expandtab
setlocal matchpairs+=<:>
setlocal nomodeline
setlocal modelines=0

" Define folding based on wiki headings; start with all folds open.
setlocal foldlevel=20
setlocal foldmethod=expr
setlocal foldexpr=HeadingLevel(v:lnum)
if !exists("*HeadingLevel")
  function HeadingLevel(lnum)
    " n = number of consecutive '=' at start of line
    let n = strlen(substitute(getline(a:lnum), '[^=].*', '', ''))
    return (n == 0) ? '=' : '>' . n
  endfunction
endif

