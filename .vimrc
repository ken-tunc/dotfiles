""" Edit
set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent
set backspace=indent,eol,start
set encoding=utf-8
filetype plugin indent on

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
syntax enable

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
