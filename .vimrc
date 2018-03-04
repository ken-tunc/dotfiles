""" Plugins
call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'google/yapf', { 'rtp': 'plugins/vim', 'for': 'python' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-signify'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tomasr/molokai'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --js-completer' }
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
call plug#end()

if !has('nvim')
  packadd! matchit
endif

""" Edit
set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent
set backspace=indent,eol,start
set encoding=utf-8

""" UI
set laststatus=2
set lazyredraw
set mouse=a
set noshowmode
set number
set showcmd
set showmatch
set ruler
set wildmenu
if has('nvim')
  set inccommand=split
endif
colorscheme molokai

""" Search
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan

""" Files
if !has('nvim')
  set viminfo+=n~/Library/Caches/vim/viminfo
endif
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

""" Key mappings
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

""" Filetype recognition
let g:tex_flavor = 'latex'

""" vim-airline
let g:airline_theme = 'minimalist'

""" YouCompleteMe
let g:ycm_key_invoke_completion = ''
let g:ycm_key_list_select_completion = []
let g:ycm_key_list_previous_completion = []
