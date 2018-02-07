execute pathogen#infect()
syntax on
filetype plugin indent on

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

" ` is more useful than ' but less accessible.
nnoremap ' `
nnoremap ` '

" Catch trailing whitespace.
let g:better_whitespace_enabled = 0
nmap <silent> <leader>s :ToggleWhitespace<CR>

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
autocmd BufEnter *.md set wrap|set linebreak|set nolist|set nofoldenable

" No syntax highlighting in FCS files.
autocmd BufEnter *.fcs set wrap|syntax off

" Visual Studio project files are basically XML.
au BufRead,BufNewFile *.proj set filetype=xml
au BufRead,BufNewFile *.vcxproj set filetype=xml

au BufRead,BufNewFile *.cpp set ts=4 et sw=4 sts=4 tw=72 ai

" This is slow, but it ensures that syntax highlights stay in sync.
au BufEnter * :syntax sync minlines=500

" Configure airline.
let g:airline_theme = 'light'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#bufferline#enabled = 0

" Configure bufferline.
let g:bufferline_echo = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#buffer_min_count = 2

" Configure minizinc highlighting.
let zinc_no_highlight_overlong = 1

" Configure ctrlp.
let g:ctrlp_working_path_mode = 'ra'
nmap <silent> <leader>t :CtrlP<CR>
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" Paste from the clipboard with leader-v.
function! GetClipMac()
  execute ':r! pbpaste'
endfunction
function! GetClipWin()
  let reg_save = @@
  let @@ = join(readfile('/dev/clipboard'), "\n")
  setlocal paste
  exe 'normal p'
  setlocal nopaste
  let @@ = reg_save
endfunction
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    nnoremap <silent> <leader>v :call GetClipMac()<CR>
  else
    nnoremap <silent> <leader>v :call GetClipWin()<CR>
  endif
endif

"Copy to system clipboard.
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

"Paste from system clipboard.
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Rewrap the current paragraph with Leader-r.
nnoremap <silent> <leader>r gq}

" Turn on e-prime syntax highlighting.
nmap <silent> <leader>e :set syntax=e-prime<CR>

" Find common non-ASCII characters.
nmap <silent> <leader>u /\([‘’”“—…·‬‭]\\| \+$\)<CR>

" vim: set ts=2 sw=2 et:
