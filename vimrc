set nocompatible
syntax on

filetype off
call pathogen#infect('bundle/{}', '~/.dotlocal/vim/bundle/{}')
filetype plugin indent on

set viminfo='50,<1000,s100,:0,n~/.viminfo

set history=1000
set showmatch
set matchtime=0
set shortmess=atI
set ruler
set showcmd
set notitle
set autoindent
set nobackup
set ch=1
set mousehide
set nofoldenable
set nowrap
set wildchar=^I
set ts=2
set sw=2
set et
set noerrorbells
set vb t_vb=
set printoptions=paper:letter
set modelines=5
set sidescroll=1
set sidescrolloff=3

" 256 colors in xterm and tmux
set t_Co=256
hi Search cterm=NONE ctermbg=220

" Change <Leader>
let mapleader = ","

" ` is more useful than ' but less accessible.
nnoremap ' `
nnoremap ` '

" Remap F2 to bring up the file browser.
map  <F2> :NERDTreeToggle
map! <F2> :NERDTreeToggle

" Cmd-[0-9] should switch tabs.
noremap <D-1> 1gt
noremap <D-2> 2gt
noremap <D-3> 3gt
noremap <D-4> 4gt
noremap <D-5> 5gt
noremap <D-6> 6gt
noremap <D-7> 7gt
noremap <D-8> 8gt
noremap <D-9> 9gt
noremap <D-9> 10gt
noremap <D-S-right> gt
noremap <D-S-left> gT

" Search options
set hlsearch
set incsearch
set ignorecase
set smartcase

" Wrap text in markdown files
autocmd BufEnter *.md set wrap|set linebreak|set nolist

" No syntax highlighting in FCS files
autocmd BufEnter *.fcs set wrap|syntax off

" Change the location for vim temporary files
set directory=~/.vimswap//

" Keep more lines of context
set scrolloff=3

" Move up/down by screen row instead of line
nmap j gj
nmap k gk

" Make backspace delete lots of things
set backspace=indent,eol,start

" Allow switching edited buffers without saving
set hidden

" Look for the file in the current directory, then south until you reach home.
set tags=tags;~/

" Quick timeouts on key combinations.
set timeoutlen=300 

" Who needs .gvimrc?
if has('gui_running')
  set encoding=utf-8
  set lines=66
  set columns=132
  set guifont=Consolas:h10
  "set guifont=Inconsolata\ Medium\ 11
  set novisualbell
end

" Catch trailing whitespace
set listchars=tab:>-,trail:-,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" Toggle highlighting
nmap <silent> <leader>q :silent :nohlsearch<CR>

" Fix command typos
nmap ; :

" Buffer management
nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>
nmap <C-d> :bw<CR>

" Scroll faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
vnoremap <C-e> 3<C-e>
vnoremap <C-y> 3<C-y>

" Bash-like filename completion
set wildmenu
set wildmode=list:longest

" Visual Studio project files are basically XML
au BufRead,BufNewFile *.proj set filetype=xml
au BufRead,BufNewFile *.vcxproj set filetype=xml

" This is slow, but it ensures that syntax highlights stay in sync.
au BufEnter * :syntax sync minlines=500

" Execute a command without the 'Press ENTER...' prompt.
command! -nargs=1 Silent
\ | execute ':silent !'.<q-args>
\ | execute ':redraw!'
"Convert between hex and decimal
command! -nargs=? -range Dec2hex call s:Dec2hex(<line1>, <line2>, '<args>')
function! s:Dec2hex(line1, line2, arg) range
  if empty(a:arg)
    if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
      let cmd = 's/\%V\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
    else
      let cmd = 's/\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
    endif
    try
      execute a:line1 . ',' . a:line2 . cmd
    catch
      echo 'Error: No decimal number found'
    endtry
  else
    echo printf('%x', a:arg + 0)
  endif
endfunction

command! -nargs=? -range Hex2dec call s:Hex2dec(<line1>, <line2>, '<args>')
function! s:Hex2dec(line1, line2, arg) range
  if empty(a:arg)
    if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
      let cmd = 's/\%V0x\x\+/\=submatch(0)+0/g'
    else
      let cmd = 's/0x\x\+/\=submatch(0)+0/g'
    endif
    try
      execute a:line1 . ',' . a:line2 . cmd
    catch
      echo 'Error: No hex number starting "0x" found'
    endtry
  else
    echo (a:arg =~? '^0x') ? a:arg + 0 : ('0x'.a:arg) + 0
  endif
endfunction
 
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

" Open the CtrlP plugin with Leader-t.
let g:ctrlp_working_path_mode = 0
nmap <silent> <leader>t :CtrlP<CR>

" Rewrap the current paragraph with Leader-r.
nnoremap <silent> <leader>r gq}

" vim: set ts=2 sw=2 et:
