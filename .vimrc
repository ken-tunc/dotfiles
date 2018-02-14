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

""" Commands
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep('git grep --line-number '.shellescape(<q-args>), 0, <bang>0)

if executable('ag')
  " :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
  " :Ag! - Start fzf in fullscreen and display the preview window above
  command! -bang -nargs=* Ag
    \ call fzf#vim#ag(<q-args>,
    \                 <bang>0 ? fzf#vim#with_preview('up:60%')
    \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
    \                 <bang>0)
endif

""" Filetype recognition
let g:tex_flavor = 'latex'

""" vim-airline
let g:airline_theme = 'minimalist'

""" UltiSnips
let g:UltiSnipsUsePythonVersion = 2

""" YouCompleteMe
let g:ycm_key_invoke_completion = ''
let g:ycm_key_list_select_completion = []
let g:ycm_key_list_previous_completion = []
let g:ycm_python_binary_path = 'python3'
