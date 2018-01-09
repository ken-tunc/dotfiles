""" Set PATH
let s:path=system("source ~/.zshrc; echo echo VIMPATH'${PATH}' | $SHELL")
let $PATH=matchstr(s:path, 'VIMPATH\zs.\{-}\ze\n')

set lines=40
set columns=120
set colorcolumn=80
set guifont=Monaco:h13
set guioptions-=r
set guioptions-=L
set transparency=15
colorscheme molokai
