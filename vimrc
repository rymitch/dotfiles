call plug#begin('~/.vim/plugged')
if !has('nvim')
  Plug 'tpope/vim-sensible'
endif
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/tango.vim'
call plug#end()

filetype plugin indent on
colorscheme tango
syntax enable

" Line numbering
set nu
highlight LineNr ctermbg=255 ctermfg=101

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
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#buffer_min_count = 2

" Configure ALE
let g:ale_sign_column_always = 1
let g:ale_sign_error = '▶▶'
let g:ale_sign_warning = '▶▶'
highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight SignColumn ctermbg=255 ctermfg=Green
highlight ALEErrorSign ctermbg=255 ctermfg=Red
highlight ALEWarningSign ctermbg=255 ctermfg=DarkYellow

" Configure file finder
nmap <silent> <leader>t :GFiles<CR>

" Rewrap the current paragraph with Leader-r.
nnoremap <silent> <leader>r gq}

" Find common non-ASCII characters.
nmap <silent> <leader>u /\([‘’”“—…·®ﬁ​‬‭  ]\\| \+$\)<CR>

" vim: set ts=2 sw=2 et:
