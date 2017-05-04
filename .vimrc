""" Plugins
call plug#begin('~/.vim/plugged')
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'tomasr/molokai'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'Valloric/YouCompleteMe', {
  \ 'do': './install.py --clang-completer --tern-completer' }
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
  set colorcolumn=81
  set inccommand=split
  colorscheme molokai
endif

""" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

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

""" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

""" UltiSnips
let g:UltiSnipsUsePythonVersion = 2

""" YouCompleteMe
let g:ycm_key_invoke_completion = ''
let g:ycm_key_list_select_completion = []
let g:ycm_key_list_previous_completion = []
let g:ycm_global_ycm_extra_conf =
  \ '~/.vim/plugged/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
let g:ycm_python_binary_path = 'python3'
