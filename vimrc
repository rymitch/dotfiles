call plug#begin('~/.vim/plugged')
if !has('nvim')
  Plug 'tpope/vim-sensible'
endif
Plug 'bling/vim-bufferline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'morhetz/gruvbox'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

filetype plugin indent on
syntax enable

colorscheme gruvbox
autocmd ColorScheme * highlight! Normal ctermbg=NONE guibg=NONE
set bg=light

" Change <Leader>
let mapleader=","

" Quick timeouts on key combinations.
set timeoutlen=300

" Set some basic global defaults.
if !has('nvim')
  set viminfo='50,<1000,s100,:0,n~/.viminfo
endif
set notitle
set nobackup
set mousehide
set nofoldenable
set nojoinspaces
set nowrap
set wildchar=^I
set ts=2
set sw=2
set et
set noerrorbells
set vb t_vb=
set modeline
set modelines=5
set sidescroll=1
set sidescrolloff=3
set autoindent

" Search options
set hlsearch
set incsearch
set ignorecase
set smartcase

" Move up/down by screen row instead of line.
nmap j gj
nmap k gk

" Allow switching edited buffers without saving.
set hidden

" Use the system clipboard.
set clipboard^=unnamedplus

" ` is more useful than ' but less accessible.
nnoremap ' `
nnoremap ` '

" Toggle highlighting.
nmap <silent> <leader>q :silent :nohlsearch<CR>

" Fix command typos.
nmap ; :

" Buffer management
nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>
nmap <C-d> :bw<CR>

" Scroll better.
set scrolloff=3
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
vnoremap <C-e> 3<C-e>
vnoremap <C-y> 3<C-y>

" Wrap text in Markdown files.
autocmd BufEnter *.md set wrap linebreak nolist nofoldenable tw=72

" Visual Studio project files are basically XML.
au BufRead,BufNewFile *.proj set filetype=xml
au BufRead,BufNewFile *.vcxproj set filetype=xml

" C-like files
au BufRead,BufNewFile *.cs set ts=4 et sw=4 sts=4 tw=72 ai
au BufRead,BufNewFile *.cpp set ts=4 et sw=4 sts=4 tw=72 ai

" This is slow, but it ensures that syntax highlights stay in sync.
au BufEnter * :syntax sync minlines=500

" Configure airline.
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_theme = 'light'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline#extensions#bufferline#enabled = 0

" Configure bufferline.
let g:bufferline_echo = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#buffer_min_count = 2

" Configure ctrlp.
let g:ctrlp_working_path_mode = 'ra'
nmap <silent> <leader>t :CtrlP<CR>
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" Rewrap the current paragraph with Leader-r.
nnoremap <silent> <leader>r gq}

" Find common non-ASCII characters.
nmap <silent> <leader>u /\([‘’”“—…·‬‭  ]\\| \+$\)<CR>

" vim: set ts=2 sw=2 et:
