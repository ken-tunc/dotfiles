""" Plugins
call plug#begin('~/.vim/plugged')
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'maralla/completor.vim', { 'do': 'make js' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tomasr/molokai'
Plug 'w0rp/ale'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
call plug#end()

""" Edit
set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent
set backspace=indent,eol,start
set encoding=utf-8

""" UI
set laststatus=2
set mouse=a
set number
set showcmd
set showmatch
set ruler
set wildmenu
if has('nvim')
  set inccommand=split
endif

""" Search
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan

""" Files
set directory=~/Library/Caches/vim/swap
set backup
set backupdir=~/Library/Caches/vim/backup
set undofile
set undodir=~/Library/Caches/vim/undo
for d in [&directory, &backupdir, &undodir]
  if !isdirectory(d)
    call mkdir(iconv(d, &encoding, &termencoding), 'p')
  endif
endfor

""" Filetype recognition
let g:tex_flavor = 'latex'

""" completor.vim
let g:completor_python_binary = '/usr/local/bin/python3'
